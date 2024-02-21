//
//  ChannelsRepository.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 11/2/24.
//

import Foundation
import CoreData

protocol ChannelRepository: BaseRepository {
    func createChannel(record: T1) async -> StorageStatus
    func fetchAllChannels() async -> [T1]
    func fetchChannel(byIdentifier id: String) async -> T1?
    func updateChannel(record: T1) async -> StorageStatus
    func deleteChannel(byIdentifier id: String) async -> StorageStatus
}

extension ChannelRepository {
    typealias T = CDChannel
    typealias T1 = Channel
    
    @discardableResult
    func createChannel(record: T1) async -> StorageStatus {
        guard let cdChannel = await self.create(CDChannel.self) else { return .insertionFailed }
        cdChannel.id = record.id
        cdChannel.name = record.title
        cdChannel.icon = record.icon
        cdChannel.isSeries = record.isSeries
        
        var mediaSet = Set<CDMedia>()
        
        for item in record.episodes {
            guard let cdMedia = await self.create(CDMedia.self) else { return .insertionFailed }
            cdMedia.id = item.id
            cdMedia.title = item.title
            cdMedia.coverPhoto = item.coverPhoto
            mediaSet.insert(cdMedia)
        }
        
        cdChannel.items = mediaSet
        return .succeed
    }
    
    func fetchAllChannels() async -> [T1] {
        let results = await self.fetch(T.self)
        var channels: [T1] = []
        results.forEach({ cdChannel in
            channels.append(cdChannel)
        })
        return channels
    }
    
    func fetchChannel(byIdentifier id: String) async -> T1? {
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        //let descriptors = [NSSortDescriptor(key: "channel", ascending: false)]
        let results = await self.fetch(T.self, with: predicate)//sort: descriptors
        guard let channel = results.first else { return nil }
        return channel
    }
    
    func updateChannel(record: T1) async -> StorageStatus {
        //let predicate = NSPredicate(format: "(id = %@)", record.id as CVarArg)
        //let results = await manager.fetch(T2.self, with: predicate)
        
        //guard let cdChannel = await manager.add(T2.self) else { return false}
        //cdChannel.id = record.id
        return .unknown
    }
    
    func deleteChannel(byIdentifier id: String) async -> StorageStatus {
        //        let cdChannel = getCDChannel(byId: id)
        //        guard let cdChannel = cdChannel else { return .notExistsInDB }
        //        await self.delete(object: cdChannel)
        return .unknown
    }
}
