//
//  AppDelegate.swift
//  RiderClient
//
//  Created by Neo Ighodaro on 12/02/2018.
//  Copyright © 2018 CreativityKills Co. All rights reserved.
//

import UIKit
import GoogleMaps
import PushNotifications
import InstantSearch

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let pushNotifications = PushNotifications.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey(AppConstants.GOOGLE_API_KEY)
        
        self.pushNotifications.start(instanceId: AppConstants.PUSH_NOTIF_INSTANCE_ID)
        self.pushNotifications.registerForRemoteNotifications()
        InstantSearch.shared.configure(appID: "L2P2Y6H5NN", apiKey: "a614060989c1ca26f2f864bee834cf80", index: "grubhub")
//        InstantSearch.shared.params.attributesToRetrieve = ["dish_name", "salePrice"]
//        InstantSearch.shared.params.attributesToHighlight = ["dish_name"]

        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.pushNotifications.registerDeviceToken(deviceToken) {
            try? self.pushNotifications.subscribe(interest: "rider_\(AppConstants.USER_ID)")
        }
    }
}

