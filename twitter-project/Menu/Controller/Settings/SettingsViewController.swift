//
//  SettingsViewController.swift
//  twitter-project
//
//  Created by Дмитрий Матвеенко on 23.07.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    
    var ref: DatabaseReference!
    var user: Username!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let currentUser = Auth.auth().currentUser else { return }
        user = Username(user: currentUser)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Button Action
    
    @IBAction func updateTapped(_ sender: Any) {
        let currentUser = Auth.auth().currentUser
        
        if emailTextField.text != "" {
            let email = emailTextField.text
            
            currentUser?.updateEmail(to: email!) { error in
                if let error = error {
                    print(error)
                } else {
                    self.user.email = email!
                    
                    let userRef = Database.database().reference(withPath: "users").child(String(self.user.uid))
                    userRef.updateChildValues(["email": email!])
                }
            }
        }
        
        if passwordTextField.text != "" {
            let password = passwordTextField.text
            
            currentUser?.updatePassword(to: password!) { error in
                if let error = error {
                    print(error)
                }
            }
        }
    }
    
    @IBAction func exitTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        self.dismiss(animated: true, completion: nil)
        
        twits.removeAll()
        try! realm.write {
            realm.deleteAll()
        }
        
        isLoginFirst = false
        isLogin = false
        self.performSegue(withIdentifier: "unwindToLogin", sender: nil)
    }
}
