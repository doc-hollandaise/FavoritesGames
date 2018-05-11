//
//  VideoGame+CoreDataProperties.swift
//  
//
//  Created by Derek Justus on 5/10/18.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension VideoGame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VideoGame> {
        return NSFetchRequest<VideoGame>(entityName: "VideoGame")
    }

    @NSManaged public var addedDate: Date?
    @NSManaged public var gameDesc: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var url: String?

}
