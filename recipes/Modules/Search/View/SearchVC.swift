//
//  SearchVC.swift
//  recipes
//
//  Created by Elsaadany on 17/06/2021.
//

import UIKit

class SearchVC: UIViewController {
    
    var presenter: ViewToPresenterSearchProtocol?
    
    var selectedCellIndexpth = IndexPath(item: 0, section: 0)

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var recipesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionview()
        configureTableView()
        configureSearchBar()
        self.presenter?.viewDidLoad()
    }
    
}

//MARK:- Methods
extension SearchVC {
    func configureTableView() {
        self.recipesTableView.delegate = self
        self.recipesTableView.dataSource = self
        registerTableViewCells()
        addFooterIndicator()
    }
    
    func addFooterIndicator() {
        let footerLabel = UILabel()
        footerLabel.text = "Loading..."
        footerLabel.textAlignment = .center
        footerLabel.backgroundColor = .green
        recipesTableView.tableFooterView = footerLabel
    }
    
    func configureCollectionview() {
        self.filterCollectionView.delegate = self
        self.filterCollectionView.dataSource = self
        self.registerCollectionViewCells()
        self.setCollectionViewInsets()
    }
    
    func registerTableViewCells() {
        recipesTableView.register(UINib(nibName: RecipeCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: RecipeCell.reuseIdentifier)
    }
    
    func registerCollectionViewCells() {
        filterCollectionView.register(FilterCell.self, forCellWithReuseIdentifier: FilterCell.reuseIdentifier)
    }
    
    func setCollectionViewInsets() {
        self.filterCollectionView.contentInset = UIEdgeInsets.zero
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
    }
}

//MARK:- UISearchBarDelegate
extension SearchVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let query = searchBar.text ?? ""
        presenter?.search(for: query, at: selectedCellIndexpth.row)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
    func setCellSelection(status: Bool, at indexPath: IndexPath) {
        if let cell = filterCollectionView.cellForItem(at: indexPath) as? FilterCell {
            cell.isSelected = status
        }
    }
}

//MARK:- CollectionView
extension SearchVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfCollectionViewItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.reuseIdentifier, for: indexPath) as! FilterCell
        cell.titleLabel.text = self.presenter?.filterItem(at: indexPath.row)
        cell.isSelected = indexPath.row == 0 ? true : false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 4
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath != selectedCellIndexpth else {return}
        
        setCellSelection(status: false, at: selectedCellIndexpth)
        selectedCellIndexpth = indexPath
        
        self.presenter?.didSelectFilterItemAt(index: indexPath.row)
    }
}

//MARK:- TableView
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.reuseIdentifier, for: indexPath) as! RecipeCell
        cell.configure(result: presenter?.resultCell(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.didSelectRowAt(index: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (recipesTableView.contentOffset.y + 1) >= (recipesTableView.contentSize.height - recipesTableView.frame.size.height) {
            
            self.presenter?.didDisplayLastRow()
        }
    }
}

//MARK:- PresenterToViewSearchProtocol
extension SearchVC: PresenterToViewSearchProtocol {
    
    func loadCollectionView() {
        self.filterCollectionView.reloadData()
    }
    
    func updateResultsView() {
        recipesTableView.isHidden = false
        self.recipesTableView.reloadData()
    }
    
    
    func hideTableView() {
        recipesTableView.isHidden = true
    }
    
    func showAlertMessage(error: String) {
        
    }
    
    func showHUD() {
        
    }
    
    func hideHUD() {
        
    }
    
    func showFooterIndicator() {
        recipesTableView.tableFooterView?.bounds.size.height = 50
    }
    
    func hideFooterIndicator() {
        recipesTableView.tableFooterView?.bounds.size.height = 0
    }

}
