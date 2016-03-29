//
//  Profile.swift
//  Snapfr
//
//  Created by Rommel Suarez on 22/8/15.
//  Copyright (c) 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class Profile  {
    
    
    var id: String! = ""
    var name : String! = ""

    var isPhotographer : Bool! = false
    var isCustomer : Bool! = false
    var location : String! = ""
    var avatar : String! = ""
    var verySmallAvatar : String! = ""
    
    
    var user : User = User()
    var serviceGroup : Array<ServiceGroup> = []
    var reviews : Array<Review> = []

    
    
    
    
         

    
    
    
}
