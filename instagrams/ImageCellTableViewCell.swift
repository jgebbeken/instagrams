//
//  ImageCellTableViewCell.swift
//  instagrams
//
//  Created by Josh Gebbeken on 3/5/16.
//  Copyright © 2016 josh.gebbeken. All rights reserved.
//

import UIKit
import Parse

class ImageCellTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet private weak var uploadedImage: UIImageView!
    @IBOutlet private weak var caption: UILabel!
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    var userArea: PFObject! {
        
        didSet {
            caption.text = userArea.objectForKey("caption") as? String
            lblAuthorName.text = PFUser.currentUser()?["username"] as? String
            let userImageData = userArea.objectForKey("media") as? PFFile
            userImageData!.getDataInBackgroundWithBlock( {(imageInfo: NSData?, error: NSError?) -> Void in
            
                if(error == nil)
                {
                    let userImage = UIImage(data: imageInfo!)
                    self.uploadedImage.image = userImage
                }
            
            })
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
