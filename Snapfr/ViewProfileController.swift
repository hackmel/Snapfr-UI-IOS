//
//  ViewUserProfileController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 18/10/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class ViewProfileController: UITableViewController {
    
    var profile = Profile()
    
    @IBOutlet weak var locationText: UILabel!
    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func viewDidLoad() {
        nameText.text = profile.name
        emailText.text = profile.user.email
        locationText.text = profile.location
        avatarImageView.imageFromUrl(profile.avatar)
    }
    
    
    
    
    @IBAction func viewReviewsOnClick(sender: AnyObject) {
        performSegueWithIdentifier("viewReviews", sender: nil)
        
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "viewReviews" {
            
            
            let viewReviewsController = segue.destinationViewController as! ViewReviewsController
            viewReviewsController.profile = profile
        }else if segue.identifier == "sendMessageSegue" {
            let sendMessageController = segue.destinationViewController as! SendMessageController
            sendMessageController.profile = profile
        }
    }
    
    
    @IBAction func sendMessageOnClick(sender: AnyObject) {
        
        performSegueWithIdentifier("sendMessageSegue", sender: nil)
    }
}
