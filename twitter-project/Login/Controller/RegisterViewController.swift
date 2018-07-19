//
//  RegisterViewController.swift
//  twitter-project
//
//  Created by Дмитрий Матвеенко on 11.07.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        warningLabel.alpha = 0
        ref = Database.database().reference(withPath: "users")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.becomeFirstResponder()
    }
    
    // MARK: - Warning alert manager
    
    func alertWarning(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Button Action
    
    @IBAction func registerTapped(_ sender: UIButton) {
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            email != "", password != "" else {
                alertWarning(title: "Empty field", message: "You did not fill all the fields, please check again.")
                return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            guard error == nil, user != nil else {
                if password.count < 6 {
                    self.alertWarning(title: "Can not register", message: "Warning, password must be longer than 5 characters.")
                } else {
                    self.alertWarning(title: "Can not register", message: "Warning, please check the entered data.")
                }
                return
            }
            
            let userRef = self.ref.child((user?.user.uid)!)
            userRef.setValue(["email": user?.user.email])
            self.performSegue(withIdentifier: "feedFromRegister", sender: nil)
        })
    }
}
