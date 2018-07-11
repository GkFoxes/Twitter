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
   
    var twitList: Results<Messages>!
    
    var reference: DatabaseReference!
    var user: Username!
    
    let myEmail = "dima26tamys@gmail.com"
    let myPassword = "xyz123456"
    
    @IBOutlet var tableTwitContent: UITableView!
    @IBAction func close(segue: UIStoryboardSegue) {
        tableTwitContent.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try! Realm()
        
        //reference = Database.database().reference(withPath: "users")
        
//        Auth.auth().addStateDidChangeListener({ [weak self] (auth, user) in
//            if user == nil {
//                Auth.auth().signIn(withEmail: (self?.myEmail)!, password: (self?.myPassword)!) { (user, error) in
//                    if error != nil {
//                        let alert = UIAlertController(title: "Can not sign", message: "Please check again.", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
//                            NSLog("The \"OK\" alert occured.")
//                        }))
//                        self?.present(alert, animated: true, completion: nil)
//                    }
//                }
//            }
//        })
        
//        guard let currentUser = Auth.auth().currentUser else { return }
//        user = Username(user: currentUser)
//        reference = Database.database().reference(withPath: "users").child(String(user.uid)).child("twits")
        
        if !UserDefaults.standard.bool(forKey: "db_install") {
            twitInitial()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        twitList = realm.objects(Messages.self)
        self.twitList = self.twitList.sorted(byKeyPath: "createdAt", ascending: false)
        
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
            
            let twit = twits[indexPath.row]
            twit.reference?.removeValue()
            
            tableView.deleteRows(at:[indexPath], with: .automatic)
        }
        
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            let twitIndex = indexPath.row
            self.performSegue(withIdentifier: "editTwit", sender: twitIndex)
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
            
            let index = sender as! Int
            let object = twitList[index]
            let objectToFirebase = twits[index]
            let editText = object.text
            
            destinationEditViewController.editTwitText = editText
            destinationEditViewController.twitToDelete = object
            destinationEditViewController.ref = reference
            destinationEditViewController.user = user
            destinationEditViewController.twitToEdit = objectToFirebase
        }
    }
    
    // MARK: - Initial Firebase Data
    
    func twitInitial() {
        
        guard let currentUser = Auth.auth().currentUser else { return }
        self.user = Username(user: currentUser)
        self.reference = Database.database().reference(withPath: "users").child(String(self.user.uid)).child("twits")
        
        self.reference.observe(.value, with: {[weak self] (snapshot) in
            
            for item in snapshot.children {
                let twitsInitial = Twit(snapshot: item as! DataSnapshot)
                twits.append(twitsInitial)
                twits.sort(by: { $0.date.compare($1.date) == .orderedDescending })
                
                let twitForRealm = Messages()
                twitForRealm.text = twitsInitial.text
                
                try! realm.write({
                    realm.add(twitForRealm)
                })
            }
            
            self?.tableTwitContent.reloadData()
        })
        UserDefaults.standard.set(true, forKey: "db_install")
    }
}
