//
//  StorageDataProvider.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 11/2/24.
//

import Foundation
import CoreData

struct StorageDataProvider: EpisodeRepository, ChannelRepository, CategoryRepository {
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
}
