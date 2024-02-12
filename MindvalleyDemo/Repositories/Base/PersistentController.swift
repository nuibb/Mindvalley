//
//  PersistentController.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 11/2/24.
//

import Foundation
import CoreData

final class PersistentStorage {
    static let shared = PersistentStorage()
    private let queue = DispatchQueue(label: "com.example.PersistentStorageQueue")
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "StorageDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                if isProduction {
                    Logger.log(type: .info, "[Persistent][Storage][Save] failed: \(error.userInfo)")
                } else {
                    fatalError("[Persistent][Storage][Save] failed: \(error), \(error.userInfo)")
                }
            }
        })
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    func saveContext() {
        queue.sync {
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let error = error as NSError
                    if isProduction {
                        Logger.log(type: .info, "[Persistent][Storage][Save] failed: \(error.userInfo)")
                    } else {
                        fatalError("[Persistent][Storage][Save] failed: \(error), \(error.userInfo)")
                    }
                }
            }
        }
    }
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask { (backgroundContext) in
            block(backgroundContext)
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
        }
    }
}


