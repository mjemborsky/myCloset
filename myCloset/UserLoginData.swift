//
//  UserLoginData.swift
//  myCloset
//
//  Created by Jonah Gloss on 2/22/23.
//

import Foundation


class UserLoginData {
    var password: String
    var email: String

    
    init(password: String, email: String) {
        self.password = password
        self.email = email

    }
}

let SAMPLE_USERLOGINDATA:[UserLoginData] = [
    UserLoginData(password: "myclosetfan21", email: "jonahgloss@gmail.com"),
    UserLoginData(password: "rockymountain11", email: "elicopeland@gmail.com"),
    UserLoginData(password: "tinroof365", email: "rielymurray@gmail.com")]
