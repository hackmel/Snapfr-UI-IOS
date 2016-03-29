//
//  EditProfileController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 12/9/15.
//  Copyright (c) 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class EditProfileController : UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    

    
   let userService = UserService(newProfileDao: ProfileDao(),newUserDao: UserDao())
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var profileForm = ProfileForm()
    
    
   override func viewDidLoad() {
      super.viewDidLoad()
    
      nameText.text = profileForm.name
      locationText.text = profileForm.location
    
    }
    
    @IBAction func doneButtonOnClick(sender: AnyObject) {
        
        var profile = Profile()
        let user = User()
        
       
        let trimmedName = self.nameText.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let trimmedLocation = self.locationText.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if(trimmedLocation.isEmpty || trimmedName.isEmpty ) {
            let alertView = UIAlertView(title: "Validation", message: "Name or Location can't contain blank", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
            
            return
            
        }
        
        let refreshAlert = UIAlertController(title: "Update Profile", message: "Are you sure to continue? ", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
            
            self.userService.getProfileByEmail(Constants.UserEmail, completion: { (data, responseMessage) -> () in
                   dispatch_async(dispatch_get_main_queue()) {
                    
                     CommonUtil.processErrorUIResponseMsg("Profile Maintenance",responseMessage: responseMessage);
                    
                       if responseMessage.code == ResponseStatus.Success{
                        
                        profile = data
                        profile.name = self.nameText.text
                        profile.location = self.locationText.text
                        user.email = Constants.UserEmail
                        profile.user = user

                        
                        
                            self.userService.updateUserProfile(profile, image: nil) { (data, responseMessage) -> () in
                            
                                dispatch_async(dispatch_get_main_queue()) {
                                
                                CommonUtil.processErrorUIResponseMsg("Profile Maintenance",responseMessage: responseMessage);
                                
                                    if responseMessage.code == ResponseStatus.Success {
                                    
                                        let alertView = UIAlertView(title: "Successful", message: "Profile update successful", delegate: nil, cancelButtonTitle: "OK")
                                    
                                        alertView.show()
                                    
                                    
                                        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("ProfileMaintenanceController") as! UITableViewController
                                        self.navigationController!.pushViewController(controller, animated: true)
                                    
                                    
                                    }
                                
                                
                                }
                            }

                        
                        }
                    
                    }
                
            })
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
           refreshAlert .dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(refreshAlert, animated: true, completion: nil)
        
    }
        

}
