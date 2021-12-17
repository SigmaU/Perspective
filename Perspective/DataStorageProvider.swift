//
//  StorageProvider.swift
//  Perspective
//
//  Created by Csaba Kuti on 09.03.2021.
//

import UIKit
import CoreData

class DataStorageProvider {
    
    // MARK: - Data Storage Provider
    let appDelegate = AppDelegate.shared
    var viewContext: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    let persistentContainer: NSPersistentContainer
    
    init(for modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
        persistentContainer.loadPersistentStores(completionHandler: { description, error in
            if let error = error as NSError? {
                fatalError("Core Data store failed to load with error:\(error), \(error.userInfo)")
            }
        })
        print("DataStorageProvider Instantiated with persistent container.")
    }
    
    // MARK: - Data Storage Controller
    
    @discardableResult
    func saveContext() -> Error? {
        do {
            try viewContext.save()
            return nil
        } catch let error as NSError {
            viewContext.rollback()
            return error
        }
    }
    
    // MARK: - Fetch and Refresh

    func fetchResultsController<T: NSManagedObject>(_ type: T.Type, sortDescriptor: [NSSortDescriptor] = [], delegate: NSFetchedResultsControllerDelegate) -> NSFetchedResultsController<T> {
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest(T.self, sortDescriptor), managedObjectContext: self.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = delegate
        return controller
    }
    
    private func fetchRequest<T: NSManagedObject>(_ type: T.Type, _ sortDescriptor: [NSSortDescriptor]) -> NSFetchRequest<T> {
        let request: NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
        request.sortDescriptors = sortDescriptor
        return request
    }
    
    private func fetch<T: NSManagedObject>(_ type: T.Type, with predicate: NSPredicate? = nil) -> [T] {
        var fetchObjects: [T] = []
        fetch(type, with: predicate) { result in
            switch result {
            case .success(let objects):
                fetchObjects = objects
            case .failure(let error):
                print("Localized Error: \(error.localizedDescription)")
            }
        }
        return fetchObjects
    }
    
    private func fetch<T: NSManagedObject>(_ type: T.Type, with predicate: NSPredicate?, completion: @escaping (Result<[T], Error>) -> ()) {
        
        let fetchRequest = T.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.relationshipKeyPathsForPrefetching = ["Events-Comments Relationship Name"]

        
        if let _ = predicate {
            fetchRequest.predicate = predicate
        }

        do {
            let result = try viewContext.fetch(fetchRequest) as! [T]
            completion(.success(result))
        } catch {
            completion(.failure(error))
        }
    }
    
    // MARK: - Add Data
    
    func addData(for entity: NSManagedObject) {
        if let error = saveContext() {
            print("Localized Error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Delete Data
    func deleteAll<T: NSManagedObject>(_ type: T.Type) {
        deleteAll(T.self, with: nil) { (error) in
            if let error = error {
                print("Localized Error: \(error.localizedDescription)")
            }
        }
    }
    
    func delete<T: NSManagedObject>(_ object: T) {
        if let error = deleteObject(object) {
            print("Localized Error: \(error.localizedDescription)")
        }
    }
    
    private func deleteAll<T: NSManagedObject>(_ type: T.Type, with predicate: NSPredicate?, completion: @escaping (Error?) -> ()) {
        
        fetch(T.self, with: predicate) { [weak self] result in
            self?.deleteResult(result, completion: completion)
        }
    }
    
    private func deleteObject<T: NSManagedObject>(_ object: T) -> Error? {
        viewContext.delete(object)
        return saveContext()
    }
    
    private func deleteResult<T: NSManagedObject>(_ result: Result<[T], Error>, completion: @escaping (Error?) -> ()) {
        switch result {
        case .success(let objects):
            if let error = deleteObjects(objects) {
                completion(error)
                return
            }
        case .failure(let error):
            print("Localized Error: \(error.localizedDescription)")
        }
        completion(nil)
    }
    
    private func deleteObjects<T: NSManagedObject>(_ objects: [T]) -> Error? {
        objects.forEach {
            viewContext.delete($0)
        }
        do {
            try viewContext.save()
            return nil
        } catch let error as NSError {
            viewContext.rollback()
            return error
        }
    }
    
}

struct CoreDataError {
    static let noAppDelegate = NSError(domain: "No App Delegate", code: 1, userInfo: nil)
}
