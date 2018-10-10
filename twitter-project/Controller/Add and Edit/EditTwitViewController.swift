//
//  EditTwitTableViewController.swift
//  twitter-project
//
//  Created by Дмитрий Матвеенко on 05.07.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit
import Firebase

class EditTwitViewController: UIViewController {
    
    var editTwitText = "Twit"
    
    var ref: DatabaseReference!
    var user: Username!
    
    var twitRealmToEdit = Messages()
    var twitFirebaseToEdit: Twit!
    
    @IBOutlet weak var editTwitTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editTwitTextView.text = editTwitText
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        editTwitTextView.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
            
            performSegue(withIdentifier: "unwindSegueFromEditTwit", sender: self)
        }
    }
}
