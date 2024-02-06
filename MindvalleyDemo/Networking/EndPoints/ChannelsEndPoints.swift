//
//  ChannelsEndPoints.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import Foundation

enum ChannelsEndPoints: Endpoint {
    case newEpisodes
    case channels
    case categories
}

extension ChannelsEndPoints {
    
    // MARK: path includes a leading '/'
    var path: String {
        switch self {
        case .newEpisodes:
            return "/raw/z5AExTtw"
        case .channels:
            return "/raw/Xt12uVhM"
        case .categories:
            return "/raw/A0CgArX3"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .newEpisodes, .channels, .categories:
            return .get
        }
    }
}
