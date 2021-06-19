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
    
}

//MARK:- PresenterToViewSearchProtocol
extension SearchPresenter: ViewToPresenterSearchProtocol {
    
    func search(for query: String) {
        interactor?.loadSearchResults(for: query)
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
        
    }

}

//MARK:- InteractorToPresenterSearchProtocol
extension SearchPresenter: InteractorToPresenterSearchProtocol {
    
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
