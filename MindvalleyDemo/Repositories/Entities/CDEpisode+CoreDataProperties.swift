//
//  CDEpisode+CoreDataProperties.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 11/2/24.
//
//

import Foundation
import CoreData


extension CDEpisode {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEpisode> {
        return NSFetchRequest<CDEpisode>(entityName: "CDEpisode")
    }

    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var coverPhoto: String
    @NSManaged public var channel: String

}

extension CDEpisode : Identifiable {
    func convertToEpisode() -> EpisodeItem {
        return EpisodeItem(
            id: id,
            title: title,
            coverPhoto: coverPhoto,
            channel: channel)
    }
}
