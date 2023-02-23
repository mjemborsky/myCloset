//
//  UserLoginData.swift
//  myCloset
//
//  Created by Jonah Gloss on 2/22/23.
//

import Foundation


class UserLoginData {
    var username: String
    var password: String
    var email: String

    
    init(username: String, password: String, email: String) {
        self.username = username
        self.password = password
        self.email = email

    }
}
