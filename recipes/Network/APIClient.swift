//
//  APIClient.swift
//  recipes
//
//  Created by Elsaadany on 17/06/2021.
//

import Foundation
import Alamofire

struct APIClient {
    func performRequest<T: Decodable>(_ route: APIRouter, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(route).responseDecodable(decoder: JSONDecoder()){ (response: DataResponse<T, AFError>) in
            completion(response.result)
        }
    }
}
