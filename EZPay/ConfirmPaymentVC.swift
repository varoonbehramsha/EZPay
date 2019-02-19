//
//  ConfirmPaymentVC.swift
//  EZPay
//
//  Created by Varoon Behramsha on 13/03/16.
//  Copyright © 2016 VaroonBehramsha. All rights reserved.
//

import UIKit
import Parse

class ConfirmPaymentVC: UIViewController,UITextFieldDelegate
{
    var customer:PFUser!
    var image:UIImage!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
   
    @IBOutlet weak var confirmPaymentButton: UIButton!
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var pinTextField: UITextField!
    override func viewDidLoad()
    {
        super.viewDidLoad()

//        self.imageView.image = image
//        self.nameLabel.text = self.customer["fullname"] as! String
        self.amountTextField.delegate = self
        self.pinTextField.delegate = self
        self.confirmPaymentButton.layer.cornerRadius = 6
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool)
    {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmPaymentButtonAction(sender: AnyObject)
    {
        EZPayManager.confirmPaymentForCustomer(self.customer, amount: self.amountTextField.text!, pin: self.pinTextField.text!) { (success, errorMessage) -> () in
            if success
            {
                
            }
        }
    }

        
    @IBAction func cancelButtonAction(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        return textField.resignFirstResponder()
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
