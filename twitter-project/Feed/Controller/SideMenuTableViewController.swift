//
//  SideMenuTableViewController.swift
//  twitter-project
//
//  Created by Дмитрий Матвеенко on 22.07.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        
        switch indexPath.row {
        case 0: NotificationCenter.default.post(name: NSNotification.Name("ShowProfile"), object: nil)
        case 1: NotificationCenter.default.post(name: NSNotification.Name("ShowSettings"), object: nil)
        case 2: NotificationCenter.default.post(name: NSNotification.Name("ShowSignIn"), object: nil)
        default: break
        }
    }
    
//    @IBAction func signOutTapped(_ sender: UIBarButtonItem) {
//        let alert = UIAlertController(title: user.email, message: "You can update the data or sign out", preferredStyle: .alert)
//        alert.addTextField { (textFieldEmail) in
//            textFieldEmail.placeholder = "Email"
//        }
//        alert.addTextField { (textFieldPassword) in
//            textFieldPassword.placeholder = "Password"
//            textFieldPassword.isSecureTextEntry = true
//        }
//
//        let update = UIAlertAction(title: "Save", style: .default) { _ in
//            let currentUser = Auth.auth().currentUser
//
//            if alert.textFields?.first?.text != "" {
//                let textFieldEmail = alert.textFields?.first?.text
//
//                currentUser?.updateEmail(to: textFieldEmail!) { error in
//                    if let error = error {
//                        print(error)
//                    } else {
//                        self.user.email = textFieldEmail!
//
//                        let userRef = Database.database().reference(withPath: "users").child(String(self.user.uid))
//                        userRef.updateChildValues(["email": textFieldEmail!])
//                    }
//                }
//            }
//
//            if alert.textFields?[1].text != "" {
//                let textFieldPassword = alert.textFields?[1].text
//
//                currentUser?.updatePassword(to: textFieldPassword!) { error in
//                    if let error = error {
//                        print(error)
//                    }
//                }
//            }
//        }
//
//        let exit = UIAlertAction(title: "Exit", style: .destructive) { _ in
//
//            do {
//                try Auth.auth().signOut()
//            } catch {
//                print(error.localizedDescription)
//            }
//            self.dismiss(animated: true, completion: nil)
//
//            twits.removeAll()
//            try! realm.write {
//                realm.deleteAll()
//            }
//
//            isLoginFirst = false
//            isLogin = false
//            self.performSegue(withIdentifier: "unwindToLogin", sender: nil)
//        }
//
//        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//
//        alert.addAction(update)
//        alert.addAction(cancel)
//        alert.addAction(exit)
//        present(alert, animated: true, completion: nil)
//    }
}
