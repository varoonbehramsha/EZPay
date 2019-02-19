//
//  HomeVC.swift
//  EZPay
//
//  Created by Varoon Behramsha on 12/03/16.
//  Copyright © 2016 VaroonBehramsha. All rights reserved.
//

import UIKit
import CoreLocation
import Parse

var MERCHANT:PFUser?

class HomeVC: UIViewController,CLLocationManagerDelegate
{

    var locationManager : CLLocationManager!
    var beacons : [[String:String]] = []
    var firstSighting = true
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        UserManager.signIn()

        
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.startBeaconMonitoring()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Helper Mehtods
    
    //Setup Beacon Monitoring
    
    
    func startBeaconMonitoring()
    {
        let uuid = NSUUID(UUIDString: "F62E20B4-2065-4D52-86C8-09A80F5E3744")
        let beaconRegion = CLBeaconRegion(proximityUUID:uuid!, identifier: "EZPay")
        //let beaconRegion = CLBeaconRegion(proximityUUID: uuid!, major: 12346, minor: 54321, identifier: "EZPay")
        
        self.locationManager.pausesLocationUpdatesAutomatically = false
        self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers //To get continued background ranging
        self.locationManager.startMonitoringForRegion(beaconRegion)
        //self.locationManager.startRangingBeaconsInRegion(beaconRegion)

    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion)
    {
        if beacons.count != 0
        {
            print(beacons)
            let beacon = beacons.first!
            if firstSighting
            {
                firstSighting = false
                EZPayManager.getMerhcantHavingMajor(beacon.major.integerValue, minor: beacon.minor.integerValue, completionHandler: { (success, merchant) -> () in
                    if success
                    {
                        MERCHANT = merchant
                        
                            //Show notification...
                            self.showNotification(merchant!["merchantName"] as! String, message: "Welcome to \(merchant!["merchantName"] as! String). Enable Handsfree Payments for speedy checkout.")
                        
                    }
                })

            }
           // self.outputLabel.text = self.outputLabel.text! + "\n Beacon:Major:\(beacons.first!.major):Minor:\(beacons.first!.minor)"
            
        }
        self.locationManager.stopRangingBeaconsInRegion(region)
    }
    
    func showNotification(merchantName:String,message:String)
    {
        let notification = UILocalNotification()
        notification.alertTitle = "Welcome to \(merchantName)"
        notification.alertBody = message
        notification.soundName = "default"
        //notification.alertAction = "Enable"
        notification.category = "HANDSFREE_CATEGORY"
        let application = UIApplication.sharedApplication()
        application.presentLocalNotificationNow(notification)
        
    }
    
    func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion)
    {
        print("Beacon Monitoring started")
        //self.outputLabel.text = self.outputLabel.text! + "\n Monitoring Started"

    }
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion)
    {
        print("Entered Region")
        let beaconRegion = region as! CLBeaconRegion
        self.locationManager.startRangingBeaconsInRegion(region as! CLBeaconRegion)

        //self.outputLabel.text = self.outputLabel.text! +  "\n Entered Region:Major:\(beaconRegion.major):Minor:\(beaconRegion.minor)"
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion)
    {
        print("Exited Region")
        //self.outputLabel.text = self.outputLabel.text! + "\n Exited Region"
        
    }
}



