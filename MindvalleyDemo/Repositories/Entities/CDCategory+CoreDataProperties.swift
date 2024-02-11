//
//  CDCategory+CoreDataProperties.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 11/2/24.
//
//

import Foundation
import CoreData


extension CDCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCategory> {
        return NSFetchRequest<CDCategory>(entityName: "CDCategory")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?

}

extension CDCategory : Identifiable {

}
