//
//  ViewController.swift
//  Light Table
//
//  Created by Mike Meyer on 2014/10/22.
//  Copyright (c) 2014 Meyer Co. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var LBAppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.cornerRadius = 4
        var pan = UIPanGestureRecognizer(target:self, action:"handlePan:")
        pan.maximumNumberOfTouches = 2
        pan.minimumNumberOfTouches = 2
        self.view.addGestureRecognizer(pan)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    var startBrightness:CGFloat = 0.0
    var maxBrightness:CGFloat = 1.0
    var minBrightness:CGFloat = 0.0
    
    func handlePan(recogniser:UIPanGestureRecognizer) {
        let translation = recogniser.translationInView(self.view)
        let location:CGPoint = recogniser.locationInView(self.view)

//        These values are orientation-dependent
        let deviceBounds: CGRect = UIScreen.mainScreen().bounds
        let deviceWidth:CGFloat = deviceBounds.size.width
        let deviceHeight:CGFloat = deviceBounds.size.height

//        println("width: \(deviceWidth), height: \(deviceHeight), x: \(translation.x), y: \(translation.y)")
        
        switch recogniser.state {
        case .Began:
            println("began")
            startBrightness = UIScreen.mainScreen().brightness
            println(startBrightness)

        case .Changed:
//            Always ensure the longest side is the controlling side
            var diff = translation.x
            if deviceHeight > deviceWidth {
//                Up == brighter for portrait orientation
                diff = translation.y * -1
            }
            
            var newBrightness = round(startBrightness * 100 + diff / 3) / 100
            println(newBrightness)
            
            if newBrightness >= minBrightness && newBrightness <= maxBrightness {
                UIScreen.mainScreen().brightness = newBrightness
            }
            
        case .Ended:
            println("ended")
            LBAppDelegate.saveLightboxBrightness()
            
        case .Possible:
            println("possible")

        case .Cancelled:
            println("cancelled")

        case .Failed:
            println("failed")
        }
    
    }
}

