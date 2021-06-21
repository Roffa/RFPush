//
//  AppDelegate.swift
//  LSPush
//
//  Created by zrf on 06/16/2021.
//  Copyright (c) 2021 zrf. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        registerAppNotificationSettings(launchOptions: launchOptions)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

//原生远程推送
extension AppDelegate: UNUserNotificationCenterDelegate{
    private func registerAppNotificationSettings(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        if #available(iOS 10.0, *) {
            let notifiCenter = UNUserNotificationCenter.current()
            notifiCenter.delegate = self
            let types = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
            notifiCenter.requestAuthorization(options: types) { (flag, error) in
                if flag {
                    print("iOS request notification success")
                }else{
                    print(" iOS 10 request notification fail")
                }
            }
        } else { //iOS8,iOS9注册通知
        }
        
        UIApplication.shared.registerForRemoteNotifications()
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        var token: String = ""
        for i in 0..<deviceToken.count {
            token += String(format: "%02.2hhx", deviceToken[i] as CVarArg)
        }
        
        print("Token: ",token)  //214505ea6b58a848364892a420f7dddd3f96bc13f1e43541be66f86bd0b95abf
        
        //print("Token: ", token)
        print(deviceToken.map { String(format: "%02.2hhx", arguments: [$0]) }.joined() , "推送 deviceToken" )

    }


    @available(iOS 10.0, *)

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void){
        let userInfo = notification.request.content.userInfo
        print("userInfo10:\(userInfo)")
        completionHandler([.sound,.alert])
        
    }

    //iOS10新增：处理后台点击通知的代理方法
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: () -> Void){
        let userInfo = response.notification.request.content.userInfo
        print("userInfo10:\(userInfo)")
        completionHandler()
    }
}
