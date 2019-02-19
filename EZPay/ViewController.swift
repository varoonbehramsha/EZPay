//
//  ViewController.swift
//  EZPay
//
//  Created by Varoon Behramsha on 09/03/16.
//  Copyright © 2016 VaroonBehramsha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let request = SwiftRequest()
        let api = "https://corporate_bank.mybluemix.net/corporate_banking/mybank/authenticate_client"
        let clientID = "varoonbehramsha@gmail.com"
        let password = "ICIC3375"
        
//        request.get(api, auth: ["client_id":clientID,"password":password], params: ["client_id":clientID,"password":password]) { (err, response, body) -> () in
//            if err == nil
//            {
//            
//                print(response)
//
//                let json = try! NSJSONSerialization.JSONObjectWithData(body as! NSData, options: NSJSONReadingOptions.AllowFragments)
//                print(json)
//            }
//        }
        let token = "032597e56cb4"
//        let api2 = "https://retailbanking.mybluemix.net/banking/icicibank/BranchAtmLocator"
//        request.get(api2, auth:["":""] , params: ["client_id":clientID,"token":token,"locate":"ATM","lat":"72.9376984","long":"19.1445007"]) { (err, response, body) -> () in
//            if err == nil
//            {
//                
//                print(response)
//                
//                let json = try! NSJSONSerialization.JSONObjectWithData(body as! NSData, options: NSJSONReadingOptions.AllowFragments)
//                print(json)
//                
//            }else
//            {
//                
//            }
//        }
//        let api3 = "http://alphaiciapi.mybluemix.net/rest/Wallet/createWallet"/*/mer_123/create/Varoon/Behramsha/varoonbehramsha@gmail.com/9686416921/1989-07-12/male/10.22.7.74/ios/12345/xyz"*/
//        request.get(api3, auth:["":""] , params: ["client_id":clientID,"token":token,"merchant_id":"12345abcd","scope":"create","redirect_url":"www.varoonbehramsha.com"]) { (err, response, body) -> () in
//            if err == nil
//            {
//                
//                print(response)
//                print(body)
//                let json = try! NSJSONSerialization.JSONObjectWithData(body as! NSData, options: NSJSONReadingOptions.AllowFragments)
//                print(json)
//                
//            }else
//            {
//                
//            }
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

