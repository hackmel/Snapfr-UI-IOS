//
//  Service.swift
//  Snapfr
//
//  Created by Rommel Suarez on 26/9/15.
//  Copyright (c) 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class Service {
    
    var id:String! = ""
    var name : String! = ""
    var summary : String! = ""
    var price: Float! = 0.00
    var serviceGroup : ServiceGroup! = ServiceGroup()
    var serviceImage :Array<ServiceImage> = []
    
    
}