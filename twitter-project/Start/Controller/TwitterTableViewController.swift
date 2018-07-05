//
//  StartTableViewController.swift
//  twitter-project
//
//  Created by Дмитрий Матвеенко on 05.07.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit
import RealmSwift

class FeedTableViewController: UITableViewController {

    @IBOutlet var tableTwitContent: UITableView!
    @IBAction func close(segue: UIStoryboardSegue) {
        tableTwitContent.reloadData()
    }
    
    var twitList: Results<Messages>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try! Realm()
        //fetchCurrentWeatherData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        twitList = realm.objects(Messages.self)
        self.twitList = self.twitList.sorted(byKeyPath: "createdAt", ascending:false)
        
        self.tableTwitContent.setEditing(false, animated: true)
        self.tableTwitContent.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableTwitContent.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twitList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        
        let item = twitList[indexPath.row]
        cell.textTwitLabel.text = item.text
        return cell
    }
    
    // MARK: - Delete and edit from table
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            let item = self.twitList[indexPath.row]
            try! realm.write({
                realm.delete(item)
            })
            
            tableView.deleteRows(at:[indexPath], with: .automatic)
        }
        
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            let twitToBeUpdated = self.twitList[indexPath.row]
            self.performSegue(withIdentifier: "editTwit", sender: twitToBeUpdated)
        }
        
        edit.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        delete.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        return [delete, edit]
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editTwit" {
            let destinationEditViewController = (segue.destination as! UINavigationController).topViewController as! EditTwitTableViewController
            
            let object = sender as! Messages
            
            let editText = object.text
            
            destinationEditViewController.editTwitText = editText
            destinationEditViewController.twitToDelete = object
        }
    }
    
    // MARK: - This Data for Weather API
    
//    lazy var weatherManager = APIWeatherManager(apiKey: "416e4d01fc649f94c5c4b5c68ec20ed6")
//    
//    let coordinates = [
//        Coordinates(latitude: 59.939095, longitude: 30.315868, name: "St. Petersburg"),
//        Coordinates(latitude: 55.755814, longitude: 37.617635, name: "Moscow"),
//        Coordinates(latitude: 54.707390, longitude: 20.507307, name: "Kaliningrad"),
//        Coordinates(latitude: 53.195063, longitude: 45.018316, name: "Penza"),
//        Coordinates(latitude: 55.030199, longitude: 82.920430, name: "Novosibirsk"),
//        Coordinates(latitude: 55.796289, longitude: 49.108795, name: "Kazan"),
//        Coordinates(latitude: 58.522810, longitude: 31.269915, name: "Veliky Novgorod"),
//        Coordinates(latitude: 56.326887, longitude: 44.005986, name: "Nizhny Novgorod"),
//        Coordinates(latitude: 54.989342, longitude: 73.368212, name: "Omsk"),
//        Coordinates(latitude: 53.195538, longitude: 50.101783, name: "Samara")
//    ]
}
