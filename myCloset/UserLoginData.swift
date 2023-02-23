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

let SAMPLE_USERLOGINDATA:[UserLoginData] = [
    UserLoginData(username: "jonahgloss", password: "myclosetfan21", email: "jonahgloss@gmail.com"),
    UserLoginData(username: "elicopeland", password: "rockymountain11", email: "elicopeland@gmail.com"),
    UserLoginData(username: "rielymurray", password: "tinroof365", email: "rielymurray@gmail.com")]
