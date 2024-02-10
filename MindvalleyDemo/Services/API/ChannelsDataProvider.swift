//
//  ChannelsDataProvider.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import Foundation

protocol ChannelsDataProvider: HTTPClient {
    func fetchNewEpisodes() async -> Swift.Result<Episodes, RequestError>
    func fetchChannels() async -> Swift.Result<ChannelsData, RequestError>
    func fetchCategories() async -> Swift.Result<CategoriesData, RequestError>
}

extension ChannelsDataProvider {
    func fetchNewEpisodes() async -> Swift.Result<Episodes, RequestError> {
        if self.networkMonitor.isConnected {
            return await getRequest(endpoint: ChannelsEndPoints.newEpisodes, responseModel: Episodes.self)
        } else {
            return .failure(.networkNotAvailable)
        }
    }
    
    func fetchChannels() async -> Swift.Result<ChannelsData, RequestError> {
        if self.networkMonitor.isConnected {
            return await getRequest(endpoint: ChannelsEndPoints.newEpisodes, responseModel: ChannelsData.self)
        } else {
            return .failure(.networkNotAvailable)
        }
    }
    
    func fetchCategories() async -> Swift.Result<CategoriesData, RequestError> {
        if self.networkMonitor.isConnected {
            return await getRequest(endpoint: ChannelsEndPoints.categories, responseModel: CategoriesData.self)
        } else {
            return .failure(.networkNotAvailable)
        }
    }
}
