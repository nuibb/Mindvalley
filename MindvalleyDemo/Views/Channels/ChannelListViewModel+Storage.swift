//
//  ChannelListViewModel+Storage.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 11/2/24.
//

import Foundation

extension ChannelsListViewModel {
    func addEpisodes() {
        guard !self.newEpisodes.isEmpty else { return }

        for episode in newEpisodes {
            Task { [weak self] in
                guard let self = self else { return }
                self.localDataProvider.createEpisode(record: episode)
            }
        }
    }
    
    func getEpisodes() {
        Task { [weak self] in
            guard let self = self else { return }
            let episodes = await self.localDataProvider.fetchAllEpisodes()
            guard !episodes.isEmpty else { return }
            DispatchQueue.main.async { [weak self] in
                self?.newEpisodes = episodes
            }
        }
    }
    
    func addChannels() {
        guard !self.channels.isEmpty else { return }
        for channel in channels {
            Task { [weak self] in
                guard let self = self else { return }
                self.localDataProvider.createChannel(record: channel)
            }
        }
    }
    
    func getChannels() {
        
    }
    
    func addCategories() {
        guard !self.categories.isEmpty else { return }
        for category in categories {
            Task { [weak self] in
                guard let self = self else { return }
                self.localDataProvider.createCategory(record: category)
            }
        }
    }
    
    func getCategories() {
        
    }
}
