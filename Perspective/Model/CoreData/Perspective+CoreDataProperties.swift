//
//  Perspective+CoreDataProperties.swift
//  Perspective iOS
//
//  Created by Csaba Kuti on 14/04/2021.
//

import Foundation
import CoreData

@objc(Perspective)
public class Perspective: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Perspective> {
        return NSFetchRequest<Perspective>(entityName: "Perspective");
      }
    
    // Attributes
    @NSManaged public var timeStamp: Date?
    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var yAxisName: String
    @NSManaged public var xAxisName: String
    @NSManaged public var yAxisUnit: String
    @NSManaged public var xAxisUnit: String
    @NSManaged public var horizontalLine: Double
    @NSManaged public var verticalLine: Double

    
    // Relationships
    @NSManaged public var containedIn: Folder?
    @NSManaged public var has: Set<PerspectiveData>?

}
