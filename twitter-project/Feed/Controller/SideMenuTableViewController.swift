//
//  SideMenuTableViewController.swift
//  twitter-project
//
//  Created by Дмитрий Матвеенко on 22.07.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit
import Firebase

class SideMenuTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

class SideMenuTableViewController: UITableViewController {
    
    @IBOutlet var sideMenuTable: UITableView!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        
//        let emailCell = SideMenuTable.dequeueReusableCell(withIdentifier: "Email") as! SideMenuTableViewCell
//        let cells = [emailCell]
        
        switch indexPath.row {
            case 0: NotificationCenter.default.post(name: NSNotification.Name("ShowProfile"), object: nil)
            case 1: NotificationCenter.default.post(name: NSNotification.Name("ShowSettings"), object: nil)
            default: break
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
