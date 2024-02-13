//
//  BaseRepository.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 11/2/24.
//

import Foundation
import CoreData

protocol BaseRepository {
    var context: NSManagedObjectContext { get }
}

extension BaseRepository {
    func create<T: NSManagedObject>(_ type: T.Type) async -> T? {
        guard let entityName = T.entity().name else { return nil }
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else { return nil }
        let object = T(entity: entity, insertInto: context)
        return object
    }
    
    func add<T: NSManagedObject>(_ type: T.Type) -> T? {
        guard let entityName = T.entity().name else { return nil }
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else { return nil }
        let object = T(entity: entity, insertInto: context)
        return object
    }
    
    func fetch<T: NSManagedObject>(_ type: T.Type, with predicate: NSPredicate? = nil) async -> [T] {
        let request = T.fetchRequest()
        
        if let predicate = predicate {
            request.predicate = predicate
        }
        
        do {
            let result = try context.fetch(request)
            return result as! [T]
        } catch (let error) {
            Logger.log(type: .info, "[Storage][Fetch] failed: \(error.localizedDescription)")
            return []
        }
    }
    
    func delete<T: NSManagedObject>(object: T) async {
        context.delete(object)
        await save()
    }
    
    /// Perform complex or time-consuming operations on backgroundContext asynchronously
    func save() async {
        PersistentStorage.shared.performBackgroundTask { backgroundContext in
            do {
                try backgroundContext.save()
            } catch {
                let error = error as NSError
                if isProduction {
                    Logger.log(type: .error, "[Persistent][Storage][Save] failed: \(error.userInfo)")
                } else {
                    fatalError("[Persistent][Storage][Save] failed: \(error), \(error.userInfo)")
                }
            }
            
            /// Optionally, notify the main context about changes if needed
            PersistentStorage.shared.saveContext()
        }
    }
    
    /// Perform complex or time-consuming operations on backgroundContext
    func saveContext() {
        PersistentStorage.shared.performBackgroundTask { backgroundContext in
            do {
                try backgroundContext.save()
            } catch {
                let error = error as NSError
                if isProduction {
                    Logger.log(type: .info, "[Persistent][Storage][Save] failed: \(error.userInfo)")
                } else {
                    fatalError("[Persistent][Storage][Save] failed: \(error), \(error.userInfo)")
                }
            }
            
            /// Optionally, notify the main context about changes if needed
            PersistentStorage.shared.saveContext()
        }
    }
}
