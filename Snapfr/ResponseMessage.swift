//
//  ResponseMessage.swift
//  Snapfr
//
//  Created by Rommel Suarez on 6/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import Foundation

class ResponseMessage {
    
    var code: ResponseStatus! = ResponseStatus.Success
    
    var data:NSDictionary = [String: AnyObject]();
    var error:NSDictionary = [String: AnyObject]();
    var dataCollection:NSArray! = [];
    var nsError:NSError? = nil
    var errorType:ErrorType? = nil
    var message: String! = "";
    


}
