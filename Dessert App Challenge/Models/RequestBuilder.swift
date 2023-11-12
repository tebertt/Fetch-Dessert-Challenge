//
//  RequestBuilder.swift
//  Dessert App Challenge
//
//  Created by Troy Ebert on 11/9/23.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case PUT
    case POST
    case PATCH
    case DELETE
}

// Request object
class RequestBuilder {
    private var request: URLRequest
    
    init(url: URL) {
        request = URLRequest(url: url)
    }
    
    func getRequest() -> URLRequest {
        return request
    }
    
    // Sets the http method, see enum above
    func setMethod(method: HTTPMethod) -> RequestBuilder {
        request.httpMethod = method.rawValue
        return self
    }
    
}
