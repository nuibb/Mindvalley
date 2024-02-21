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
    typealias T1 = Episode
    
    @discardableResult
    func createEpisode(record: T1) async -> StorageStatus {
        guard let cdEpisode = await self.create(T.self) else { return .insertionFailed }
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
            episodes.append(cdEpisode)
        })
        return episodes
    }
    
    func fetchEpisode(byIdentifier id: String) async -> T1? {
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        //let descriptors = [NSSortDescriptor(key: "channel", ascending: false)]
        let results = await self.fetch(T.self, with: predicate)//sort: descriptors
        guard let episode = results.first else { return nil }
        return episode
    }
    
    func updateEpisode(record: T1) async -> StorageStatus {
        /*
        let predicate = NSPredicate(format: "(id = %@)", record.id as CVarArg)
        let results = await self.fetch(T.self, with: predicate)
        
        guard let cdEpisode = await self.create(T.self) else { return .editingFailed }
        cdEpisode.id = record.id
         */
        return .succeed
    }
    
    @discardableResult
    func deleteEpisode(byIdentifier id: String) async -> StorageStatus {
        /*
        let cdEpisode = getCDEpisode(byId: id)
        guard let cdEpisode = cdEpisode else { return .notExistsInDB }
        await self.delete(object: cdEpisode)
        */
        return .succeed
    }
}

