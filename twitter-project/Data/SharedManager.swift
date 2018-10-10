//
//  SharedManager.swift
//  twitter-project
//
//  Created by Дмитрий Матвеенко on 10/10/2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import Foundation

class SharedManager {
    
    var isLoginFirst = false
    var isLogin = false
    var twits = Array<Twit>()
    
    static let shared = SharedManager()
    
    private init() {}
    
    func reset() {
        isLoginFirst = false
        isLogin = false
        twits = Array<Twit>()
    }
}
