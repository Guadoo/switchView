//
//  AppDelegate.swift
//  switchViews
//
//  Created by Liu Jingkai on 15/9/13.
//  Copyright (c) 2015年 Liu Jingkai. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    // 背景视图
    var appBackground: UIView?
    // 切换视图
    var switchView: UIView?
    // 视图切换 Button
    var switchIcon: UIButton?
    // 显示状态变量
    var viewShowing: Bool = false
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // 初始化 Window
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window!.backgroundColor = UIColor.whiteColor()
        window!.makeKeyAndVisible()
        
        // 设置 背景视图
        appBackground = UIView(frame: CGRectMake(0, 20, self.window!.bounds.size.width, (self.window!.bounds.size.height-20)))
        appBackground!.backgroundColor = UIColor.greenColor()
        self.window!.addSubview(appBackground!)
        
        // 设置 替换视图
        switchView = UIView(frame: CGRectMake(0, 40, self.window!.bounds.size.width, (self.window!.bounds.size.height-40)))
        switchView!.backgroundColor = UIColor.blueColor()
        switchView!.alpha = 0.0
        switchView!.transform = CGAffineTransformMakeScale(0.9, 0.9)
        self.window!.addSubview(switchView!)
        
        // 设置 switchIcon 的 Button
        switchIcon  = UIButton(frame: CGRectMake(self.window!.bounds.size.width-49, 19, 49, 44))
        switchIcon!.setImage(UIImage(named: "switchIcon"), forState: UIControlState.Normal)
        switchIcon!.addTarget(self, action: "didTapSwitchIcon:", forControlEvents: UIControlEvents.TouchUpInside)
        self.window!.addSubview(switchIcon!)
        
        return true
    }

    func didTapSwitchIcon(sender: UIButton){
        
        let dampingStiffness:CGFloat = 16.0
        let dampingStiffnessOut:CGFloat = 24.0
        
        
        if viewShowing {
            
            // 隐藏 switchView 显示 appBackground view
            viewShowing = false
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.appBackground!.alpha = 1
                }, completion: nil)
            
            //JNW动画 放大appBackground 从0.99 到1
            let scale = JNWSpringAnimation(keyPath: "transform.scale")
            scale.damping = dampingStiffness
            scale.stiffness = dampingStiffness
            scale.mass = 1
            //scale.fromValue = self.appBackground?.layer.presentationLayer().valueForKeyPath(scale.keyPath)?.floatValue
            scale.fromValue = 0.99
            scale.toValue = 1
            self.appBackground?.layer.addAnimation(scale, forKey: scale.keyPath)
            //self.appBackground?.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9)
            self.appBackground?.transform = CGAffineTransformMakeScale(1, 1)
            
            
            // 隐藏 switchView view
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.switchView!.alpha = 0.0
                }, completion: nil)
            
            //JNW动画 缩小 switchView 从0.95 到0.9
            let switchViewscale = JNWSpringAnimation(keyPath: "transform.scale")
            switchViewscale.damping = dampingStiffness
            switchViewscale.stiffness = dampingStiffness
            switchViewscale.mass = 1
            switchViewscale.fromValue = 0.95
            switchViewscale.toValue = 0.5
            self.switchView?.layer.addAnimation(switchViewscale, forKey: switchViewscale.keyPath)
            //self.switchView?.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1)
            self.switchView?.transform = CGAffineTransformMakeScale(0.9, 0.9)

            
        }else{
            
            // 显示 switchView 隐藏 appBackground view
            viewShowing = true
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.appBackground!.alpha = 0.3
            }, completion: nil)
            
            //JNW动画 缩小appBackground 从1 到0.9
            let scale = JNWSpringAnimation(keyPath: "transform.scale")
            scale.damping = dampingStiffness
            scale.stiffness = dampingStiffness
            scale.mass = 1
            //scale.fromValue = self.appBackground?.layer.presentationLayer().valueForKeyPath(scale.keyPath)?.floatValue
            scale.fromValue = 1
            scale.toValue = 0.99
            self.appBackground?.layer.addAnimation(scale, forKey: scale.keyPath)
            //self.appBackground?.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9)
            self.appBackground?.transform = CGAffineTransformMakeScale(0.99, 0.99)

            // 显示 switchView view
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.switchView!.alpha = 1
                }, completion: nil)
            
            //JNW动画 放大 switchView 从0.9 到1
            let switchViewscale = JNWSpringAnimation(keyPath: "transform.scale")
            switchViewscale.damping = dampingStiffness
            switchViewscale.stiffness = dampingStiffness
            switchViewscale.mass = 1
            switchViewscale.fromValue = 0.5
            switchViewscale.toValue = 0.95
            self.switchView?.layer.addAnimation(switchViewscale, forKey: switchViewscale.keyPath)
            //self.switchView?.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1)
            self.switchView?.transform = CGAffineTransformMakeScale(0.95, 0.95)
            
        }
        
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


}

