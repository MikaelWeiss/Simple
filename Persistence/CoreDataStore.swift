//
//  CoreDataStore.swift
//  PersistenceTests
//
//  Created by Mikael Weiss on 2/15/21.
//

import CoreData
import os.log

public class CoreDataStore {
    
    public enum StorageType {
        case persistent
        case inMemory
    }
    
    /// Using a store other than the default store may result in an inaccurate context.
    public static let `default` = CoreDataStore()
    
    private let container: NSPersistentContainer
    
    private init(container: NSPersistentContainer) {
        self.container = container
        self.container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    public convenience init(storageType: StorageType = .persistent) {
        let bundle = Bundle(for: CoreDataStore.self)
        
        guard let modelURL = bundle.url(forResource: "Simple", withExtension: "momd") else {
            os_log(.error, log: .persistence, "Unable to generate model url in bundle: %@.", bundle)
            fatalError()
        }
        
        // Managed Object Model - Simple.xcdatamodeld (stored as Simple.momd)
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            os_log(.error, log: .persistence, "Unable to load core data model from url: %@!", modelURL as NSURL)
            fatalError()
        }
        
        let container: NSPersistentContainer
        switch storageType {
        case .persistent:
            container = Self.persistentContainer(model: model)
        case .inMemory:
            container = Self.inMemoryContainer(model: model)
        }
        
        
        container.loadPersistentStores { store, error in
            if let error = error as NSError? {
                os_log(.error, log: .persistence, "Unable to load stores! Error: %@; Info: %@", error, error.userInfo)
                fatalError()
            }
            os_log(.info, log: .persistence, "Store: %@", store)
        }
        
        self.init(container: container)
    }
    
    private static func persistentContainer(model: NSManagedObjectModel) -> NSPersistentContainer {
        guard let docURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last else {
            os_log(.info, log: .persistence, "Failed to resolve documents directory.")
            fatalError("Failed to resolve documents directory")
        }
        
        // Persistant Store - the file that is saved to the device. eg. ``Simple.sqlite``
        let localStore = NSPersistentStoreDescription(url: docURL.appendingPathComponent("Simple.sqlite"))
        
        // Persistent Container - the object that holds the Model, Context, and Coordinator.
        let container = NSPersistentContainer(name: "Container", managedObjectModel: model)
        container.persistentStoreDescriptions = [localStore]
        
        return container
    }
    
    private static func inMemoryContainer(model: NSManagedObjectModel) -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "Model", managedObjectModel: model)
        let description = NSPersistentStoreDescription(url: URL(fileURLWithPath: "/dev/null"))
        container.persistentStoreDescriptions = [description]
        
        return container
    }
    
    // MARK: - Save
    
    public func save() throws {
        guard container.viewContext.hasChanges else { return }
        
        do {
            try container.viewContext.save()
        } catch {
            os_log(.error, log: .persistence, "Failed to save. Error 🔥: %@", error as NSError)
            throw error
        }
    }
    
    // MARK: - Delete All
    
    public func deleteAll() throws {
        let entityNames = container.managedObjectModel.entities.compactMap { $0.name }
        
        for entityName in entityNames {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try container.viewContext.execute(batchDeleteRequest)
                try save()
            } catch {
                os_log(.error, log: .persistence, "Failed to delete all. Error: %@", error as NSError)
                throw error
            }
        }
    }
    
    // MARK: - Task
    
    public func newTask() -> Persistence.Task {
        NSEntityDescription.insertNewObject(
            forEntityName: "Task",
            into: container.viewContext) as! Task
    }
    
    public func getTask(with id: UUID) throws -> Persistence.Task? {
        let tasks: [Task]
        let request = NSFetchRequest<Task>(entityName: "Task")
        request.predicate = NSPredicate(format: "%K == %@", (\Task.id)._kvcKeyPathString!, id as CVarArg)
        
        do {
            tasks = try container.viewContext.fetch(request)
        } catch {
            os_log(.error, log: .persistence, "Failed to get task. Error: %@", error as NSError)
            throw error
        }
        
        return tasks.first
    }
    
    public func deleteTask(with id: UUID) throws {
        do {
            if let task = try getTask(with: id) {
                container.viewContext.delete(task)
            }
        } catch {
            os_log(.error, log: .persistence, "Failed to delete task. Error: %@", error as NSError)
            throw error
        }
    }
    
    public func getAllTasks() throws -> [Task] {
        let tasks: [Task]
        let request = NSFetchRequest<Task>(entityName: "Task")
        
        do {
            tasks = try container.viewContext.fetch(request)
        } catch {
            os_log(.error, log: .persistence, "Failed to get task. Error: %@", error as NSError)
            throw error
        }
        
        return tasks
    }
}
