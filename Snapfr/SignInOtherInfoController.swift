//
//  SignInOtherInfoController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 26/8/15.
//  Copyright (c) 2015 Rommel Suarez. All rights reserved.
//

import UIKit

class SignInOtherInfoController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    var profileform = ProfileForm()
    let userService = UserService(newProfileDao: ProfileDao(), newUserDao: UserDao())
    
    
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var statusIndicator: UIActivityIndicatorView!
    @IBOutlet weak var photographerSwitch: UISwitch!
    @IBOutlet weak var customerSwitch: UISwitch!
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var importImageButton: UIButton!
    
    
    var name = String()
    var email =  String()
    var password = String()

    
    
    
    override func viewDidLoad() {
        self.statusIndicator.hidden = true
        self.locationText.text = profileform.location
        self.imagePicker.delegate = self
        print(profileform.avatar)
        
        
        if  profileform.avatar !=  nil{
            self.avatarImageView.imageFromUrl(profileform.avatar)
        }
        
        
        
        
    }
    
    @IBAction func importImageButtonOnClick(sender: AnyObject) {
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

    
    @IBAction func doneButtonOnClick(sender: AnyObject) {
        
       
        profileform.location = locationText.text!

        
        if customerSwitch.on {
             profileform.isCustomer = true
        }else {
             profileform.isCustomer = false
        }
        
        
        if photographerSwitch.on {
            profileform.isPhotographer = true
        }else {
            profileform.isPhotographer = false
        }
        
       
        let profile = Profile()
        let user = User()
        
        profile.name = profileform.name
        profile.isCustomer = profileform.isCustomer
        profile.isPhotographer = profileform.isPhotographer
        profile.location = profileform.location
        
        user.email = profileform.email
        user.password = profileform.password
        
        profile.user = user
        
        let imgData : NSData = UIImagePNGRepresentation(avatarImageView.image!)!
        
        userService.signIn(profile, image: imgData) { (data, responseMessage) -> () in
            
      
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    CommonUtil.processErrorUIResponseMsg("Sign-in", responseMessage: responseMessage)
                    
                    if responseMessage.code == ResponseStatus.Success {
                        if data != nil {
                            self.statusIndicator.hidden  = false
                            self.statusIndicator.startAnimating()
                            
                            
                            self.statusIndicator.stopAnimating()
                            self.statusIndicator.hidden = true
                            
                            let alertView = UIAlertController(title: "Successful", message: "Sign-in successfully completed", preferredStyle: UIAlertControllerStyle.Alert)
                            alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                                
                                Constants.UserEmail = self.profileform.email
                                Constants.ProfileID = data.id
                                let controller = self.storyboard!.instantiateViewControllerWithIdentifier("RevealViewController") as! SWRevealViewController
                                self.navigationController!.presentViewController(controller, animated: true, completion: { () -> Void in
                                    
                                })

                            }));
                            
                            self.presentViewController(alertView, animated: true, completion: nil)

                            
                            
                            
                        }
                    }
                    
                }

                
                
           
            
        }
        
        
        
        

    }
    
}

