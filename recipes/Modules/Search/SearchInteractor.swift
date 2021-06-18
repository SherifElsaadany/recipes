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
    
    init(webService: WebServiceProtocol) {
        self.webService = webService
    }
    
    func downloadImage(from url: String?, at index: Int) {
        guard let imageUrl = url else {return}
        webService?.downloadImage(from: imageUrl, completion: { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.recipeResults?[index].image = data
                self?.presenter?.downloadImageDidSuccess(at: index)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

//MARK:- InteractorToPresenterSearchProtocol
extension SearchInteractor: PresenterToInteractorSearchProtocol {
    
    func loadSearchResults(for query: String) {
        webService?.searchRecipes(of: query, completion: { [weak self] (result) in
            switch result {
            case .success(let recipes):
                
                self?.recipes = recipes
                self?.recipeResults = recipes.hits?.map {RecipeResult(recipe: $0.recipe) }
                self?.presenter?.searchDidSuccess(result: self?.recipeResults)
            case .failure(let error):
                self?.presenter?.searchDidFail(error: error.localizedDescription)
            }
        })
    }
    
    func getSearchResult(at index: Int) -> RecipeResult? {
        let result = recipeResults?[index]
        
        if result?.image == nil {
            let imageUrl = recipes?.hits?[index].recipe?.image
            self.downloadImage(from: imageUrl, at: index)            
        }
        
        return result
    }
    
}
