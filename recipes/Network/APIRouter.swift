//
//  APIRouter.swift
//  recipes
//
//  Created by Elsaadany on 17/06/2021.
//

import Foundation

import Alamofire

enum APIRouter: URLRequestConvertible {
    
    static let appID = "4b18d329"
    static let appKey = "f389575629d98f3602d91de6eda93e46"
    
    case search(query: String)
    case filteredSearch(_ query: String, _ filter: String)
    case nextPage(_ url: String)
}

extension APIRouter {
    
    private var baseUrl: String {
        switch self {
        case .nextPage(let url):
            return url
        default:
            return "https://api.edamam.com"
        }
    }
    
    private var method: HTTPMethod {
        return .get
    }
    
    private var path: String? {
        switch self {
        case .search:
            return "/api/recipes/v2"
        default:
            return nil
        }
    }
    
    private var queryParameters: [String : Any]? {
        let fields = ["label", "image", "url", "healthLabels", "ingredientLines"]
        switch self {
        case .search(let query):
            return ["type" : "public", "q" : query, "app_id" : "\(APIRouter.appID)", "app_key" : "\(APIRouter.appKey)", "field" : fields]
        case .filteredSearch(let query, let filter):
            return ["type" : "public", "q" : query, "app_id" : "\(APIRouter.appID)", "app_key" : "\(APIRouter.appKey)", "health": filter, "field" : fields]
        default:
            return nil
        }
    }
    
    private var body: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
    
    private var headers: [String : String] {
        return ["Accept": "application/json"]
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url)
        
        if let path = path {
            urlRequest = URLRequest(url: url.appendingPathComponent(path))
        }
                
        urlRequest.httpMethod = self.method.rawValue
        
        let headers = HTTPHeaders(self.headers)
        urlRequest.headers = headers
        
        
        if let parameters = queryParameters {
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
        }
        
        if let body = body {
            do {
                urlRequest.httpBody = try JSONEncoder().encode(body)
            } catch {
                
            }
        }
        
        return urlRequest
    }
}
