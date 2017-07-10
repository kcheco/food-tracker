//
//  BaseRouter.swift
//  FoodTracker
//
//  Created by Kelvin Checo on 7/9/17.
//  Copyright © 2017 Kelvin Checo. All rights reserved.
//

import Foundation
import Alamofire

public typealias JSONDictionary = [String: AnyObject]
typealias APIParams = [String: AnyObject]?

protocol APIConfiguration {
    var method: Alamofire.HTTPMethod { get }
    var encoding: Alamofire.ParameterEncoding? { get }
    var path: String { get }
    var parameters: APIParams { get }
    var baseUrl: String { get }
}

class BaseRouter: URLRequestConvertible, APIConfiguration {
    
    init() {}
    
    var method: Alamofire.HTTPMethod {
        fatalError("BaseRouter.method Must be overridden in subclass")
    }
    
    var encoding: Alamofire.ParameterEncoding? {
        fatalError("BaseRouter.encoding Must be overridden in subclass")
    }
    
    var path: String {
        fatalError("BaseRouter.path Must be overridden in subclass")
    }
    
    var parameters: APIParams {
        fatalError("BaseRouter.parameters Must be overridden in subclass")
    }
    
    var baseUrl: String {
        let baseUrl = Config.baseUrl
        return baseUrl
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Config.baseUrl.asURL()
        //debugPrint("There appears to be an issue with: \(url)")
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("Bearer \(Config.apiKey)", forHTTPHeaderField: "Authorization")
        
        if let encoding = encoding {
            return try encoding.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}
