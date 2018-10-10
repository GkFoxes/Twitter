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
    
    let shared = SharedManager.shared
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reference = Database.database().reference(withPath: "users")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil {
            shared.isLogin = true
        }
        
        emailTextField.becomeFirstResponder()
    }
    
    // MARK: - Warning alert manager
    
    func alertWarning(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Button Action
    
    @IBAction func loginTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text,
            email != "", password != "" else {
                alertWarning(title: "Empty field", message: "You did not fill all the fields, please check again.")
                return
        }
        
        let queue = DispatchQueue.global(qos: .userInteractive)
        queue.async{
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error != nil {
                    self.alertWarning(title: "Can not login", message: "Warning, please check the entered data.")
                }
                
                if user != nil {
                    self.shared.isLogin = true
                    self.shared.isLoginFirst = true
                    
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "feedSegue", sender: nil)
                    }
                } else {
                    self.alertWarning(title: "Can not login", message: "User does not exist, please check the entered data.")
                }
            })
        }
    }
}
