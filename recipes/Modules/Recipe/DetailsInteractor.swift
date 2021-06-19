//
//  DetailsInteractor.swift
//  recipes
//
//  Created by Elsaadany on 19/06/2021.
//

import Foundation

class DetailsInteractor {
    var presenter: InteractorToPresenterDetailsProtocol?
    
    var recipe: Recipe?
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
}

//MARK:- PresenterToInteractorDetailsProtocol
extension DetailsInteractor: PresenterToInteractorDetailsProtocol {
    
    func getRecipe() {
        presenter?.fetchDidRetrieve(details: self.recipe)
    }
    
    func getRecipeUrl() -> String? {
        return recipe?.url
    }
}
