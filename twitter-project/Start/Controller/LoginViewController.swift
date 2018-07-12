//
//  LoginViewController.swift
//  twitter-project
//
//  Created by Дмитрий Матвеенко on 11.07.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var reference: DatabaseReference!
    fileprivate(set) var auth:Auth?
    fileprivate(set) var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        warningLabel.alpha = 0
        
        reference = Database.database().reference(withPath: "users")
        self.authStateListenerHandle = self.auth?.addStateDidChangeListener { (auth, user) in
            guard user != nil else {
                self.performSegue(withIdentifier: "feedSegue", sender: nil)
                return
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func displayWarningLabel(withText text: String) {
        warningLabel.text = text
        
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.warningLabel.alpha = 1
        }) { [weak self] complete in
            self?.warningLabel.alpha = 0
        }
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text,
            email != "", password != ""
            else {
                displayWarningLabel(withText: "Info is incorrect")
                return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] (user, error) in
            if error != nil {
                self?.displayWarningLabel(withText: "Error occured")
                return
            }
            
            if user != nil {
                self?.performSegue(withIdentifier: "feedSegue", sender: nil)
                return
            }
            
            self?.displayWarningLabel(withText: "No such user")
        })
    }
    
}
