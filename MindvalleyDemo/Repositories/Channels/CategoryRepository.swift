//
//  CategoryRepository.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 11/2/24.
//

import Foundation
import CoreData

protocol CategoryRepository: BaseRepository {
    
}

struct CategoryDataRepository: CategoryRepository {
    typealias T = CategoryItem
    typealias T2 = CDCategory
    private let manager: StorageManager
    private var context: NSManagedObjectContext
    
    init(manager: StorageManager, context: NSManagedObjectContext) {
        self.manager = manager
        self.context = context
    }
    
    func create(record: T) async -> StorageStatus {
        if getCDCategory(byId: record.id) != nil { return .existsInDB }
        guard let cDCategory = await manager.create(T2.self) else { return .savingFailed }
        cDCategory.name = record.name
        
        await manager.save()
        return .succeed
    }
    
    func fetchAll() async -> [T] {
        let results = await manager.fetch(T2.self)
        var categories: [T] = []
        results.forEach({ cdCategory in
            categories.append(convertToCategory(cdCategory: cdCategory))
        })
        return categories
    }
    
    private func convertToCategory(cdCategory: T2) -> T {
        return CategoryItem(id: cdCategory.id, name: cdCategory.name)
    }
    
    func fetch(byIdentifier id: String) async -> T? {
        let fetchRequest = NSFetchRequest<T2>(entityName: "CDCategory")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        // let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        // fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let result = try await self.context.fetch(fetchRequest).first
            guard let result = result else { return nil }
            return convertToCategory(cdCategory: result)
        } catch (let error) {
            Logger.log(type: .error, "[CDCategory][Response][Data]: failed \(error.localizedDescription)")
            return nil
        }
    }
    
    func update(record: T) async -> StorageStatus {
        //let predicate = NSPredicate(format: "(id = %@)", record.id as CVarArg)
        //let results = await manager.fetch(T2.self, with: predicate)
        
        //guard let cdCategory = await manager.create(T2.self) else { return false}
        //cdCategory.id = record.id
        return .unknown
    }
    
    func delete(byIdentifier id: String) async -> StorageStatus {
        let cdCategory = getCDCategory(byId: id)
        guard let cdCategory = cdCategory else { return .notExistsInDB }
        await manager.delete(object: cdCategory)
        return .succeed
    }
    
    private func getCDCategory(byId id: String) -> T2? {
        let fetchRequest = NSFetchRequest<T2>(entityName: "CDCategory")
        let fetchById = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = fetchById
        guard let result = try? await self.context.fetch(fetchRequest), let channel = result.first else { return nil }
        return channel
    }
}


