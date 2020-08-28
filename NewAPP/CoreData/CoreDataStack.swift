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
    func saveNews(article: Article,completion: (_ complete: Bool) -> ()) {
        guard let newsArticeEntity = NSEntityDescription.entity(forEntityName: CoreDataName.NewsArticleEntity.rawValue, in: self.managedObjectContext) else{
            return completion(false)
            
        }
        let newsArticleCD = NewsArticle(entity: newsArticeEntity, insertInto: self.managedObjectContext)
        newsArticleCD.article_title = article.title ?? ""
        newsArticleCD.article_id = article.source?.id ?? ""
        newsArticleCD.article_author = article.author ?? ""
        newsArticleCD.article_name = article.source?.name ?? ""
        newsArticleCD.article_description = article.articleDescription ?? ""
        newsArticleCD.article_url = article.url ?? ""
        newsArticleCD.article_image_url = article.urlToImage ?? ""
        newsArticleCD.article_published_at = article.publishedAt ?? ""
        newsArticleCD.article_content = article.content ?? ""
        self.saveMainContext()
        completion(true)
    }
    func saveNewsArticle(newsArticle: NewsArticle,completion: (_ complete: Bool) -> ()) {
        guard let newsArticeEntity = NSEntityDescription.entity(forEntityName: CoreDataName.NewsArticleEntity.rawValue, in: self.managedObjectContext) else{
            return completion(false)
            
        }
        let newsArticleCD = NewsArticle(entity: newsArticeEntity, insertInto: self.managedObjectContext)
        newsArticleCD.article_title = newsArticle.article_title ?? ""
        newsArticleCD.article_id = newsArticle.article_id ?? ""
        newsArticleCD.article_author = newsArticle.article_author ?? ""
        newsArticleCD.article_name = newsArticle.article_name ?? ""
        newsArticleCD.article_description = newsArticle.article_description ?? ""
        newsArticleCD.article_url = newsArticle.article_url ?? ""
        newsArticleCD.article_image_url = newsArticle.article_image_url ?? ""
        newsArticleCD.article_published_at = newsArticle.article_published_at ?? ""
        newsArticleCD.article_content = newsArticle.article_content ?? ""
        self.saveMainContext()
        completion(true)
    }
    
    func deleteAllFromCoreData(completion: (_ complete: Bool) -> ()) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataName.NewsArticleEntity.rawValue)
        
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
            
            completion(true)
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completion(false)
        }
    }
    func checkObjectAlreadySaved(sourceName:String,author:String,completion: (_ complete: Bool) -> ()) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataName.NewsArticleEntity.rawValue)
        let predicate = NSPredicate(format: "article_name CONTAINS[c] %@ OR article_author CONTAINS[c] %@",sourceName,author)
        fetchRequest.predicate = predicate
        if let articleResult = try? managedObjectContext.fetch(fetchRequest) as? [NewsArticle] {
            if articleResult.count == 0 {
                completion(false)
            }
            else {
                completion(true)
            }
        }
    }
    func deleteObjectFromCoreData(sourceName:String,author:String,completion: (_ complete: Bool) -> ()) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataName.NewsArticleEntity.rawValue)
        let predicate = NSPredicate(format: "article_name CONTAINS[c] %@ OR article_author CONTAINS[c] %@",sourceName,author)
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
            
            completion(true)
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completion(false)
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
