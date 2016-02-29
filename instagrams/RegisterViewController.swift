//
//  RegisterViewController.swift
//  instagrams
//
//  Created by Josh Gebbeken on 2/28/16.
//  Copyright © 2016 josh.gebbeken. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func registerUser(sender: AnyObject) {
        
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = txtUsername.text
        newUser.email = txtEmail.text
        newUser.password = txtPassword.text
        
        // call sign up function on the object
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription)
                
                if error.code == 202 {
                    let alertControllerUser = UIAlertController(title: "Error", message: "Username already taken!", preferredStyle: UIAlertControllerStyle.Alert)
                    alertControllerUser.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                }
                else if error.code == 203 {
                    let alertControllerEmail = UIAlertController(title: "Error", message: "Email already taken!", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    alertControllerEmail.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                }
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
    }
    
    
    @IBAction func cancel(sender: AnyObject) {
        
        //let login = self.storyboard?.instantiateViewControllerWithIdentifier("navLogin") as? LoginViewController
        //self.navigationController?.pushViewController(login!, animated: true)
        
        self.dismissViewControllerAnimated(true, completion: nil)
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
