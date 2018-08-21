//
//  ProfileViewController.swift
//  twitter-project
//
//  Created by Дмитрий Матвеенко on 23.07.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    var ref: DatabaseReference!
    var user: Username!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currentUser = Auth.auth().currentUser else { return }
        user = Username(user: currentUser)
        
        emailLabel.text = user.email
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
