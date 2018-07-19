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
    
    @IBAction func registerTapped(_ sender: UIButton) {
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            email != "", password != "" else {
            //displayWarningLabel(withText: "Info is incorrect")
            warningLabel.text = "Info is incorrect"
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] (user, error) in
            
            guard error == nil, user != nil else {
                print(error!.localizedDescription)
                return
            }

            let userRef = self?.ref.child((user?.user.uid)!)
            userRef?.setValue(["email": user?.user.email])
        })
        self.performSegue(withIdentifier: "toLoginSegue", sender: nil)
    }
}
