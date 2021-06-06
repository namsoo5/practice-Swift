//
//  AppDelegate.swift
//  prac_AppLifeCycle
//
//  Created by 남수김 on 21/01/2019.
//  Copyright © 2019 남수김. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //didfinish보다 먼저실행
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print(#function)
//        print("willfinish")
        return true;
    }
    
    //앱초기화 작업할때 사용가능, 앱실행시 1번만실행되는함수
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print(#function)
//        print("didfinish")
        return true
    }

    //잠시 전환되는경우, 문자나 전화가오는경우
    func applicationWillResignActive(_ application: UIApplication) {
        print(#function)
//        print("willresign")
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        (window?.rootViewController as? UIViewController)?.view.backgroundColor = .gray
    }

    //백그라운드로 전환시
    func applicationDidEnterBackground(_ application: UIApplication) {
        print(#function)
//        print("didenter")
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    //백그라운드에서다시 포그라운드로전환
    func applicationWillEnterForeground(_ application: UIApplication) {
        print(#function)
//        print("willenter")
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    //다시활성화가능, 홈버튼갓다오면 다시호출됨, 화면으로 돌아올때마다 실행
    func applicationDidBecomeActive(_ application: UIApplication) {
        print(#function)
        (window?.rootViewController as? UIViewController)?.view.backgroundColor = .white
//        print("didbecome")
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    //앱종료시
    func applicationWillTerminate(_ application: UIApplication) {
        print(#function)
//        print("willterminate")
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

