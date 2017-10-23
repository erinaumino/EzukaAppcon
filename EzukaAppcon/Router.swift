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
    
    static let baseURLString = "http://192.168.2.103:3000/api/v1"
    
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
        let url = try Router.baseURLString.asURL()
        
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
