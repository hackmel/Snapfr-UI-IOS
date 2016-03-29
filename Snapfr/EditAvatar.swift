//
//  EditAvatar.swift
//  Snapfr
//
//  Created by Rommel Suarez on 16/9/15.
//  Copyright (c) 2015 Rommel Suarez. All rights reserved.
//

import Foundation

import UIKit


class EditAvatar: UITableViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    let userService = UserService(newProfileDao: ProfileDao(),newUserDao: UserDao())
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var synchFBPhotoButton: UIButton!
    
    @IBOutlet weak var chooseFromLibraryButton: UIButton!
     let imagePicker = UIImagePickerController()
    
    var profileForm = ProfileForm()
    
    
    override func viewDidLoad() {
        self.imagePicker.delegate = self
        
        if Constants.UserFBPhoto.isEmpty  {
            self.synchFBPhotoButton.hidden = true
        }
        
        self.avatarImageView.imageFromUrl(profileForm.avatar)
    }
    
    
    @IBAction func doneButtonOnClick(sender: AnyObject) {
        
        var profile = Profile()
        let user = User()
        user.email = Constants.UserEmail
        
        
        
        let refreshAlert = UIAlertController(title: "Update Avatar", message: "Are You Sure to update ? ", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Confirm", style: .Default, handler: { (action: UIAlertAction!) in
            
            self.userService.getProfileByEmail(Constants.UserEmail, completion: { (data, responseMessage) -> () in
               
                dispatch_async(dispatch_get_main_queue()) {
                    
                    CommonUtil.processErrorUIResponseMsg("Profile update",responseMessage: responseMessage);
                
                   
                    if responseMessage.code == ResponseStatus.Success {
                        
                        if (data != nil ) {
                            profile = data
                            profile.user = user
                            let imgData : NSData = UIImagePNGRepresentation(self.avatarImageView.image!)!
                            
                            self.userService.updateUserProfile(profile, image: imgData) { (data, response) -> () in
                                
                                 dispatch_async(dispatch_get_main_queue()) {
                                    
                                    CommonUtil.processErrorUIResponseMsg("Profile update",responseMessage: responseMessage);
                                    
                                    if response.code == ResponseStatus.Success {
                                        let alertView = UIAlertController(title: "Successful", message: "Avatar successfully updated", preferredStyle: UIAlertControllerStyle.Alert)
                                        alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                                              self.performSegueWithIdentifier("unwindSegueReloadProfileMaintenance", sender: nil)
                                           
                                        }));
                                        
                                        
                                        self.presentViewController(alertView, animated: true, completion: nil)
                                        
                                    }
                                    
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
    
    
    @IBAction func synchFBButtonOnClick(sender: AnyObject) {
        self.avatarImageView.imageFromUrl(Constants.UserFBPhoto)
        
    }
   
    
    @IBAction func chooseFromLibraryButtonOnClick(sender: AnyObject) {
        self.imagePicker.allowsEditing = false
        self.imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)

        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            avatarImageView.contentMode = .ScaleAspectFit
            avatarImageView.image = pickedImage
         
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    
}
