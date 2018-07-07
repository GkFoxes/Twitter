//
//  StartTableViewController.swift
//  twitter-project
//
//  Created by Дмитрий Матвеенко on 05.07.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

class FeedTableViewController: UITableViewController {
    
    @IBOutlet var tableTwitContent: UITableView!
    @IBAction func close(segue: UIStoryboardSegue) {
        tableTwitContent.reloadData()
    }
    
    var twitList: Results<Messages>!
    
    var reference: DatabaseReference!
    var user: Username!
    var twits = Array<Twit>()
    
    let myEmail = "dima26tamys@gmail.com"
    let myPassword = "xyz123456"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try! Realm()
        
        //fetchCurrentWeatherData()
        
        reference = Database.database().reference(withPath: "users")
        
        Auth.auth().signIn(withEmail: myEmail, password: myPassword) { (user, error) in
            if error != nil {
                let alert = UIAlertController(title: "Can not sign", message: "Please check again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        guard let currentUser = Auth.auth().currentUser else { return }
        user = Username(user: currentUser)
        reference = Database.database().reference(withPath: "users").child(String(user.uid)).child("twits")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        if !UserDefaults.standard.bool(forKey: "db_install") {
            twitInitial()
        }
        
        twitList = realm.objects(Messages.self)
        self.twitList = self.twitList.sorted(byKeyPath: "createdAt", ascending:false)
        
        self.tableTwitContent.setEditing(false, animated: true)
        self.tableTwitContent.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.reference.removeAllObservers()
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
            //let indexTwit = indexPath.row
            let twit = self.twits[indexPath.row]
            twit.reference?.removeValue()
            
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
        if segue.identifier == "addSegue" {
            let destinationEditViewController = (segue.destination as! UINavigationController).topViewController as! AddTwitTableViewController
            destinationEditViewController.ref = reference
            destinationEditViewController.user = user
        }
        
        if segue.identifier == "editTwit" {
            let destinationEditViewController = (segue.destination as! UINavigationController).topViewController as! EditTwitTableViewController
            
            let object = sender as! Messages
            let editText = object.text
            
            destinationEditViewController.editTwitText = editText
            destinationEditViewController.twitToDelete = object
        }
    }
    // MARK: - Initial Firebase Data
    
    func twitInitial() {
        self.reference.observe(.value, with: {[weak self] (snapshot) in
            var twitsFromFirebase = Array<Twit>()
            
            for item in snapshot.children {
                let twits = Twit(snapshot: item as! DataSnapshot)
                twitsFromFirebase.append(twits)
                
                let twitForRealm = Messages()
                twitForRealm.text = twits.text
                try! realm.write({
                    realm.add(twitForRealm)
                })
            }
            
            self?.twits = twitsFromFirebase
            self?.tableTwitContent.reloadData()
        })
        UserDefaults.standard.set(true, forKey: "db_install")
    }
    
    // MARK: - This Data for Weather API
    
    lazy var weatherManager = APIWeatherManager(apiKey: "416e4d01fc649f94c5c4b5c68ec20ed6")
    
    let coordinates = [
        Coordinates(latitude: 59.939095, longitude: 30.315868, name: "St. Petersburg"),
        Coordinates(latitude: 55.755814, longitude: 37.617635, name: "Moscow"),
        Coordinates(latitude: 54.707390, longitude: 20.507307, name: "Kaliningrad"),
        Coordinates(latitude: 53.195063, longitude: 45.018316, name: "Penza"),
        Coordinates(latitude: 55.030199, longitude: 82.920430, name: "Novosibirsk"),
        Coordinates(latitude: 55.796289, longitude: 49.108795, name: "Kazan"),
        Coordinates(latitude: 58.522810, longitude: 31.269915, name: "Veliky Novgorod"),
        Coordinates(latitude: 56.326887, longitude: 44.005986, name: "Nizhny Novgorod"),
        Coordinates(latitude: 54.989342, longitude: 73.368212, name: "Omsk"),
        Coordinates(latitude: 53.195538, longitude: 50.101783, name: "Samara")
    ]
}
