//
//  Photos+CoreDataProperties.swift
//  
//
//  Created by Satyam Sehgal on 22/10/18.
//
//

import Foundation
import CoreData


extension Photos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photos> {
        return NSFetchRequest<Photos>(entityName: "Photos")
    }

    @NSManaged public var url: String?
}
