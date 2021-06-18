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
        return interactor?.getSearchResult(at: index)
    }
    
    func didSelectRowAt(index: Int) {
        
    }

}

//MARK:- InteractorToPresenterSearchProtocol
extension SearchPresenter: InteractorToPresenterSearchProtocol {

    func searchDidSuccess(result: [RecipeResult]?) {
        
        guard result?.count ?? 0 > 0 else {return}
        self.numberOfRows = result?.count
        
        view?.updateResultsView()
    }
    
    func searchDidFail(error: String) {
        view?.showAlertMessage(error: error)
    }
    
    func downloadImageDidSuccess(at index: Int) {
        view?.updateImage(at: index)
    }
 
}
