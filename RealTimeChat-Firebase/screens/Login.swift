//
//  Login.swift
//  RealTimeChat-Firebase
//
//  Created by Michael Svendsen on 2021-02-23.
//

import SwiftUI

struct Login: View {
    
    @State var email = ""
    @State var password = ""
    @ObservedObject var sessionStore = SessionStore()
    
    var body: some View {
        NavigationView {
            VStack{
                TextField("email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    sessionStore.signIn(email: email, password: password)
                }, label: {
                    Text("Sign In")
                })
                Button(action: {
                    sessionStore.signUp(email: email, password: password)
                }, label: {
                    Text("Sign Up")
                })
            }
            .navigationTitle("Welcome")
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
