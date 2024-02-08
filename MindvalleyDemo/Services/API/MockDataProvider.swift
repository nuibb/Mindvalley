//
//  MockDataProvider.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import Foundation

class MockDataProvider: ChannelsDataProvider {
    let networkMonitor: NetworkMonitor = NetworkMonitor()

    func fetchNewEpisodes() async -> Result<Episodes, RequestError> {
        if self.networkMonitor.isConnected {
            return Bundle.main.decode("EpisodesData", fileExtension: ".json")
        } else {
            return .failure(.networkNotAvailable)
        }
    }
    
    func fetchChannels() async -> Result<ChannelsData, RequestError> {
        if self.networkMonitor.isConnected {
            return Bundle.main.decode("ChannelsData", fileExtension: ".json")
        } else {
            return .failure(.networkNotAvailable)
        }
    }
    
    func fetchCategories() async -> Result<String, RequestError> {
        if self.networkMonitor.isConnected {
            return Bundle.main.decode("CategoriesData", fileExtension: ".json")
        } else {
            return .failure(.networkNotAvailable)
        }
    }
}
