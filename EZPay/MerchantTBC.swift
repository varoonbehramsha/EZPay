//
//  MerchantTBC.swift
//  EZPay
//
//  Created by Varoon Behramsha on 12/03/16.
//  Copyright © 2016 VaroonBehramsha. All rights reserved.
//

import UIKit
import CoreBluetooth
import Parse

class MerchantTBC: UITabBarController,CBPeripheralManagerDelegate
{
    var peripheralManager:CBPeripheralManager?

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.peripheralManager = CBPeripheralManager(delegate: self, queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), options: ["Merchant":"Apple Store"])
        
        UserManager.merchantSignIn()
        let installation = PFInstallation.currentInstallation()
        installation["user"] = PFUser.currentUser()
       try! installation.save()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func startBeaconTransmission()
    {
        let uuid = NSUUID(UUIDString: "F62E20B4-2065-4D52-86C8-09A80F5E3744")
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid!, major:1 , minor: 1, identifier: "EZPay")
        //let beaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: "EZPay")
        
        let beaconPeripheralData = beaconRegion.peripheralDataWithMeasuredPower(nil).copy() as! NSDictionary
        self.peripheralManager!.startAdvertising(beaconPeripheralData as! [String : AnyObject])
    }
    
    
    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager, error: NSError?)
    {
        print("Started Advertising")
    }
    
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager)
    {
        print("Status updated")
        self.startBeaconTransmission()
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
