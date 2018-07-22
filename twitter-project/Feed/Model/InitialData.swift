//
//  InitialData.swift
//  twitter-project
//
//  Created by Дмитрий Матвеенко on 18.07.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

extension FeedViewController {
    func initialDataToRealm() {
        ref.observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
            for item in snapshot.children {
                let twitsInitial = Twit(snapshot: item as! DataSnapshot)
                let twitForRealm = Messages()
                twitForRealm.text = twitsInitial.text
                try! realm.write({
                    realm.add(twitForRealm)
                })
                
                self?.tableTwitContent.reloadData()
            }
        })
        isLoginFirst = false
    }
    
    func initialDataToFirebase() {
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            for item in snapshot.children {
                let twitsInitial = Twit(snapshot: item as! DataSnapshot)
                twits.append(twitsInitial)
                twits.sort(by: { $0.date.compare($1.date) == .orderedDescending })
            }
        })
    }
}
