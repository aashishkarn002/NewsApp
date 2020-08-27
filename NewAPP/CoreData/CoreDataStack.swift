//
//  CoreDataStack.swift
//  NewsAPP
//
//  Created by Aashish on 8/27/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack: NSObject {
    static let moduleName = CoreDataName.ModelName.rawValue
    
    func saveMainContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                fatalError("Error saving main managed object context \(error)")
            }
        }
    }
    func deleteAllFromCoreData(_ entity:String,completion: @escaping () -> () ) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
        
        do {
            let tasks = try managedObjectContext.fetch(fetchRequest)
            for data in tasks {
                managedObjectContext.delete(data)
            }
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            completion()
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completion()
        }
    }
    func deleteObjectFromCoreData(_ entity:String,sourceName:String,authorName:String,completion: @escaping () -> () ) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
        let predicate = NSPredicate(format: "name CONTAINS[c] %@ OR author CONTAINS[c] %@",sourceName,authorName)
        fetchRequest.predicate = predicate
        
        do {
            let tasks = try managedObjectContext.fetch(fetchRequest)
            for data in tasks {
                managedObjectContext.delete(data)
            }
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            completion()
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completion()
        }
    }
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: CoreDataStack.moduleName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var applicationDocumentsDirectory: NSURL = {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last! as NSURL
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let persistenceStoreURL = self.applicationDocumentsDirectory.appendingPathComponent("\(CoreDataStack.moduleName).sqlite")
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistenceStoreURL, options: [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true])
        } catch {
            fatalError("Persistent Store Error! \(error)")
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
}
