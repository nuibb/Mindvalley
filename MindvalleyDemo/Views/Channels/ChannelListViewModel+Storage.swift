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
                await self.localDataProvider.createEpisode(record: episode)
                await self.localDataProvider.save()
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
                await self.localDataProvider.createChannel(record: channel)
                await self.localDataProvider.save()
            }
        }
    }
    
    func getChannels() {
        Task { [weak self] in
            guard let self = self else { return }
            let channels = await self.localDataProvider.fetchAllChannels()
            guard !channels.isEmpty else { return }
            DispatchQueue.main.async { [weak self] in
                self?.channels = channels
                Logger.log(type: .info, "[Channels][In][Storage] count: \(channels.count)")
            }
        }
    }
    
    func addCategories() {
        guard !self.categories.isEmpty else { return }
        for category in categories {
            Task { [weak self] in
                guard let self = self else { return }
                await self.localDataProvider.createCategory(record: category)
                await self.localDataProvider.save()
            }
        }
    }
    
    func getCategories() {
        Task { [weak self] in
            guard let self = self else { return }
            let categories = await self.localDataProvider.fetchAllCategories()
            guard !categories.isEmpty else { return }
            DispatchQueue.main.async { [weak self] in
                self?.categories = categories
            }
        }
    }
}
