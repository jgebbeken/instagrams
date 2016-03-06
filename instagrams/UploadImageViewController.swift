//
//  UploadImageViewController.swift
//  instagrams
//
//  Created by Josh Gebbeken on 3/5/16.
//  Copyright © 2016 josh.gebbeken. All rights reserved.
//

import UIKit
import Parse

class UploadImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageToUpload: UIImageView!
    @IBOutlet weak var txtCaption: UITextField!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnTakePhoto: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        txtCaption.layer.borderWidth = 1
        let borderColor: UIColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        txtCaption.layer.borderColor = borderColor.CGColor
        
        btnCamera.backgroundColor = UIColor.clearColor()
        btnCamera.layer.cornerRadius = 5
        btnCamera.layer.borderWidth = 1
        btnCamera.layer.borderColor = UIColor.whiteColor().CGColor
      
        btnTakePhoto.backgroundColor = UIColor.clearColor()
        btnTakePhoto.layer.cornerRadius = 5
        btnTakePhoto.layer.borderWidth = 1
        btnTakePhoto.layer.borderColor = UIColor.whiteColor().CGColor

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    
    
    @IBAction func onUpload(sender: AnyObject) {
        
        let resizedImage = CGSize(width: 368, height: 252)
        
        imageToUpload.image = resize(imageToUpload.image!, newSize: resizedImage)
        
        
        Post.postUserImage(imageToUpload.image, withCaption: txtCaption.text, withCompletion: nil)
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        //get image captured by the UIImagePickerController
        
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        imageToUpload.image = originalImage
        
        print(originalImage)
        print("You chose a picture!")
        
        //Do something with the iamges here (based on your use case!!!)
        
        //Dismiss UIImagePickerController when finished; go back to original view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func onCameraRoll(sender: AnyObject) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    
    }
    
    
    @IBAction func onTakePhoto(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(vc, animated: true, completion: nil)
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
