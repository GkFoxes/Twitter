//
//  User.swift
//  twitter-project
//
//  Created by Дмитрий Матвеенко on 07.07.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import Foundation
import Firebase

struct Username {
    let uid: String
    var email: String
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email!
    }
}
