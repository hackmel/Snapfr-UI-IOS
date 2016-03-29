//
//  SendMessageController.swift
//  Snapfr
//
//  Created by Rommel Suarez on 5/12/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class SendMessageController: UIViewController, UITextFieldDelegate {
    
    var profile = Profile()
    
    @IBOutlet weak var receiverImg: UIImageView!
    
    
    @IBOutlet weak var receiverName: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var dockViewHeightConstraint: NSLayoutConstraint!
    
   
    @IBOutlet weak var textMessage: UITextField!
    
    override func viewDidLoad() {
        //self.receiverImg.imageFromUrl(profile.avatar)
        self.receiverName.text = "xxxxx"
        
        self.textMessage.delegate = self
        
        //print(dockViewHeightConstraint.constant)
        
        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tableViewTapped")
        
        self.tableView.addGestureRecognizer(tapGesture)
        
        
    }
   
    @IBAction func sendMessageOnClick(sender: AnyObject) {
        self.textMessage.endEditing(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.view.layoutIfNeeded()
        
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.dockViewHeightConstraint.constant = 330
            self.view.layoutIfNeeded()

            }, completion: nil)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.view.layoutIfNeeded()
        
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.dockViewHeightConstraint.constant = 73
            self.view.layoutIfNeeded()
            
            }, completion: nil)
    }
    
    func tableViewTapped() {
        self.textMessage.endEditing(true)
    }
    
}
