//
//  CoreDataUtil.swift
//  PhotoGalleryApp
//
//  Created by Satyam Sehgal on 22/10/18.
//  Copyright © 2018 Satyam Sehgal. All rights reserved.
//

import Foundation
import CoreData

class CoreDataUtil {
    static var managedObjectContext: NSManagedObjectContext?

    static func saveContext() {
        DispatchQueue.main.async {
            CoreDataStack.sharedInstance.saveContext()
        }
    }

    static func setupManagedObjectContext() {
        if managedObjectContext == nil {
            self.managedObjectContext = CoreDataStack.sharedInstance.persistentContainer.viewContext
            managedObjectContext?.mergePolicy =  NSMergeByPropertyObjectTrumpMergePolicy
        }
    }

    static func createNewObject(ofType entityName: String, inContext: NSManagedObjectContext? = CoreDataUtil.managedObjectContext) -> NSManagedObject? {
        if let entity = NSEntityDescription.entity(forEntityName: entityName, in: inContext!) {
            return NSManagedObject.init(entity: entity, insertInto: inContext)
        }
        return nil
    }

    static func fetchObjectsFromCoreData<T: NSManagedObject>(fetchRequest: NSFetchRequest<T>, predicate: NSPredicate?, inContext: NSManagedObjectContext? = CoreDataUtil.managedObjectContext) -> [T]? {
        fetchRequest.predicate = predicate
        do {
            return try inContext?.fetch(fetchRequest)
        } catch {
            print("error while fetching the objects")
            return nil
        }
    }

}
