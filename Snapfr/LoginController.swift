//
//  LoginController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 22/8/15.
//  Copyright (c) 2015 Rommel Suarez. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginController: UITableViewController {
    let userService = UserService(newProfileDao: ProfileDao(), newUserDao: UserDao())
    var profileform = ProfileForm()
    
    @IBOutlet weak var manualLoginButton: UIButton!
    @IBOutlet weak var facebookLoginButton: UIButton!
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    
    override func viewDidLoad() {
    
        
    }
    
    @IBAction func manualLoginButtonOnClick(sender: AnyObject) {
        
        let user = User()
        
        user.email = self.emailText.text
        user.password = self.passwordText.text
        
        self.userService.login(user, completion: { (data, reponseMessage) -> () in
            
                 dispatch_async(dispatch_get_main_queue()) {
                    
                    CommonUtil.processErrorUIResponseMsg("Login", responseMessage: reponseMessage)
                    
                   
                   
                    if reponseMessage.code == ResponseStatus.Success {
                        if data != nil {
                            
                            let alertView = UIAlertView(title: "Log-in successful", message: "Log-in successful", delegate: nil, cancelButtonTitle: "OK")
                            alertView.show()
                            
                            Constants.UserEmail = user.email
                            Constants.ProfileID = data.profile.id
                            
                            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("RevealViewController") as! SWRevealViewController
                            self.navigationController!.presentViewController(controller, animated: true, completion: { () -> Void in
                                
                            })

                        }
                    }else{
                        dispatch_async(dispatch_get_main_queue()) {
                            let alertView = UIAlertView(title: "Log-in failed", message: "User account does not exist", delegate: nil, cancelButtonTitle: "OK")
                            alertView.show()
                        }
                        

                    }
                    
                }
               
        
                
            
                
                
          
            
        })

    }
    
   
    
    @IBAction func facebookLoginButtonOnClick(sender: AnyObject) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager .logInWithReadPermissions(["email","user_location"], handler: { (result, error) -> Void in
            
           
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    
                    
                    self.userService.getFBUserData({ (data, error) -> () in
                        let user = User()
                        user.email = data.user.email
                        Constants.UserFBPhoto = data.avatar
                       
                        
                        
                       self.userService.isUserExist(user, completion: { (user, responseMessage) -> () in
                       
                        
                            
                            dispatch_async(dispatch_get_main_queue()) {
                                
                                CommonUtil.processErrorUIResponseMsg("Facebook Login", responseMessage: responseMessage)
                                
                                if responseMessage.code == ResponseStatus.Success {
                                    if data != nil {
                                        
                                        let alertView = UIAlertView(title: "Log-in successful", message: "Log-in successful", delegate: self, cancelButtonTitle: "OK")
                                        alertView.show()
                                        
                                        Constants.UserEmail = data.user.email
                                        Constants.ProfileID = user.profile.id
                                        print(Constants.ProfileID )
                                        
                                        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("RevealViewController") as! SWRevealViewController
                                        self.navigationController!.presentViewController(controller, animated: true, completion: { () -> Void in
                                            
                                        })

                                    }
                                }else{
                                    
                                    let alertView = UIAlertView(title: "Log-in failed", message: "User account does not exist", delegate: self, cancelButtonTitle: "OK")
                                    alertView.show()
                                }


                                
                                
                            }
                        
                       })
                        
                        
                    })
                    
                }
                
            }
            
            
           
        })
        

    }

}
