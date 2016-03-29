//
//  UIImageView.swift
//  Snapfr
//
//  Created by Rommel Suarez on 23/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import Foundation


extension UIImageView {
    
    
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                
                if data != nil {
                    self.image = UIImage(data: data!)
                }
                
                
            }
        }
    }
    
    
   }

