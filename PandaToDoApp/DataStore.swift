//
//  DataStore.swift
//  PandaToDoApp
//
//  Created by Missy Allan on 2/28/17.
//  Copyright © 2017 PandaLabs. All rights reserved.
//

import Foundation
import CoreData

class DataStore {
    
    
    private init() {}
    static let sharedInstance = DataStore()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "PandaToDoApp")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
}
