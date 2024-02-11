//
//  ChannelsRepository.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 11/2/24.
//

import Foundation
import CoreData

protocol ChannelRepository: BaseRepository {
    
}

struct ChannelDataRepository: ChannelRepository {
    typealias T = Channel
    typealias T2 = CDChannel
    private let manager: StorageManager
    private var context: NSManagedObjectContext
    
    init(manager: StorageManager, context: NSManagedObjectContext) {
        self.manager = manager
        self.context = context
    }
    
    func create(record: T) async -> StorageStatus {
        if getCDChannel(byId: record.channelId) != nil { return .existsInDB }
        guard let cdChannel = await manager.create(T2.self) else { return .savingFailed }
        cdChannel.channelId = record.channelId
        cdChannel.name = record.name
        cdChannel.icon = record.icon
        cdChannel.isSeries = record.isSeries
        
        //cdChannel.media = mediaSet
        
        await manager.save()
        return .succeed
    }
    
    func fetchAll() async -> [T] {
        let results = await manager.fetch(T2.self)
        var channels : [T] = []
        results.forEach({ cdChannel in
            channels.append(convertToChannel(cdChannel: cdChannel))
        })
        return channels
    }
    
    private func convertToChannel(cdChannel: T2) -> T {
        return ChannelItem(
            channelId: cdChannel.channelId ?? "",
            name: cdChannel.name ?? "",
            icon: cdChannel.icon ?? "",
            items: [],
            isSeries: cdChannel.isSeries)
    }
    
    func fetch(byIdentifier id: String) async -> T? {
        let fetchRequest = NSFetchRequest<T2>(entityName: "CDChannel")
        let predicate = NSPredicate(format: "channelId==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        // let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        // fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let result = try await self.context.fetch(fetchRequest).first
            guard let result = result else { return nil }
            return convertToChannel(cdChannel: result)
        } catch (let error) {
            Logger.log(type: .error, "[CDChannel][Response][Data]: failed \(error.localizedDescription)")
            return nil
        }
    }
    
    func update(record: T) async -> StorageStatus {
        //let predicate = NSPredicate(format: "(id = %@)", record.id as CVarArg)
        //let results = await manager.fetch(T2.self, with: predicate)
        
        //guard let cdChannel = await manager.add(T2.self) else { return false}
        //cdChannel.id = record.id
        return .unknown
    }
    
    func delete(byIdentifier id: String) async -> StorageStatus {
        let cdChannel = getCDChannel(byId: id)
        guard let cdChannel = cdChannel else { return .notExistsInDB }
        await manager.delete(object: cdChannel)
        return .succeed
    }
    
    private func getCDChannel(byId id: String) -> T2? {
        let fetchRequest = NSFetchRequest<T2>(entityName: "CDChannel")
        let fetchById = NSPredicate(format: "channelId==%@", id as CVarArg)
        fetchRequest.predicate = fetchById
        guard let result = try? await self.context.fetch(fetchRequest), let channel = result.first else { return nil }
        return channel
    }
}
