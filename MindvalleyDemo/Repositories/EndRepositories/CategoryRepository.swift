//
//  CategoryRepository.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 11/2/24.
//

import Foundation
import CoreData

protocol CategoryRepository: BaseRepository {
    func createCategory(record: T1) async -> StorageStatus
    func fetchAllCategories() async -> [T1]
    func fetchCategory(byIdentifier id: String) async -> T1?
    func updateCategory(record: T1) async -> StorageStatus
    func deleteCategory(byIdentifier id: String) async -> StorageStatus
}

extension CategoryRepository {
    typealias T = CDCategory
    typealias T1 = CategoryItem
    
    @discardableResult
    func createCategory(record: T1) async -> StorageStatus {
        if await self.fetchCategory(byIdentifier: record.id) != nil { return .existsInDB }
        guard let cDCategory = await self.create(T.self) else { return .savingFailed }
        cDCategory.name = record.name
        return .succeed
    }
    
    func fetchAllCategories() async -> [T1] {
        let results = await self.fetch(T.self)
        var categories: [T1] = []
        results.forEach({ cdCategory in
            categories.append(cdCategory.convertToCategory())
        })
        return categories
    }
    
    func fetchCategory(byIdentifier id: String) async -> T1? {
        let fetchRequest = NSFetchRequest<T>(entityName: "CDCategory")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        // let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        // fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let result = try self.context.fetch(fetchRequest)
            guard let category = result.first else { return nil }
            return category.convertToCategory()
        } catch (let error) {
            Logger.log(type: .error, "[CDCategory][Response][Data]: failed \(error.localizedDescription)")
            return nil
        }
    }
    
    func updateCategory(record: T1) async -> StorageStatus {
        //let predicate = NSPredicate(format: "(id = %@)", record.id as CVarArg)
        //let results = await manager.fetch(T2.self, with: predicate)
        
        //guard let cdCategory = await manager.create(T2.self) else { return false}
        //cdCategory.id = record.id
        return .unknown
    }
    
    func deleteCategory(byIdentifier id: String) async -> StorageStatus {
        //        let cdCategory = getCDCategory(byId: id)
        //        guard let cdCategory = cdCategory else { return .notExistsInDB }
        //        await self.delete(object: cdCategory)
        return .succeed
    }
    //
    //    private func getCDCategory(byId id: String) -> T? {
    //        let fetchRequest = NSFetchRequest<T>(entityName: "CDCategory")
    //        let fetchById = NSPredicate(format: "id==%@", id as CVarArg)
    //        fetchRequest.predicate = fetchById
    //        guard let result = try? self.context.fetch(fetchRequest), let channel = result.first else { return nil }
    //        return channel
    //    }
}


