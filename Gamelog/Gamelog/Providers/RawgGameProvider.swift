//
//  RawgGameProvider.swift
//  Gamelog
//
//  Created by yxgg on 27/04/22.
//

import Foundation
import UIKit
import CoreData

class RawgGameProvider {
  static let shared: RawgGameProvider = RawgGameProvider()
  private init() { }
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Gamelog")
    container.loadPersistentStores { _, error in
      guard error == nil else {
        fatalError("Unresolved error \(error!)")
      }
    }
    container.viewContext.automaticallyMergesChangesFromParent = false
    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.viewContext.shouldDeleteInaccessibleFaults = true
    container.viewContext.undoManager = nil
    return container
  }()
  
  private func newTaskContext() -> NSManagedObjectContext {
    let taskContext = persistentContainer.newBackgroundContext()
    taskContext.undoManager = nil
    taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    return taskContext
  }
  
  func getAllFavorite(completion: @escaping(_ favorites: [FavoriteModel]) -> Void) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GamelogData")
      do {
        let results = try taskContext.fetch(fetchRequest)
        var favorites: [FavoriteModel] = []
        for result in results {
          let favorite = FavoriteModel(
            id: result.value(forKeyPath: "id") as? Int64,
            backgroundImage: result.value(forKeyPath: "backgroundImage") as? Data,
            thumbImage: result.value(forKeyPath: "thumbImage") as? Data,
            name: result.value(forKeyPath: "name") as? String,
            genre: result.value(forKeyPath: "genre") as? String,
            description: result.value(forKeyPath: "desc") as? String,
            platform: result.value(forKeyPath: "platform") as? String,
            developer: result.value(forKeyPath: "developer") as? String,
            publisher: result.value(forKeyPath: "publisher") as? String,
            release: result.value(forKeyPath: "releaseDate") as? String,
            rating: result.value(forKeyPath: "rating") as? String,
            tags: result.value(forKeyPath: "tags") as? String,
            website: result.value(forKeyPath: "website") as? String
          )
          favorites.append(favorite)
        }
        completion(favorites)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
  }
  
  func getFavorite(_ id: Int, completion: @escaping(_ favorites: FavoriteModel) -> Void) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GamelogData")
      fetchRequest.fetchLimit = 1
      fetchRequest.predicate = NSPredicate(format: "id == \(id)")
      do {
        if let result = try taskContext.fetch(fetchRequest).first {
          let favorite = FavoriteModel(
            id: result.value(forKeyPath: "id") as? Int64,
            backgroundImage: result.value(forKeyPath: "backgroundImage") as? Data,
            thumbImage: result.value(forKeyPath: "thumbImage") as? Data,
            name: result.value(forKeyPath: "name") as? String,
            genre: result.value(forKeyPath: "genre") as? String,
            description: result.value(forKeyPath: "desc") as? String,
            platform: result.value(forKeyPath: "platform") as? String,
            developer: result.value(forKeyPath: "developer") as? String,
            publisher: result.value(forKeyPath: "publisher") as? String,
            release: result.value(forKeyPath: "releaseDate") as? String,
            rating: result.value(forKeyPath: "rating") as? String,
            tags: result.value(forKeyPath: "tags") as? String,
            website: result.value(forKeyPath: "website") as? String
          )
          completion(favorite)
        }
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
  }
  
  func createFavorite(
    _ id: Int,
    _ backgroundImage: Data,
    _ thumbImage: Data,
    _ name: String,
    _ genre: String,
    _ description: String,
    _ platform: String,
    _ developer: String,
    _ publisher: String,
    _ release: String,
    _ rating: String,
    _ tags: String,
    _ website: String,
    completion: @escaping() -> Void
  ) {
    let taskContext = newTaskContext()
    taskContext.performAndWait {
      if let entity = NSEntityDescription.entity(forEntityName: "GamelogData", in: taskContext) {
        let favorite = NSManagedObject(entity: entity, insertInto: taskContext)
        favorite.setValue(id, forKeyPath: "id")
        favorite.setValue(backgroundImage, forKeyPath: "backgroundImage")
        favorite.setValue(thumbImage, forKeyPath: "thumbImage")
        favorite.setValue(name, forKeyPath: "name")
        favorite.setValue(genre, forKeyPath: "genre")
        favorite.setValue(description, forKeyPath: "desc")
        favorite.setValue(platform, forKeyPath: "platform")
        favorite.setValue(developer, forKeyPath: "developer")
        favorite.setValue(publisher, forKeyPath: "publisher")
        favorite.setValue(release, forKeyPath: "releaseDate")
        favorite.setValue(rating, forKeyPath: "rating")
        favorite.setValue(tags, forKeyPath: "tags")
        favorite.setValue(website, forKeyPath: "website")
        do {
          try taskContext.save()
          completion()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
      }
    }
  }
  
  func updateFavorite(
    _ id: Int,
    _ backgroundImage: Data,
    _ thumbImage: Data,
    _ name: String,
    _ genre: String,
    _ description: String,
    _ platform: String,
    _ developer: String,
    _ publisher: String,
    _ release: String,
    _ rating: String,
    _ tags: String,
    _ website: String,
    completion: @escaping() -> Void
  ) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GamelogData")
      fetchRequest.fetchLimit = 1
      fetchRequest.predicate = NSPredicate(format: "id == \(id)")
      if let result = try? taskContext.fetch(fetchRequest), let favorite = result.first as? GamelogData {
        favorite.setValue(backgroundImage, forKeyPath: "backgroundImage")
        favorite.setValue(thumbImage, forKeyPath: "thumbImage")
        favorite.setValue(name, forKeyPath: "name")
        favorite.setValue(genre, forKeyPath: "genre")
        favorite.setValue(description, forKeyPath: "desc")
        favorite.setValue(platform, forKeyPath: "platform")
        favorite.setValue(developer, forKeyPath: "developer")
        favorite.setValue(publisher, forKeyPath: "publisher")
        favorite.setValue(release, forKeyPath: "releaseDate")
        favorite.setValue(rating, forKeyPath: "rating")
        favorite.setValue(tags, forKeyPath: "tags")
        favorite.setValue(website, forKeyPath: "website")
        do {
          try taskContext.save()
          completion()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
      }
    }
  }
  
  func getMaxId(completion: @escaping(_ maxId: Int) -> Void) {
    let taskContext = newTaskContext()
    taskContext.performAndWait {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GamelogData")
      let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
      fetchRequest.sortDescriptors = [sortDescriptor]
      fetchRequest.fetchLimit = 1
      do {
        let lastFavorite = try taskContext.fetch(fetchRequest)
        if let favorite = lastFavorite.first, let position = favorite.value(forKeyPath: "id") as? Int {
          completion(position)
        } else {
          completion(0)
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
  func deleteAllFavorite(completion: @escaping() -> Void) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GamelogData")
      let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
      batchDeleteRequest.resultType = .resultTypeCount
      if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
        if batchDeleteResult.result != nil {
          completion()
        }
      }
    }
  }
  
  func deleteFavorite(_ id: Int, completion: @escaping() -> Void) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GamelogData")
      fetchRequest.fetchLimit = 1
      fetchRequest.predicate = NSPredicate(format: "id == \(id)")
      let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
      batchDeleteRequest.resultType = .resultTypeCount
      if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
        if batchDeleteResult.result != nil {
          completion()
        }
      }
    }
  }
  
  func checkGameData(_ id: Int, completion: @escaping(_ favorites: Bool) -> Void) {
    let taskContext = newTaskContext()
    taskContext.perform {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GamelogData")
      fetchRequest.fetchLimit = 1
      fetchRequest.predicate = NSPredicate(format: "id == \(id)")
      do {
        if let _ = try taskContext.fetch(fetchRequest).first {
          completion(true)
        } else {
          completion(false)
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}
