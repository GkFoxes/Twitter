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
    //let postedDate: Date
    let reference: DatabaseReference?
    
    init(text: String, userId: String) {
        self.text = text
        self.userId = userId
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +zzzz"
       // guard let date = dateFormatter.date(from: dateString) else { return }
        
        self.reference = nil
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        text = snapshotValue["text"] as! String
        userId = snapshotValue["userId"] as! String
        //postedDate = snapshotValue["postedDate"] as! String
        reference = snapshot.ref
    }
    
    func convertToDictionary() -> Any {
        return ["text": text, "userId": userId]
    }
}
