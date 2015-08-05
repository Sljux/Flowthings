//
//  Flow.swift
//  flowthings-ios-wss
//
//  Created by Ceco on 7/25/15.
//  Copyright © 2015 cityos. All rights reserved.
//

import Foundation

struct Flow {

    init(path: String){
    
        self.path = path
    }
    
    var id : String?
    var filter : String?
    var path : String?
    var description : String?
    var capacity : Int?


}