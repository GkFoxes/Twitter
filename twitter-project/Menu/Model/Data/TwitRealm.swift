//
//  TwitRealm.swift
//  twitter-project
//
//  Created by Дмитрий Матвеенко on 05.07.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import Foundation
import RealmSwift

class Messages: Object {
    @objc dynamic var text = ""
    @objc dynamic var createdAt = NSDate()
    
    convenience init(text: String) {
        self.init()
        self.text = text
    }
}
