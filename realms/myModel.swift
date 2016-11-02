//
//  File.swift
//  realms
//
//  Created by Mean Reaksmey on 10/31/16.
//  Copyright © 2016 Mean Reaksmey. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON
import ObjectMapper

class Human: Object,Mappable{
    dynamic var name = ""
    dynamic var age: NSInteger = 0
    dynamic var race = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        name <- map["name"]
        age  <- map["age"]
        race <- map["race"]
    }
    
}
