//
//  DataStore.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/18/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import Foundation
import CoreData
import CoreGraphics

class DataStore {


    static let sharedInstance = DataStore()



    private init() {}

    var goals: [Goal] = []
    var userName = User()
    var progress: Double = 0
    var velocity: CGFloat = 0
    var daysLeft: Double = 0

    //total days
    var days: CGFloat = 0

    // Velocity Variables
    var graphPoints = [0, 10, 8, 2, 9, 7, 10, 9, 0]
    var velocityHistory: [Date : Double] = [Velocity.lastCentury : 100]
    var currentVelocityScore: Double = 0
    var pointIndex: Int = 7
    
    



    //day counter = how many days have passed
    //time frame = total days
    //days left - how many days are left until the total days as indicated by user (calc prop) - goal extension






    func fetchData() {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do {
            goals = try context.fetch(fetchRequest)
            if !goals.isEmpty {
                for (index, goal) in goals.enumerated() {
                    if goal.isActiveGoal {
                        goals.remove(at: index)
                        goals.insert(goal, at: 0)
                        break
                    }
                }
            }
        }catch {
            print("couldnt get goals from fetch request")
        }




    }


    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Gouda0916")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

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
