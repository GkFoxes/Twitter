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

class AddTwitViewController: UIViewController {
    
    var ref: DatabaseReference!
    var user: Username!
    
    @IBOutlet weak var addTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addTextView.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Button Action
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if ((addTextView.text?.isEmpty)! || addTextView.text == " ") {
            let alert = UIAlertController(title: "Can not save", message: "You did not fill all the fields, please check again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            
            let twitItem = Messages()
            twitItem.text = addTextView.text!
            
            try! realm.write({
                realm.add(twitItem)
            })
            
            let dateNow = Date()
            var twit = Twit(text: addTextView.text, username: (user.email), date: dateNow)
            
            let taskRef = self.ref.childByAutoId()
            taskRef.setValue(twit.convertToDictionary())
            
            twit.reference = taskRef.ref
            twit.postId = taskRef.key
            twits.insert(twit, at: 0)
            
            performSegue(withIdentifier: "unwindSegueFromNewTwit", sender: self)
        }
    }
}