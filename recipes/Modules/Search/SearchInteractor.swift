//
//  SearchInteractor.swift
//  recipes
//
//  Created by Elsaadany on 18/06/2021.
//

import Foundation

class SearchInteractor {
    
    weak var presenter: InteractorToPresenterSearchProtocol?
    
    var webService: WebServiceProtocol?
    
    var recipes: Recipes?
    
    var recipeResults: [RecipeResult]?
    
    var isFetchingPage: Bool = false
    
    init(webService: WebServiceProtocol) {
        self.webService = webService
    }
    
    func mergeOldResults(with newResult: Recipes) {
        var hits = self.recipes?.hits
        if let newHits = newResult.hits {
            hits?.append(contentsOf: newHits)
        }
        
        self.recipes = newResult
        self.recipes?.hits = hits
    }
}

//MARK:- InteractorToPresenterSearchProtocol
extension SearchInteractor: PresenterToInteractorSearchProtocol {
    
    func loadSearchResults(for query: String) {
        webService?.searchRecipes(of: query, completion: { [weak self] (result) in
            switch result {
            case .success(let recipes):
                
                self?.recipes = recipes
                self?.presenter?.fetchDidRetrieve(count: recipes.hits?.count)
            case .failure(let error):
                self?.presenter?.fetchDidFail(error: error.localizedDescription)
            }
        })
    }
    
    func getSearchResult(at index: Int) -> Recipe? {
        let result = recipes?.hits?[index].recipe
        return result
    }
    
    func loadNextPage() {
        guard let nextPageUrl = recipes?.links?.next?.href else {
            presenter?.noMorePages()
            return
        }
        
        isFetchingPage = true
        webService?.getNextPage(of: nextPageUrl, completion: { [weak self] (result) in
            self?.isFetchingPage = false
            switch result {
            case .success(let recipes):
                self?.mergeOldResults(with: recipes)
                self?.presenter?.fetchDidRetrieve(count: self?.recipes?.hits?.count)
            case .failure(let error):
                self?.presenter?.fetchDidFail(error: error.localizedDescription)
            }
        })
    }
}
