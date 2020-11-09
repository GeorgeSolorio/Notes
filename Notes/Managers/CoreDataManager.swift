//
//  CoreDataManager.swift
//  Notes
//
//  Created by George Solorio on 11/2/20.
//

import CoreData
import UIKit
import Foundation

final class CoreDataManager {
   
   // MARK: - Properties
   
   private let modelName: String
   
   // MARK: - Initialization
   
   init(modelName: String) {
      self.modelName = modelName
      
      setupNotificationHandling()
   }
   
   // MARK: - Private helper functions
   
   private func setupNotificationHandling() {
      
      let notificationCenter = NotificationCenter.default
      
      notificationCenter
         .addObserver(self,
                      selector: #selector(saveChanges(_:)),
                      name: UIApplication.willTerminateNotification, object: nil)
      
      notificationCenter
         .addObserver(self,
                      selector: #selector(saveChanges(_:)),
                      name: UIApplication.didEnterBackgroundNotification, object: nil)
   }
   
   @objc func saveChanges(_ notification: Notification) {
      saveChanges()
   }
   
   private func saveChanges() {
      
      guard managedObjectContext.hasChanges else { return }
      
      do {
         try managedObjectContext.save()
      } catch {
         print("Unable to Save Managed Object Context")
         print("\(error) \(error.localizedDescription)")
      }
   }
   
   private(set) lazy var managedObjectContext: NSManagedObjectContext = {
      let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
      
      managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
      
      return managedObjectContext
   }()
   
   private lazy var managedObjectModel: NSManagedObjectModel = {
      
      guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
         fatalError("Unable to find data model")
      }
      
      guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
         fatalError("Unable to Load Data Model")
      }
      
      return managedObjectModel
   }()
   
   private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
      let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
      
      let fileManager = FileManager.default
      let storeName = "\(self.modelName).sqlite"
      
      let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
      
      let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
      
      print(persistentStoreURL)
      do {
         try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                           configurationName: nil,
                                                           at: persistentStoreURL,
                                                           options: nil)
      } catch {
          fatalError("Unable to Add Persistent Store")
      }
      return persistentStoreCoordinator
   }()
}
