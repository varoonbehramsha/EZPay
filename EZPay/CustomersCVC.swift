//
//  CustomersCVC.swift
//  EZPay
//
//  Created by Varoon Behramsha on 13/03/16.
//  Copyright © 2016 VaroonBehramsha. All rights reserved.
//

import UIKit
import Parse


class CustomersCVC: UICollectionViewController
{
    var customers:[PFUser] = []
        {
            didSet
            {
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    self.collectionView?.reloadData()
                }
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false


        // Do any additional setup after loading the view.
        EZPayManager.getUserProfileForUserHavingID("MCwHSFb5W6") { (success, user) -> () in
            if success
            {
                self.customers.append(user)
            }
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "fetchCustomerProfile:", name: "CustomerEntered", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func fetchCustomerProfile(notification:NSNotification)
    {
        let userID = notification.userInfo!["userID"] as! String
        
        EZPayManager.getUserProfileForUserHavingID(userID) { (success, user) -> () in
            if success
            {
                self.customers.append(user)
            }
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
    
        if segue.identifier == "ConfirmPaymentSegue"
        {

            let confirmPaymentVC = segue.destinationViewController as! ConfirmPaymentVC
            let customer = self.customers[sender!.tag]

            confirmPaymentVC.customer = customer
        }
    }


    // MARK: UICollectionViewDataSource

    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.customers.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomerCell", forIndexPath: indexPath) as! CustomerCell
        let customer = self.customers[indexPath.row]
        
        cell.nameLabel.text = customer["fullname"] as? String
        cell.makePaymentButton.tag = indexPath.row
        let profilePicFile = customer["profilePicture"] as! PFFile
        profilePicFile.getDataInBackgroundWithBlock { (data, error) -> Void in
            if error == nil
            {
                let image = UIImage(data: data!)!
                cell.imageView.image = image
            }
        }
    
        // Configure the cell
        cell.imageView.layer.masksToBounds = true
        cell.imageView.layer.cornerRadius = 55
        cell.makePaymentButton.layer.cornerRadius = 6
        cell.layer.cornerRadius = 6.0
        cell.layer.borderColor = cell.makePaymentButton.backgroundColor?.CGColor
        cell.layer.borderWidth = 1.0
//        cell.imageView.layer.borderWidth = 1
//        cell.imageView.layer.borderColor = UIColor.blackColor().CGColor

        return cell
    }

    
    @IBAction func makePaymentButton(sender: AnyObject)
    {
        let customer = self.customers[sender.tag]
        
        let confirmPaymentVC = self.storyboard?.instantiateViewControllerWithIdentifier("ConfirmPaymentVC") as! ConfirmPaymentVC
        let cell = self.collectionView?.cellForItemAtIndexPath(NSIndexPath(forItem: sender.tag, inSection: 0)) as! CustomerCell
        confirmPaymentVC.image = cell.imageView.image
        confirmPaymentVC.customer = customer
        confirmPaymentVC.modalPresentationStyle = UIModalPresentationStyle.Popover
        confirmPaymentVC.popoverPresentationController?.sourceView = sender as? UIView
        confirmPaymentVC.popoverPresentationController?.sourceRect = sender.bounds
        confirmPaymentVC.preferredContentSize = CGSizeMake(250, 250)
        self.presentViewController(confirmPaymentVC, animated: true, completion: nil)
        
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
