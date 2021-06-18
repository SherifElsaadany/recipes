//
//  RecipeResult.swift
//  recipes
//
//  Created by Elsaadany on 18/06/2021.
//

import Foundation

struct RecipeResult {
    let title: String?
    var image: Data?
    let source: String?
    let healthLabels: [String]?
    
    init(recipe: Recipe?) {
        self.title = recipe?.label
        self.source = recipe?.source
        self.healthLabels = recipe?.healthLabels
    }
}
