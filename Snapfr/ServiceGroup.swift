//
//  ServiceGroup.swift
//  Snapfr
//
//  Created by Rommel Suarez on 20/9/15.
//  Copyright (c) 2015 Rommel Suarez. All rights reserved.
//

import Foundation

class ServiceGroup {
   
    var id: String! = ""
    var name : String! = ""
    var summary : String! = ""
    var profile : Profile! = Profile()
    
    var service : Array<Service> = []
}
