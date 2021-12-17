//
//  Folder.swift
//  Perspective
//
//  Created by Csaba Kuti on 15/04/2021.
//

import Foundation
import CoreData

@objc(Folder)
public class Folder: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Folder> {
        return NSFetchRequest<Folder>(entityName: "Folder");
      }

    // Attributes
    @NSManaged public var timeStamp: Date?
    @NSManaged public var name: String?
    
    // Relationships
    @NSManaged public var organizes: Perspective?

}
