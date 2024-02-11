//
//  PersistentController.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 11/2/24.
//

import CoreData
import Foundation

class PersistentController: ObservableObject {
    let container = NSPersistentContainer(name: "MindvalleyDemo")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                Logger.log(type: .error, "[Persistent] failed: \(StorageStatus.loadingFailed.description) - \(error.localizedDescription)")
            }
        }
    }
}
