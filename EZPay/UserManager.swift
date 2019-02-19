//
//  UserManager.swift
//  EZPay
//
//  Created by Varoon Behramsha on 11/03/16.
//  Copyright © 2016 VaroonBehramsha. All rights reserved.
//

import Foundation
import Parse

class UserManager
{
    
    class func signIn()
    {
        try! PFUser.logInWithUsername("varoonbehramsha@gmail.com", password: "12345")
        
        print(PFUser.currentUser()?.email)
        
    }
    
    class func merchantSignIn()
    {
        try! PFUser.logInWithUsername("sam@shoppersstop.com", password: "12345")
    }
}