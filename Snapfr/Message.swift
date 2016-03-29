//
//  Message.swift
//  Snapfr
//
//  Created by Rommel Suarez on 5/12/15.
//  Copyright © 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class Message {
    
    var id: String! = ""
    var sender : Profile = Profile()
    var receiver : Profile = Profile()
    var textMsg : String! = ""
    var imageMsg : String! = ""
    var status : MessageStatus = MessageStatus.NotSeen
    

}
