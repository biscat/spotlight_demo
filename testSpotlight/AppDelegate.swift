//
//  AppDelegate.swift
//  testSpotlight
//
//  Created by William Wong on 15/12/2015.
//  Copyright © 2015 Fleetmatics. All rights reserved.
//

import UIKit
import CoreSpotlight

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(application: UIApplication, continueUserActivity userActivity: NSUserActivity, restorationHandler: ([AnyObject]?) -> Void) -> Bool {
        if userActivity.activityType == CSSearchableItemActionType {
            //this activity represents an item indexed using core spotlight, so restore the context related to the unique identifier
            let uniqueIdentifier = userActivity.userInfo? [CSSearchableItemActivityIdentifier] as? String
            print (uniqueIdentifier)
            
            let navigationController = self.window?.rootViewController as! UINavigationController
            let viewController = navigationController.topViewController as! ViewController
            viewController.restoreUserActivityState(userActivity)
            
        } else if userActivity.activityType == "com.fleetmatics.testSpotlight.cells" {   //this is search item created through user activity
            let navigationController = self.window?.rootViewController as! UINavigationController
            let viewController = navigationController.topViewController as! ViewController
            viewController.restoreUserActivityState(userActivity)
        }
        return true
    }

}

