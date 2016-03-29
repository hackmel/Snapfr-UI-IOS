//
//  ImageLoaderController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 6/9/15.
//  Copyright (c) 2015 Rommel Suarez. All rights reserved.
//

import UIKit


class ProfileMaintenanceController: UITableViewController{

    
    
   
    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var openMenu: UIBarButtonItem!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var locationText: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var editPhotoButton: UIButton!
    
    var profileData = Profile()
    
    
    override func viewDidLoad() {
        
        let userService = UserService(newProfileDao: ProfileDao(),newUserDao: UserDao())
        
        
        userService.getProfileByEmail(Constants.UserEmail, completion: { (data, responseMessage) -> () in
            
            dispatch_async(dispatch_get_main_queue()) {
                
               CommonUtil.processErrorUIResponseMsg("Profile Maintenance",responseMessage: responseMessage);
                
                if responseMessage.code == ResponseStatus.Success  {
                    if data != nil {
                        self.locationText.text = data.location
                        self.nameText.text = data.name
                        self.emailText.text = Constants.UserEmail
                        self.avatarImageView.imageFromUrl(data.avatar)
                        self.profileData = data

                    }
                
                }
                
             }

            
        })
        
        
        
        super.viewDidLoad()
        
        openMenu.target=self.revealViewController()
        openMenu.action=Selector("revealToggle:")

        
    }
    
    
    @IBAction func editAvatarButtonOnClick(sender: AnyObject) {
        performSegueWithIdentifier("editAvatarSegue", sender: self)
    
    }
    
    
    @IBAction func editProfileButtonOnClick(sender: AnyObject) {
        performSegueWithIdentifier("editProfileSegue", sender: self)
        
    }
    
    
    @IBAction func unwindSegueReloadProfileMaintenance(segue: UIStoryboardSegue) {
       
        
        let userService = UserService(newProfileDao: ProfileDao(),newUserDao: UserDao())
        
        
        userService.getProfileByEmail(Constants.UserEmail, completion: { (data, responseMessage) -> () in
            
            dispatch_async(dispatch_get_main_queue()) {
                CommonUtil.processErrorUIResponseMsg("Profile Maintenance",responseMessage: responseMessage);
                if responseMessage.code == ResponseStatus.Success  {
                    
                    if(data != nil) {
                        self.locationText.text = data.location
                        self.nameText.text = data.name
                        self.emailText.text = Constants.UserEmail
                        self.avatarImageView.imageFromUrl(data.avatar)
                        
                        self.profileData = data
                        
                    }
               }
            }
            
            
        })

    }
 
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "editAvatarSegue" {
            let editAvatar = segue.destinationViewController as! EditAvatar
            
            editAvatar.profileForm.avatar = self.profileData.avatar

            
        }else if segue.identifier == "editProfileSegue"  {
            let editProfileController = segue.destinationViewController as! EditProfileController
            
            editProfileController.profileForm.location = self.profileData.location
            editProfileController.profileForm.name = self.profileData.name
            
        }
        
    }
}

