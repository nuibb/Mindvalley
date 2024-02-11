//
//  EpisodeRepository.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 11/2/24.
//

import Foundation
import CoreData

protocol EpisodeRepository: BaseRepository {
    
}

struct EpisodeDataRepository: EpisodeRepository {
    typealias T = Episode
    typealias T2 = CDEpisode
    private let manager: StorageManager
    private var context: NSManagedObjectContext
    
    init(manager: StorageManager, context: NSManagedObjectContext) {
        self.manager = manager
        self.context = context
    }
    
    func create(record: T) async -> StorageStatus {
        if getCDEpisode(byId: record.id) != nil { return .existsInDB }
        guard let cdEpisode = await manager.create(T2.self) else { return .savingFailed }
        cdEpisode.id = record.id
        cdEpisode.title = record.title
        cdEpisode.coverPhoto = record.coverPhoto
        cdEpisode.channel = record.channel
        
        await manager.save()
        return .succeed
    }
    
    func fetchAll() async -> [T] {
        let results = await manager.fetch(T2.self)
        var episodes : [T] = []
        results.forEach({ cdEpisode in
            episodes.append(convertToEpisode(cdEpisode: cdEpisode))
        })
        return episodes
    }
    
    private func convertToEpisode(cdEpisode: T2) -> T {
        return EpisodeItem(
            id: cdEpisode.id,
            title: cdEpisode.title,
            coverPhoto: cdEpisode.coverPhoto,
            channel: cdEpisode.channel)
    }
    
    func fetch(byIdentifier id: String) async -> T? {
        let fetchRequest = NSFetchRequest<T2>(entityName: "CDEpisode")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        // let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        // fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let result = try await self.context.fetch(fetchRequest).first
            guard let result = result else { return nil }
            return convertToEpisode(cdEpisode: result)
        } catch (let error) {
            Logger.log(type: .error, "[CDEpisode][Response][Data]: failed \(error.localizedDescription)")
            return nil
        }
    }
    
    func update(record: T) async -> StorageStatus {
        //let predicate = NSPredicate(format: "(id = %@)", record.id as CVarArg)
        //let results = await manager.fetch(T2.self, with: predicate)
        
        //guard let cdEpisode = await manager.create(T2.self) else { return false}
        //cdEpisode.id = record.id
        return .unknown
    }
    
    func delete(byIdentifier id: String) async -> StorageStatus {
        let cdEpisode = getCDEpisode(byId: id)
        guard let cdEpisode = cdEpisode else { return .notExistsInDB }
        await manager.delete(object: cdEpisode)
        return .succeed
    }
    
    private func getCDEpisode(byId id: String) -> T2? {
        let fetchRequest = NSFetchRequest<T2>(entityName: "CDEpisode")
        let fetchById = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = fetchById
        guard let result = try? await self.context.fetch(fetchRequest), let channel = result.first else { return nil }
        return channel
    }
}

