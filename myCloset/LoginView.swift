//
//  LoginView.swift
//  myCloset
//
//  Created by Jonah Gloss on 2/22/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showSignUpPage = false
    @State private var showFeedView = false
    @State private var showforgotPassword = false

    var body: some View {
        
        VStack {
            
            Spacer()
            
            Image("logo")
                .resizable()
                .frame(width:250, height: 200)
                .padding()
            
            TextField("Email", text: $email )
                .padding()
                .background(Color.gray.opacity(0.05))
                .cornerRadius(10)
                .padding(.bottom, 10)
                .textInputAutocapitalization(.never)

            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.05))
                .cornerRadius(10)
                .padding(.bottom, 30)
                .textInputAutocapitalization(.never)
            
            Button(action: {
                login()
            }) {
                
                Text("Login")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.black)
                    .cornerRadius(7)
                
            }
            
            Spacer()
            
            HStack {
                
                Button(action: {
                    self.showSignUpPage = true
                }) {
                    
                    Text("Sign Up")
                        .foregroundColor(.blue)
                        .frame(width: 150, height: 50, alignment: .center)
                }

                Button(action: {
                    self.showforgotPassword = true
                }) {
                    
                    Text("Forgot Password?")
                        .foregroundColor(.blue)
                        .frame(width: 150, height: 50, alignment: .center)
                }
            }
            
            .padding(.bottom, 1)
        }
        
        .sheet(isPresented: $showSignUpPage) {
            SignUpPage()
        }
        
        .sheet(isPresented: $showforgotPassword) {
            forgotPassword()
        }
        
        .fullScreenCover(isPresented: $showFeedView) {
            FeedView(userEmail: email)
        }
        
        .padding()
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                self.showFeedView = true
            }
        }
    }
    
    func signup() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            
        }
        // needs to also create user document in "Users" with 2 fields: username (whatever they enter) and the linkedEmail
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
