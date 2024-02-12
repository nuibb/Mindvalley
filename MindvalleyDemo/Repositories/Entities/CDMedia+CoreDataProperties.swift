//
//  CDMedia+CoreDataProperties.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 11/2/24.
//
//

import Foundation
import CoreData


extension CDMedia {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMedia> {
        return NSFetchRequest<CDMedia>(entityName: "CDMedia")
    }

    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var coverPhoto: String
    @NSManaged public var media: CDChannel?

}

extension CDMedia : Identifiable {
    func convertToMedia() -> Media {
        return MediaItem(id: id, title: title, coverPhoto: coverPhoto)
    }
}
