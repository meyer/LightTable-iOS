//
//  AppDelegate.swift
//  Light Table
//
//  Created by Mike Meyer on 2014/10/22.
//  Copyright (c) 2014 Meyer Co. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()

    func saveLightboxBrightness(){
        var brightness = Float(UIScreen.mainScreen().brightness)
        userDefaults.setFloat(brightness, forKey: "lightboxBrightness")
        userDefaults.synchronize()
        println("Saved app-set brightness: \(brightness)")
    }

    func restoreLightboxBrightness(){
        var brightness: CGFloat = -2.0
        if (userDefaults.objectForKey("lightboxBrightness") as? CGFloat != nil) {
            brightness = userDefaults.objectForKey("lightboxBrightness") as CGFloat
            UIScreen.mainScreen().brightness = brightness
        }
        println("Restored app-set brightness: \(brightness)")
    }
    
    func saveUserBrightness(){
        var brightness = Float(UIScreen.mainScreen().brightness)
        userDefaults.setFloat(brightness, forKey: "userBrightness")
        userDefaults.synchronize()
        println("Saved user-set brightness: \(brightness)")
    }

    func restoreUserBrightness(){
        var brightness: CGFloat = -1.0
        if (userDefaults.objectForKey("userBrightness") as? CGFloat != nil) {
            brightness = userDefaults.objectForKey("userBrightness") as CGFloat
            UIScreen.mainScreen().brightness = brightness
        }
        println("Restored user-set brightness: \(brightness)")
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        restoreLightboxBrightness()

        window?.backgroundColor = UIColor.blackColor()
        return true
    }

    func applicationDidEnterBackground(application: UIApplication) {
        saveLightboxBrightness()
        restoreUserBrightness()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        saveUserBrightness()
        restoreLightboxBrightness()
    }

    func applicationDidBecomeActive(application: UIApplication) {
        saveUserBrightness()
        restoreLightboxBrightness()
    }

    func applicationWillResignActive(application: UIApplication) {}
    
    func applicationWillTerminate(application: UIApplication) {}
}

