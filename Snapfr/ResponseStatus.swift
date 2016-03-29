//
//  ResponseStatus.swift
//  Snapfr
//
//  Created by Rommel Suarez on 26/1/16.
//  Copyright © 2016 Rommel Suarez. All rights reserved.
//

import Foundation

enum ResponseStatus: String {
    
    case Success  = "01"
    case Failed  = "00"
    case Record_Not_Found = "02"
    case Update_Failed = "03"
    
}
