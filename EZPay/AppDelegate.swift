//
//  AppDelegate.swift
//  EZPay
//
//  Created by Varoon Behramsha on 09/03/16.
//  Copyright © 2016 VaroonBehramsha. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        //Bluemix
        
       // IMFClient.sharedInstance().initializeWithBackendRoute("http://EZPay.au-syd.mybluemix.net", backendGUID: "d764182a-6cf3-4de3-a80c-86ba2e9e20e9")
        
        let notificationAction = UIMutableUserNotificationAction()
        notificationAction.title = "Enable"
        notificationAction.identifier = "ENABLE_IDENTIFIER"
        notificationAction.activationMode = UIUserNotificationActivationMode.Foreground
        notificationAction.destructive = false
        notificationAction.authenticationRequired = true
        
        let notificationCategory = UIMutableUserNotificationCategory()
        notificationCategory.identifier = "HANDSFREE_CATEGORY"
        notificationCategory.setActions([notificationAction], forContext: UIUserNotificationActionContext.Minimal)

        
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert,.Sound], categories: [notificationCategory])
        application.registerUserNotificationSettings(notificationSettings)
        application.registerForRemoteNotifications()
        
        
        
        
        //Parse Sign in...
        Parse.setApplicationId("T1WJ2eVk2GP22QabT4IBg4AUmW1cdf0ue7igXv95", clientKey: "QCqThsjBHwIwOw3ZZni0wNQTLmNzeFyljyF3WVlp")
        
       // UserManager.signIn()
        
        //self.testAPI()
        return true
    }

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData)
    {
        print(deviceToken)
        var token = NSString(string: "\(deviceToken)")
        let characterSet = NSCharacterSet(charactersInString: "<> ")
        token = token.stringByTrimmingCharactersInSet(characterSet).stringByReplacingOccurrencesOfString(" ", withString: "")
        print(token)
        //Parse
        let installation = PFInstallation.currentInstallation()
        installation.deviceToken = token as String
        installation.saveInBackground()
        //Bluemix
//        IMFClient.sharedInstance().initializeWithBackendRoute("http://EZPay.au-syd.mybluemix.net", backendGUID: "d764182a-6cf3-4de3-a80c-86ba2e9e20e9")
//        let push =  IMFPushClient.sharedInstance()
//        push.registerDeviceToken(deviceToken, completionHandler: { (response, error) ->  Void in if error !=  nil {
//            
//            print( "Error during device registration \(error.description) ")
//        }
//        else {
//            print( "Response during device registration json: \(response.responseJson.description) ")
//            }
//        })
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, withResponseInfo responseInfo: [NSObject : AnyObject], completionHandler: () -> Void)
    {
        if identifier == "ENABLE_IDENTIFIER"
        {
            //Enable handsfree payment
            //Send push notification to merchant device
            let query = PFInstallation.query()
            query?.whereKey("user", equalTo: MERCHANT!)
            
            let push = PFPush()
            push.setQuery(query)
            push.setData(["alert":"\(PFUser.currentUser()!["fullname"]!) has entered your store","userID":PFUser.currentUser()!.objectId!])
            //push.setMessage("\(PFUser.currentUser()!["fullname"]!) has entered your store")
            push.sendPushInBackground()
        }
        
    }
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool
    {
     print(options)
        return true
    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject])
    {
        print(userInfo)
        let userID = userInfo["userID"]!
        
        let notification = NSNotification(name: "CustomerEntered", object: self, userInfo: ["userID":userID])
        NSNotificationCenter.defaultCenter().postNotification(notification)
        //Get Users Profile
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


    
    func testAPI()
    {
        let request = SwiftRequest()
        //Sample url = http://alphaiciapi.mybluemix.net/rest/Wallet/createWallet/mer_123/create/Kavi/makode/km@gmail.com/7842133324/1989-07-12/male/10.22.7.74/android/12345/xyz/test@abc.com/f5316a5e35a4
        let api = "https://alphaiciapi.mybluemix.net/rest/Wallet/createWallet/mer_123/create/Kavi/makode/km@gmail.com/7842133324/1989-07-12/male/10.22.7.74/android/12345/xyz/varoonbehramsha@gmail.com/032597e56cb4"
        let clientID = "varoonbehramsha@gmail.com"
        let token = "032597e56cb4"
        
        request.get(api, auth:["":""] , params:["":""]/* ["client_id":clientID,"token":token,"merchant_id":"12345abcd","scope":"create","redirect_url":"EZPay://","mobile":"9966464212"]*/) { (err, response, body) -> () in
            if err == nil
            {
                
                print(response)
                
                let json = try! NSJSONSerialization.JSONObjectWithData(body as! NSData, options: NSJSONReadingOptions.AllowFragments)
                print(json)
                
            }else
            {
                
            }
        }
    }

    
}

