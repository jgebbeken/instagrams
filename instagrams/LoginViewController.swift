//
//  LoginViewController.swift
//  instagrams
//
//  Created by Josh Gebbeken on 2/28/16.
//  Copyright © 2016 josh.gebbeken. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnSignIn(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(txtUsername.text!, password: txtPassword.text!) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil
            {
                print("You are logged in!")
                let loggedSuccessfulViewController = self.storyboard?.instantiateViewControllerWithIdentifier("passLogin") as? ViewController
                self.navigationController?.pushViewController(loggedSuccessfulViewController!, animated: true)
                
            }
            else if error!.code == 101 {
                
                let alertControllerUserPassword = UIAlertController(title: "Error", message: "Username/Password is Invalid", preferredStyle: UIAlertControllerStyle.Alert)
                
                alertControllerUserPassword.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                
            }
            
        }
        
    }
    

    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
