//
//  CommonUtil.swift
//  Snapfr
//
//  Created by Rommel Suarez on 23/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import Foundation

class CommonUtil {
    
    static func processErrorUIResponseMsg(title:String,responseMessage:ResponseMessage ) -> Void {
        
        if responseMessage.code == ResponseStatus.Failed{
            let alertView = UIAlertView(title: title, message: responseMessage.message, delegate: self, cancelButtonTitle: "OK")
            alertView.show()
            return
            
        }
        
        
        
        if responseMessage.errorType != nil{
            print(responseMessage.errorType)
            let alertView = UIAlertView(title: title, message: "A technical issue occured", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
            return
        }
        
        
        
        if responseMessage.nsError != nil{
            print(responseMessage.nsError)
            let alertView = UIAlertView(title: title, message: "A technical issue occured", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
            return
        }
        

    }
}
