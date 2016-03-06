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

    @IBOutlet private weak var txtUsername: UITextField!
    @IBOutlet private weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtUsername.layer.borderWidth = 1
        txtPassword.layer.borderWidth = 1
        
        let borderColor: UIColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        txtUsername.layer.borderColor = borderColor.CGColor
        txtPassword.layer.borderColor = borderColor.CGColor
        
       btnLogin.backgroundColor = UIColor.clearColor()
        btnLogin.layer.cornerRadius = 5
        btnLogin.layer.borderWidth = 1
        btnLogin.layer.borderColor = UIColor.whiteColor().CGColor
        
        btnSignUp.backgroundColor = UIColor.clearColor()
        btnSignUp.layer.cornerRadius = 5
        btnSignUp.layer.borderWidth = 1
        btnSignUp.layer.borderColor = UIColor.whiteColor().CGColor
        
       
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        txtPassword.text = ""
        txtUsername.text = ""
    }
    

    
    @IBAction func btnSignIn(sender: AnyObject) {
        
             
        PFUser.logInWithUsernameInBackground(txtUsername.text!, password: txtPassword.text!) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil
            {
    
                print("You are logged in!")
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: UIViewController = storyboard.instantiateViewControllerWithIdentifier("HomeNavigation") as! UINavigationController
                
                self.presentViewController(vc, animated: true, completion: nil )
                
            }
            else if error!.code == 101 {
            
                let alert = UIAlertController (title: "Error", message: "A username or password is incorrect!", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
                
                
            }
            
        }
        
    }
    
    func uiColorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
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
