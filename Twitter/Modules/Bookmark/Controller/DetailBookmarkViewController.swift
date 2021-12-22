//
//  DetailBookmarkViewController.swift
//  Twitter
//
//  Created by Дмитрий Матвеенко on 31/01/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

class DetailBookmarkViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tweetTextField: UITextView!
    
    let tweetRealm: TweetRealm = TweetRealm();
    var information: TweetRealm = TweetRealm();
    
    var text = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextField.becomeFirstResponder()
        tweetTextField.text = text
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        tweetRealm.updateDataObject(information, text: tweetTextField.text)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tweetTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
