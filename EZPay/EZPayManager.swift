//
//  EZPayManager.swift
//  EZPay
//
//  Created by Varoon Behramsha on 12/03/16.
//  Copyright © 2016 VaroonBehramsha. All rights reserved.
//

import Foundation
import Parse

class EZPayManager
{
    class func getMerhcantHavingMajor(major:Int,minor:Int,completionHandler:(success:Bool,merchant:PFUser?)->())
    {
        let query = PFUser.query()
        query?.whereKey("major", equalTo: major)
        query?.whereKey("minor", equalTo: minor)
        
        query?.findObjectsInBackgroundWithBlock({ (merchants, error) -> Void in
            if error == nil
            {
                if merchants?.count != 0
                {
                    completionHandler(success: true,merchant: merchants!.first as? PFUser)

                }
            }
        })
    }
    
    class func getUserProfileForUserHavingID(userID:String,completionHandler:(success:Bool,user:PFUser)->())
    {
        let query = PFUser.query()
        query?.whereKey("objectId", equalTo: userID)
        
        query?.findObjectsInBackgroundWithBlock({ (users, error) -> Void in
            if error == nil
            {
                if users?.count != 0
                {
                    completionHandler(success: true, user: users!.first! as! PFUser)
                }
            }
        })
        
    }
    
    class func confirmPaymentForCustomer(customer:PFUser,amount:String,pin:String,completionHandler:(success:Bool,errorMessage:String)->())
    {
        //Verify pin
        //Debit customers wallet
        //Credit Merchants bank account
        
        let query = PFInstallation.query()
        query?.whereKey("user", equalTo:customer)
        
        let push = PFPush()
        push.setMessage("\(PFUser.currentUser()!["merchantName"]!) debited Rs \(amount) from your wallet")
        push.setQuery(query)
        push.sendPushInBackgroundWithBlock { (success, error) -> Void in
            if success
            {
                completionHandler(success: true, errorMessage: "Payment Successful")
            }
        }
    }
}