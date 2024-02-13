//
//  EpisodeRepository.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 11/2/24.
//

import Foundation
import CoreData

protocol EpisodeRepository: BaseRepository {
    func createEpisode(record: T1) async -> StorageStatus
    func fetchAllEpisodes() async -> [T1]
    func fetchEpisode(byIdentifier id: String) async -> T1?
    func updateEpisode(record: T1) async -> StorageStatus
    func deleteEpisode(byIdentifier id: String) async -> StorageStatus
}

extension EpisodeRepository {
    typealias T = CDEpisode
    typealias T1 = EpisodeItem
    
    @discardableResult
    func createEpisode(record: T1) async -> StorageStatus {
        if await self.fetchEpisode(byIdentifier: record.id) != nil { return .existsInDB }
        guard let cdEpisode = await self.create(T.self) else { return .savingFailed }
        cdEpisode.id = record.id
        cdEpisode.title = record.title
        cdEpisode.coverPhoto = record.coverPhoto
        cdEpisode.channel = record.channel
        return .succeed
    }
    
    func fetchAllEpisodes() async -> [T1] {
        let results = await self.fetch(T.self)
        var episodes : [T1] = []
        results.forEach({ cdEpisode in
            episodes.append(cdEpisode.convertToEpisode())
        })
        return episodes
    }
    
    func fetchEpisode(byIdentifier id: String) async -> T1? {
        let fetchRequest = NSFetchRequest<T>(entityName: "CDEpisode")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        // let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        // fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let result = try self.context.fetch(fetchRequest)
            guard let category = result.first else { return nil }
            return category.convertToEpisode()
        } catch (let error) {
            Logger.log(type: .error, "[CDEpisode][Response][Data]: failed \(error.localizedDescription)")
            return nil
        }
    }
    
    func updateEpisode(record: T1) async -> StorageStatus {
        //let predicate = NSPredicate(format: "(id = %@)", record.id as CVarArg)
        //let results = await manager.fetch(T2.self, with: predicate)
        
        //guard let cdEpisode = await manager.create(T2.self) else { return false}
        //cdEpisode.id = record.id
        return .unknown
    }
    
    func deleteEpisode(byIdentifier id: String) async -> StorageStatus {
        //        let cdEpisode = getCDEpisode(byId: id)
        //        guard let cdEpisode = cdEpisode else { return .notExistsInDB }
        //        await self.delete(object: cdEpisode)
        return .succeed
    }
    
    //    private func getCDEpisode(byId id: String) -> T? {
    //        let fetchRequest = NSFetchRequest<T>(entityName: "CDEpisode")
    //        let fetchById = NSPredicate(format: "id==%@", id as CVarArg)
    //        fetchRequest.predicate = fetchById
    //        guard let result = try? self.context.fetch(fetchRequest), let channel = result.first else { return nil }
    //        return channel
    //    }
}

