//
//  file.swift
//  realms
//
//  Created by Mean Reaksmey on 11/2/16.
//  Copyright © 2016 Mean Reaksmey. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift
import ObjectMapper

var allPeople = List<Human>()
var jsonData = [JSON]()
var pagination : NSInteger = 1

func queryPeople(){
    allPeople.removeAll()
    let realm = try! Realm()
    let myFilter = realm.objects(Human.self)
    var indexCatch: NSInteger = 0
    
    let allPerson = List<Human>()
    
    for data in myFilter{
        allPerson.append(data)
        indexCatch += 1
        if indexCatch >= pagination {
            allPeople = allPerson
            print("====pagination: ",pagination)
            if pagination < myFilter.count - 2{
                pagination += 1
                print("====",myFilter.count)
                return
            }
        }
    }
    
    
    var jsonString = "{" +
        "\"Language\": {" +
        "\"Field\":[" +
        "{" +
        "\"Number\":\"976\"," +
        "\"Name\":\"Test\"" +
        "}," +
        "{" +
        "\"Number\":\"977\"," +
        "\"Name\":\"Test\"" +
        "}" +
        "]" +
        "}" +
    "}"
    
    let user = Mapper<Human>().map(jsonString)
    print("")
    
    
}

func searchData(search_name:String,new_name:String){
    
    for data in getAllPeople(){
        if search_name == data.name{
            let realm = try! Realm()
            try! realm.write {
                if validateData(item: new_name){
                    data.name = new_name
                }
            }
        }
    }
}

func getAllPeople()->List<Human>{
    let items =  List<Human>()
    let realm = try! Realm()
    let myFilter = realm.objects(Human.self)
    for data in myFilter{
        items.append(data)
    }
    return items
}

func validateData( item: String)->Bool{
    
    print("mytest======= \(allPeople)")
    for data in getAllPeople(){
        if item == data.name{
            print("======= \(item) has ready")
            
            return false
        }
    }
    print("======success insert")
    return true
}
