//
//  ViewController.swift
//  realms
//
//  Created by Mean Reaksmey on 10/31/16.
//  Copyright © 2016 Mean Reaksmey. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var TableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //insert data
        addHuman(name: "bouny",age:30,race:"USA")
        addHuman(name: "Channy",age:30,race:"KH")
        addHuman(name: "Ronny",age:30,race:"TH")
        addHuman(name: "Kakato",age:30,race:"AU")
        //update data
        searchData(search_name: "koki",new_name:"Mina")
        //delete data
        deleteData(name: "Mina")
        //filter query data
        queryPeople()
    }
    
    func deleteData(name:String){
        let realm = try! Realm()
        try! realm.write {
            let deletedNotifications = realm.objects(Human.self).filter("name == %@",name)
            realm.delete(deletedNotifications)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addHuman(name:String,age:NSInteger,race:String){
        let mike = Human()
        mike.name = name
        mike.age  = age
        mike.race = race
        let realm = try! Realm()
        try! realm.write {
            if validateData(item: mike.name){
                print("Added \(mike.name) to Realm\(realm)")
                realm.add(mike)
            }
        }
        
    }
    var allPeople = List<Human>()
    var jsonData = [JSON]()
    
    func queryPeople(){
        let realm = try! Realm()
        let myFilter = realm.objects(Human.self)
        for data in myFilter{
            allPeople.append(data)
        }
        //        allPeople.filter("age==13")
        print(JSON(allPeople))
        TableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  allPeople.count
    }
    var apiURL = ""
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NibTableViewCell", for: indexPath) as! NibTableViewCell
        DispatchQueue.main.async {
            
            cell.txtName.text =  self.allPeople[indexPath.row]["name"] as? String
            cell.txtAge.text =  "\(self.allPeople[indexPath.row].age)"
            cell.txtRace.text =  self.allPeople[indexPath.row]["race"] as? String
        }
        
        
        //        print("===============",)
        
        return cell
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
}

class NibTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var txtRace: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtName: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
