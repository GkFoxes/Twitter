//
//  TwitFirebase.swift
//  twitter-project
//
//  Created by Дмитрий Матвеенко on 07.07.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import Foundation
import Firebase

struct Twit {
    var postId: String?
    let text: String
    let username: String
    let date: Date
    var reference: DatabaseReference?
    
    init(text: String, username: String, date: Date) {
        self.text = text
        self.username = username
        self.date = date
        self.postId = nil
        self.reference = nil
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        text = snapshotValue["text"] as! String
        username = snapshotValue["username"] as! String
        postId = snapshot.key
        
        let dateString = snapshotValue["date"] as! String
        let dateFormat = "yyyy-MM-dd HH:mm:ss +zzzz"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        date = dateFormatter.date(from: dateString)!
        
        reference = snapshot.ref
    }
    
    func convertToDictionary() -> Any {
        return ["text": text, "username": username, "date": "\(date)"]
    }
}
