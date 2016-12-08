 //
//  AppDelegate.swift
//  Gouda0916
//
//  Created by Douglas Galante on 11/14/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//
//

import UIKit
import CoreData
import Firebase
import UserNotifications
 
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   
    let store = DataStore.sharedInstance
    
    var window: UIWindow?

    override init() {
        super.init()
        FIRApp.configure()
        FIRDatabase.database().persistenceEnabled = false
    }
    
    //backing up in firebase
    func backupFirebase(goals: [Goal]) {
        let ref =  FIRDatabase.database().reference()
        
        for goal in goals {
            if let firebaseID = goal.firebaseID {
                ref.child("goals").child(firebaseID).updateChildValues(goal.serializeGoalIntoDictionary())
            } else {
                print("didnt have a firebase ID saved")
            }
        }
    }
    
    //Creating trigger that sets calendar notifications and repeats at a specific time
    func scheduleNotification(at date: Date) {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (61), repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = "Tutorial Reminder"
        content.body = "Just a reminder to read your tutorial over at appcoda.com!"
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
        
        // UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
        application.registerForRemoteNotifications()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        store.fetchData()
  
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }

 }

