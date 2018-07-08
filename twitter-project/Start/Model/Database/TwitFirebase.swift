//
//  TwitFirebase.swift
//  twitter-project
//
//  Created by Дмитрий Матвеенко on 07.07.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import Foundation
import Firebase

var twits = Array<Twit>()

struct Twit {
    let text: String
    let userId: String
    let date: Date
    let reference: DatabaseReference?
    
    init(text: String, userId: String, date: Date) {
        self.text = text
        self.userId = userId
        self.date = date
        
        self.reference = nil
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        text = snapshotValue["text"] as! String
        userId = snapshotValue["userId"] as! String
        
        let dateString = snapshotValue["date"] as! String
        let dateFormat = "yyyy-MM-dd HH:mm:ss +zzzz"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        date = dateFormatter.date(from: dateString)!
        
        reference = snapshot.ref
    }
    
    func convertToDictionary() -> Any {
        return ["text": text, "userId": userId, "date": "\(date)"]
    }
}
