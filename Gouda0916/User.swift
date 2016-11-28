//
//  User.swift
//  Gouda0916
//
//  Created by Marie Park on 11/18/16.
//  Copyright © 2016 Flatiron. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct User {
    
    var uid: String
    var email: String
    
    init() {
        self.email = ""
        self.uid = ""
    }
    
    init(authData: FIRUser) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
}
