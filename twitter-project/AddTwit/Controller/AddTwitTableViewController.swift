//
//  AddTwitTableViewController.swift
//  twitter-project
//
//  Created by Дмитрий Матвеенко on 05.07.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

class AddTwitTableViewController: UITableViewController {
    
    var ref: DatabaseReference!
    var user: Username!
    
    @IBOutlet weak var addTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addTextView.becomeFirstResponder()
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Add new Twit"
    }
    
    // MARK: - Button Action
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if ((addTextView.text?.isEmpty)! || addTextView.text == " ") {
            let alert = UIAlertController(title: "Can not save", message: "You did not fill all the fields, please check again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            
            let twitItem = Messages()
            twitItem.text = addTextView.text!
            
            try! realm.write({
                realm.add(twitItem)
            })
            
            let dateNow = Date()
            
            let twit = Twit(text: addTextView.text!, username: ("GkFoxes"), date: dateNow)
            twits.append(twit)
            twits.sort(by: { $0.date.compare($1.date) == .orderedDescending })
            
            let taskRef = self.ref.childByAutoId()
            taskRef.setValue(twit.convertToDictionary())
            
            performSegue(withIdentifier: "unwindSegueFromNewTwit", sender: self)
        }
    }
}
