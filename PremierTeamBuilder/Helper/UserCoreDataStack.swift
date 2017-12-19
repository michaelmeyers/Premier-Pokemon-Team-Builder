//
//  UserCoreDataStack.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 12/18/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation

import CoreData

class UserCoreDataStack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PremierTeamBuilder2")
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { return container.viewContext }
}
