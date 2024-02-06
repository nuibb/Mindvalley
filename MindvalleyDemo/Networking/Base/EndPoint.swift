//
//  EndPoint.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String:String] { get }
    var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
    var scheme: String {
        return Config.url.scheme
    }
    
    var host: String {
        return Config.url.host
    }
    
    var header: [String: String] {
        return [
            //"Authorization": "Bearer \(accessToken)",
            "Content-Type": Config.url.applicationType
        ]
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
}

