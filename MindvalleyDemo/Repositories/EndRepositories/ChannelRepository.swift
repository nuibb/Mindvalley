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
    typealias T1 = ChannelItem
    
    @discardableResult
    func createChannel(record: T1) async -> StorageStatus {
        if await self.fetchChannel(byIdentifier: record.channelId) != nil { return .existsInDB }
        guard let cdChannel = await self.create(CDChannel.self) else { return .addingFailed }
        cdChannel.id = record.channelId
        cdChannel.name = record.name
        cdChannel.icon = record.icon
        cdChannel.isSeries = record.isSeries
        
        var mediaSet = Set<CDMedia>()
        
        for item in record.items {
            guard let cdMedia = await self.create(CDMedia.self) else { return .addingFailed }
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
        var channels : [T1] = []
        results.forEach({ cdChannel in
            channels.append(cdChannel.convertToChannel())
        })
        return channels
    }
    
    func fetchChannel(byIdentifier id: String) async -> T1? {
        let fetchRequest = NSFetchRequest<T>(entityName: "CDChannel")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        // let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        // fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let result = try self.context.fetch(fetchRequest)
            guard let channel = result.first else { return nil }
            return channel.convertToChannel()
        } catch (let error) {
            Logger.log(type: .error, "[CDChannel][Response][Data]: failed \(error.localizedDescription)")
            return nil
        }
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
        return .succeed
    }
    //
    //    private func getCDChannel(byId id: String) -> T? {
    //        let fetchRequest = NSFetchRequest<T>(entityName: "CDChannel")
    //        let fetchById = NSPredicate(format: "id==%@", id as CVarArg)
    //        fetchRequest.predicate = fetchById
    //        guard let result = try? self.context.fetch(fetchRequest), let channel = result.first else { return nil }
    //        return channel
    //    }
}
