//
//  WebService.swift
//  recipes
//
//  Created by Elsaadany on 17/06/2021.
//

import Foundation
import Alamofire

struct WebServices: WebServiceProtocol {
    
    private let networkProvider = APIClient()
    
    func searchRecipes(of query: String, completion: @escaping (Result<Recipes, AFError>) -> Void) {
        networkProvider.performRequest(.search(query: query)) { (result: Result<Recipes, AFError>) in
            completion(result)
        }
    }
    
    func searchFilteredRecipes(of query: String, and filter: String, completion: @escaping (Result<Recipes, AFError>) -> Void) {
        networkProvider.performRequest(.filteredSearch(query, filter)) { (result: Result<Recipes, AFError>) in
            completion(result)
        }
    }
    
    func getNextPage(of url: String, completion: @escaping (Result<Recipes, AFError>) -> Void) {
        networkProvider.performRequest(.nextPage(url)) { (result: Result<Recipes, AFError>) in
            completion(result)
        }
    }
    
    func downloadImage(from url: String, completion: @escaping (Result<Data, AFError>) -> Void) {
        networkProvider.downloadImage(from: url) { (result) in
            completion(result)
        }
    }
}
