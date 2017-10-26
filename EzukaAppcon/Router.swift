//
//  Router.swift
//  MinimumMVCSample
//
//  Created by maekawakazuma on 2017/10/05.
//  Copyright © 2017 maekawakazuma. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    case vote(parameters: Parameters)
    case readApps()
    
    static let baseURL = "http://192.168.100.93:3000"
    static let suffix = "/api/v1"
    
    
    var method: HTTPMethod {
        switch self {
        case .vote:
            return .post
        case .readApps:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .vote:
            return "/vote"
        case .readApps:
            return "/apps"
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let baseURLString = Router.baseURL + Router.suffix
        let url = try baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .vote(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        default:
            break
        }
        
        return urlRequest
    }
}
