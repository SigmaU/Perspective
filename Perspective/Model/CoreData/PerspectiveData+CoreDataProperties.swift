//
//  PerspectiveData.swift
//  Perspective
//
//  Created by Csaba Kuti on 15/04/2021.
//

import Foundation
import CoreData

@objc(PerspectiveData)
public class PerspectiveData: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PerspectiveData> {
        return NSFetchRequest<PerspectiveData>(entityName: "PerspectiveData")
    }

    // Attributes
    @NSManaged public var timeStamp: Date
    @NSManaged public var name: String?
    @NSManaged public var x: Double
    @NSManaged public var y: Double
    
    // Relationships
    @NSManaged public var belongsTo: Perspective?


}
