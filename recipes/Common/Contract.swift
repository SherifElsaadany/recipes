//
//  Contract.swift
//  recipes
//
//  Created by Elsaadany on 17/06/2021.
//

import Foundation
import Alamofire

protocol ReusableView: class {}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

protocol WebServiceProtocol {
    
    func searchRecipes(of query: String, completion: @escaping (Result<Recipes, AFError>) -> Void)
    
    func filterRecipeResults(of query: String, and filter: String, completion: @escaping (Result<Recipes, AFError>) -> Void)
    
    func getNextPage(of url: String, completion: @escaping (Result<Recipes, AFError>) -> Void)
}
