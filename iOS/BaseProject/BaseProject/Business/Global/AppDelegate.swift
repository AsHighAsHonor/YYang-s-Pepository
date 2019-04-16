//
//  AppDelegate.swift
//  TheBod
//
//  Created by YYang1 on 11/10/18.
//  Copyright © 2018 PixelForceSystems. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import IQKeyboardManagerSwift
import FBSDKCoreKit
import FBSDKLoginKit
import UserNotifications
import AWSCore
import AWSMobileClient
import AWSPinpoint



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?
    let bag = DisposeBag()
    var pinpoint: AWSPinpoint?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureThirdServices(launchOptions: launchOptions)
       
        window = UIWindow(frame: UIScreen.main.bounds)
//        if UserDefaults.UserInfo.string(forKey: .accessToken) != nil {
//            let tabCtrl = TBTabBarController()
//            window?.rootViewController =  tabCtrl
//        }else{
//            let loginHomeCtrl = LoginViewController()
//            let nav = TBNavigationController(rootViewController: loginHomeCtrl)
//            nav.isNavigationBarHidden = true
//            window?.rootViewController =  nav
//        }
        
        window?.makeKeyAndVisible()
        
        
        return AWSMobileClient.sharedInstance().interceptApplication(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: nil)
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.hexString
        YYLog("DeviceToken: \(token)")
//        UserDefaults.UserInfo.set(value: token, forKey: .deviceToken)
//        if UserDefaults.UserInfo.string(forKey: .accessToken) != nil {
//            LoginNetworkService.uploadDeviceToken(token: token).subscribe().disposed(by: bag)
//        }
        
        pinpoint!.notificationManager.interceptDidRegisterForRemoteNotifications(withDeviceToken: deviceToken)


    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        YYLog("FailToRegisterNotification: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        YYLog("DidReceiveRemoteNotification \(userInfo)")
//        NotificationCenter.default.post(name: .NewsFeedWillRefreshNotification, object: nil, userInfo: userInfo)
        
        pinpoint!.notificationManager.interceptDidReceiveRemoteNotification(userInfo, fetchCompletionHandler: completionHandler)
        
        if (application.applicationState == .active) {
        }
        else if (application.applicationState == .inactive) {
        }
        else if (application.applicationState == .background) {
        }
        completionHandler(.newData);

        
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(UNNotificationPresentationOptions(rawValue: UNNotificationPresentationOptions.alert.rawValue | UNNotificationPresentationOptions.sound.rawValue | UNNotificationPresentationOptions.badge.rawValue));

    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        
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
//        if UserDefaults.UserInfo.string(forKey: .accessToken) != nil {
//            NotificationCenter.default.post(name: .StoreViewWillBeginRefreshNotification, object: nil, userInfo: nil)
//        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate{
    
    func configureThirdServices(launchOptions: [UIApplication.LaunchOptionsKey: Any]?)  {
        Fabric.with([Crashlytics.self])
        
//         Initialize Pinpoint
        let pinpointConfiguration = AWSPinpointConfiguration.defaultPinpointConfiguration(launchOptions: launchOptions)
        pinpoint = AWSPinpoint(configuration: pinpointConfiguration)
        
        AWSDDLog.add(AWSDDTTYLogger.sharedInstance)
        AWSDDLog.sharedInstance.logLevel = .info

        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            // 1. Check if permission granted
            guard granted else { return }
            // 2. Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

    }
    
    
}

