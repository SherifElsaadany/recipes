//
//  SearchPresenter.swift
//  recipes
//
//  Created by Elsaadany on 18/06/2021.
//

import Foundation

class SearchPresenter {
    
    weak var view: PresenterToViewSearchProtocol?
    var interactor: PresenterToInteractorSearchProtocol?
    var router: RouterSearchProtocol?
    
    var numberOfRows: Int?
    var numberOfCollectionViewItems: Int?
    
    var query: String?
    
    func handleSearchOptions(for query: String, and filterIndex: Int) {
        if filterIndex == 0 {
            interactor?.loadSearchResults(for: query)
        } else {
            interactor?.filterResults(of: query, filterIndex: filterIndex)
        }
    }
    
}

//MARK:- PresenterToViewSearchProtocol
extension SearchPresenter: ViewToPresenterSearchProtocol {
    
    func viewDidLoad() {
        interactor?.loadFilterItems()
    }
    
    func filterItem(at index: Int) -> String? {
        let title = interactor?.getFilterItem(at: index).rawValue.capitalized.replacingOccurrences(of: "-", with: " ")
        return title
    }

    func search(for query: String, at filterIndex: Int) {
        self.query = query
        
        handleSearchOptions(for: query, and: filterIndex)
    }
    
    func resultCell(at index: Int) -> RecipeResult? {
        let result = interactor?.getSearchResult(at: index)
        let cellData = result.map { RecipeResult(recipe: $0)}
        return cellData
    }
    
    func didDisplayLastRow() {
        view?.showFooterIndicator()
        guard !(interactor!.isFetchingPage) else {return}
        self.interactor?.loadNextPage()
    }
    
    func didSelectRowAt(index: Int) {
        guard let recipe = interactor?.getSearchResult(at: index) else {return}
        router?.pushToRecipeDetails(with: recipe)
    }
    
    func didSelectFilterItemAt(index: Int) {
        
        guard let query = self.query else {return}
        
        handleSearchOptions(for: query, and: index)
    }

}

//MARK:- InteractorToPresenterSearchProtocol
extension SearchPresenter: InteractorToPresenterSearchProtocol {
    func didLoadFilterItems(count: Int) {
        self.numberOfCollectionViewItems = count
        view?.loadCollectionView()
    }
    
    func fetchDidRetrieve(count: Int?) {
        guard count ?? 0 > 0 else {
            view?.hideTableView()
            return
        }
        
        self.numberOfRows = count
        view?.updateResultsView()
        view?.hideFooterIndicator()
    }
    
    func fetchDidFail(error: String) {
        view?.showAlertMessage(error: error)
        view?.hideFooterIndicator()
    }
    
    func noMorePages() {
        view?.hideFooterIndicator()
    }
}
