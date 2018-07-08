//
//  EditTwitTableViewController.swift
//  twitter-project
//
//  Created by Дмитрий Матвеенко on 05.07.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit
import Firebase

class EditTwitTableViewController: UITableViewController {
    
    var editTwitText = "Twit"
    var twitToDelete = Messages()
    var ref: DatabaseReference!
    var user: Username!
    
    @IBOutlet weak var editTwitTextView: UITextView!
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if ((editTwitTextView.text?.isEmpty)! || editTwitTextView.text == " ") {
            let alert = UIAlertController(title: "Can not save", message: "You did not fill all the fields, please check again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            
            let twitlItem = Messages()
            twitlItem.text = editTwitTextView.text!
            
            try! realm.write({
                realm.add(twitlItem, update: false)
            })
            
            try! realm.write({
                realm.delete(twitToDelete)
            })
            
            //ref.child("users").child("\(user.uid)").child("twits").updateChildValues([AnyHashable : Any])
            performSegue(withIdentifier: "unwindEditSegueFromNewTwit", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        editTwitTextView.text = editTwitText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
