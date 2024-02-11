//
//  StorageManager.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 11/2/24.
//

import CoreData

class StorageManager {
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func create<T: NSManagedObject>(_ type: T.Type) async -> T? {
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
    
    func save() async {
        if self.context.hasChanges {
            do {
                try context.save()
            } catch {
                Logger.log(type: .info, "[Storage][Delete] failed: \(error.localizedDescription)")
            }
        }
    }
}

