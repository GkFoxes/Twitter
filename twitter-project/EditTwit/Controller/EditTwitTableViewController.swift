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
    var ref: DatabaseReference!
    var user: Username!
    var twitRealmToEdit = Messages()
    var twitFirebaseToEdit: Twit!
    
    @IBOutlet weak var editTwitTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        editTwitTextView.text = editTwitText
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        editTwitTextView.becomeFirstResponder()
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
    
    // MARK: - Button Action
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if ((editTwitTextView.text?.isEmpty)! || editTwitTextView.text == " ") {
            let alert = UIAlertController(title: "Can not save", message: "You did not fill all the fields, please check again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            
            let twitlItem = Messages()
            twitlItem.text = editTwitTextView.text!
            
            try! realm.write {
                twitRealmToEdit.text = twitlItem.text
            }
            
            ref.child(twitFirebaseToEdit.postId!).updateChildValues(["text" : editTwitTextView.text])
            performSegue(withIdentifier: "unwindEditSegueFromNewTwit", sender: self)
        }
    }
}
