//
//  Recipes.swift
//  recipes
//
//  Created by Elsaadany on 18/06/2021.
//

import Foundation

// MARK: - Recipes
struct Recipes: Codable {
    var from, to, count: Int?
    var links: RecipesLinks?
    var hits: [Hit]?

    enum CodingKeys: String, CodingKey {
        case from, to, count
        case links = "_links"
        case hits
    }
}

// MARK: - Hit
struct Hit: Codable {
    var recipe: Recipe?
    var links: HitLinks?

    enum CodingKeys: String, CodingKey {
        case recipe
        case links = "_links"
    }
}

// MARK: - HitLinks
struct HitLinks: Codable {
    var linksSelf: Next?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - Next
struct Next: Codable {
    var href: String?
    var title: String?
}

// MARK: - Recipe
struct Recipe: Codable {
    var label: String?
    var image: String?
    var source: String?
    var url: String?
    var healthLabels, ingredientLines: [String]?
}

// MARK: - RecipesLinks
struct RecipesLinks: Codable {
    var next: Next?
}
