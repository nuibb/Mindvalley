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
        
        Task { [weak self] in
            guard let self = self else { return }
            let episodes = await self.localDataProvider.fetchAllEpisodes()
            let existingEpisodeIDs = episodes.map { $0.id }
            for episode in self.newEpisodes {
                if !existingEpisodeIDs.contains(episode.id) {
                    await self.localDataProvider.createEpisode(record: episode)
                }
            }
            await self.localDataProvider.save()
        }
    }
    
    func getEpisodes() {
        Task { [weak self] in
            guard let self = self else { return }
            let episodes = await self.localDataProvider.fetchAllEpisodes()
            guard !episodes.isEmpty else { return }
            DispatchQueue.main.async { [weak self] in
                self?.newEpisodes = episodes
                Logger.log(type: .info, "[Storage][Episodes] count: \(episodes.count)")
            }
        }
    }
    
    func addChannels() {
        guard !self.channels.isEmpty else { return }
        
        Task { [weak self] in
            guard let self = self else { return }
            let storedChannels = await self.localDataProvider.fetchAllChannels()
            let existingChannelIDs = storedChannels.map { $0.id }
            for channel in self.channels {
                if !existingChannelIDs.contains(channel.id) {
                    await self.localDataProvider.createChannel(record: channel)
                }
            }
            await self.localDataProvider.save()
        }
    }
    
    func getChannels() {
        Task { [weak self] in
            guard let self = self else { return }
            let channels = await self.localDataProvider.fetchAllChannels()
            guard !channels.isEmpty else { return }
            DispatchQueue.main.async { [weak self] in
                self?.channels = channels
                Logger.log(type: .info, "[Storage][Channels] count: \(channels.count)")
            }
        }
    }
    
    func addCategories() {
        guard !self.categories.isEmpty else { return }
        
        Task { [weak self] in
            guard let self = self else { return }
            let storedCategories = await self.localDataProvider.fetchAllCategories()
            let existingCategoryIDs = storedCategories.map { $0.id }
            for category in self.categories {
                if !existingCategoryIDs.contains(category.id) {
                    await self.localDataProvider.createCategory(record: category)
                }
            }
            await self.localDataProvider.save()
        }
    }
    
    func getCategories() {
        Task { [weak self] in
            guard let self = self else { return }
            let categories = await self.localDataProvider.fetchAllCategories()
            guard !categories.isEmpty else { return }
            DispatchQueue.main.async { [weak self] in
                self?.categories = categories
                Logger.log(type: .info, "[Storage][Categories] count: \(categories.count)")
            }
        }
    }
}
