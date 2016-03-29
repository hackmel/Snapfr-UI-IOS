//
//  SignInController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 26/8/15.
//  Copyright (c) 2015 Rommel Suarez. All rights reserved.
//

import UIKit

import FBSDKLoginKit

class SignInController: UITableViewController {
    
    let userService = UserService(newProfileDao: ProfileDao(),newUserDao: UserDao())
    var profileform = ProfileForm()
 
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var verifyPassword: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    
    
    override func viewDidLoad() {
      
        
        
    }
    
   
    @IBAction func signInOnClick(sender: AnyObject) {
        
        let user = User()
        user.email = self.emailAddress.text
        
        
        if self.password.text != self.verifyPassword.text {
            let alertView = UIAlertView(title: "Sign-in failed", message: "Password verification failed. Please try again.", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
        }else{
            self.userService.isUserExist(user, completion: { (data, responseMessage) -> () in
                        dispatch_async(dispatch_get_main_queue()) {
                            
                            CommonUtil.processErrorUIResponseMsg("Login", responseMessage: responseMessage)
                            if responseMessage.code == ResponseStatus.Success {
                                if data != nil {
                                    let alertView = UIAlertView(title: "Sign-in failed", message: "Account already exist. Please use another email account", delegate: self, cancelButtonTitle: "OK")
                                    alertView.show()
                                }
                            }else{
                                self.performSegueWithIdentifier("manualSignIn", sender: self)
                            }
                            
                           
                            
                        }
             
            })

        }
        
        
        
        
    }
    
    
    @IBAction func facebookButtonOnclick(sender: AnyObject) {
        
     
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager .logInWithReadPermissions(["email","user_location"], handler: { (result, error) -> Void in
    
          
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                   
                  
                        self.userService.getFBUserData({ (data, error) -> () in
                            self.profileform.location = data.location
                            self.profileform.name = data.name
                            self.profileform.email = data.user.email
                            self.profileform.isFaceBookAccount = true
                            self.profileform.avatar = data.avatar
                            Constants.UserFBPhoto = data.avatar
                           
                            
                            
                            let user = User()
                            user.email = data.user.email
                            
                            self.userService.isUserExist(user, completion: { (data, responseMessage) -> () in
                                
                                dispatch_async(dispatch_get_main_queue()) {
                                    
                                    CommonUtil.processErrorUIResponseMsg("Facebook Login", responseMessage: responseMessage)
                                    
                                    if responseMessage.code == ResponseStatus.Success {
                                        if data != nil {
                                            let alertView = UIAlertView(title: "Sign-in failed", message: "Account already exist. Please use another email account", delegate: self, cancelButtonTitle: "OK")
                                            alertView.show()
                                        }
                                    }else{
                                         self.performSegueWithIdentifier("facebookSignIn", sender: self)
                                    }
                                    
                                    
                                    
                                }
                            })
                            
                        })
                    
                }
 
                
            }
               
          
     
        })
         
  
    }
    
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if (segue.identifier == "manualSignIn") {
       
        let signinOtherInfoVC = segue.destinationViewController as! SignInOtherInfoController
        signinOtherInfoVC.profileform.name = userName.text!
        signinOtherInfoVC.profileform.email = emailAddress.text!
        signinOtherInfoVC.profileform.password = password.text!
     
        
        
    }
    
    
    if (segue.identifier == "facebookSignIn") {
     
        let signinOtherInfoVC = segue.destinationViewController as! SignInOtherInfoController
        signinOtherInfoVC.profileform.name = self.profileform.name
        signinOtherInfoVC.profileform.email = self.profileform.email
        signinOtherInfoVC.profileform.location = self.profileform.location
        signinOtherInfoVC.profileform.isFaceBookAccount = self.profileform.isFaceBookAccount
        signinOtherInfoVC.profileform.avatar = self.profileform.avatar
    }


    
    }
}
