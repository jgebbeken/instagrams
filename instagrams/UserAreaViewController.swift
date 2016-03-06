//
//  UserAreaViewController.swift
//  instagrams
//
//  Created by Josh Gebbeken on 3/4/16.
//  Copyright © 2016 josh.gebbeken. All rights reserved.
//

import UIKit
import Parse

class UserAreaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var imageCaptionsData: [PFObject]!
    
    var mainStoryboard = UIStoryboard(name: "Main", bundle: nil )

    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBarHidden = false
        
        let username = PFUser.currentUser()?["username"] as? String
        
        let button =  UIButton(type: .Custom)
        button.frame = CGRectMake(0, 0, 100, 40) as CGRect
        button.backgroundColor = UIColor.clearColor()
        button.setTitle(username, forState: UIControlState.Normal)
        button.addTarget(self, action: Selector("clickOnButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.titleView = button
        
        
        self.navigationItem.title = username
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = UIColor.clearColor()
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.whiteColor()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        
        let dataQuery = PFQuery(className: "Post")
        dataQuery.orderByAscending("createdAt")
        dataQuery.includeKey("author")
        dataQuery.limit = 20
        
        
        dataQuery.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            
                       
            
            if let posts = posts {
                print(posts)
                self.imageCaptionsData = posts
                print(self.imageCaptionsData)
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
        
    }
    
    func clickOnButton(button: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewControllerWithIdentifier("profileNav") as! UINavigationController
        
        self.presentViewController(vc, animated: true, completion: nil )
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if imageCaptionsData != nil {
            return imageCaptionsData.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("imageCell", forIndexPath: indexPath) as! ImageCellTableViewCell
        
        cell.userArea = imageCaptionsData[indexPath.row]
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // onRefresh Methods
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        
        delay(4, closure: {
            
            let query = PFQuery(className: "Post")
            query.orderByDescending("createdAt")
            query.includeKey("author")
            query.limit = 20
            
            
            //fetch data asynchronously
            query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
                if let posts = posts {
                    //print(posts)
                    self.imageCaptionsData = posts
                    //print(self.postsArray)
                    self.tableView.reloadData()
                } else {
                    print(error?.localizedDescription)
                }
            }
            
            self.refreshControl.endRefreshing()
        })
    }
    
    
    @IBAction func onLogOut(sender: AnyObject) {
        
        //Logout the user
        PFUser.logOut()
        
        let vc: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Login") as UIViewController
        
       self.presentViewController(vc, animated: true, completion: nil )
        
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
