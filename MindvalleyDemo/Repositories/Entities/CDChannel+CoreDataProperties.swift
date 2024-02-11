//
//  CDChannel+CoreDataProperties.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 11/2/24.
//
//

import Foundation
import CoreData


extension CDChannel {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDChannel> {
        return NSFetchRequest<CDChannel>(entityName: "CDChannel")
    }
    
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var isSeries: Bool
    @NSManaged public var icon: String?
    @NSManaged public var items: Set<CDMedia>?
    
}

// MARK: Generated accessors for items
extension CDChannel {
    
    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: CDMedia)
    
    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: CDMedia)
    
    @objc(addItems:)
    @NSManaged public func addToItems(_ values: Set<CDMedia>)
    
    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: Set<CDMedia>)
    
}

extension CDChannel : Identifiable {
    func convertToChannel() -> ChannelItem {
        return ChannelItem(
            channelId: id ?? "",
            name: name ?? "",
            icon: icon ?? "",
            items: [],
            isSeries: isSeries)
    }
    
    private func convertToMediaItems() -> [Media] {
        guard let mediaItems = items, !mediaItems.isEmpty else { return [] }
        var localItems: [Media] = []
        mediaItems.forEach({ cdMedia in
            localItems.append(cdMedia.convertToMedia())
        })
        return localItems
    }
}
