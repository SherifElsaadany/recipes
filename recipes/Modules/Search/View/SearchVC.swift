//
//  SearchVC.swift
//  recipes
//
//  Created by Elsaadany on 17/06/2021.
//

import UIKit

class SearchVC: UIViewController {
    
    var presenter: ViewToPresenterSearchProtocol?

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var recipesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionview()
        configureTableView()
        configureSearchBar()
    }
    
}

//MARK:- Methods
extension SearchVC {
    func configureTableView() {
        self.recipesTableView.delegate = self
        self.recipesTableView.dataSource = self
        registerTableViewCells()
    }
    
    func configureCollectionview() {
        self.filterCollectionView.delegate = self
        self.filterCollectionView.dataSource = self
        self.registerCollectionViewCells()
    }
    
    func registerTableViewCells() {
        recipesTableView.register(UINib(nibName: RecipeCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: RecipeCell.reuseIdentifier)
    }
    
    func registerCollectionViewCells() {
        filterCollectionView.register(FilterCell.self, forCellWithReuseIdentifier: FilterCell.reuseIdentifier)
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
        presenter?.search(for: query)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
}

//MARK:- CollectionView
extension SearchVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.reuseIdentifier, for: indexPath) as! FilterCell
        cell.title.text = "\(indexPath.row)"
        return cell
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
    
    
}

//MARK:- PresenterToViewSearchProtocol
extension SearchVC: PresenterToViewSearchProtocol {
    
    func updateResultsView() {
        self.recipesTableView.reloadData()
    }
    
    func updateImage(at index: Int) {
        recipesTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
    }
    
    func showAlertMessage(error: String) {
        
    }
    
    func showHUD() {
        
    }
    
    func hideHUD() {
        
    }
    
    
}
