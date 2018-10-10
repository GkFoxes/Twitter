//
//  SharedManager.swift
//  twitter-project
//
//  Created by Дмитрий Матвеенко on 10/10/2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import Foundation

class SharedManager {
    
    var isLogin = false
    var twits = Array<Twit>()
    var isLoginFirst = false
    
    static let shared = SharedManager()
    
    private init() {}
    
    func reset() {
        isLogin = false
        twits = Array<Twit>()
        isLoginFirst = false
    }
}
