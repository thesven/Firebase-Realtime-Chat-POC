//
//  ContentView.swift
//  RealTimeChat-Firebase
//
//  Created by Michael Svendsen on 2021-02-23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var sessionStore = SessionStore()
    
    init() {
        sessionStore.listen()
    }
    
    
    var body: some View {
        ChatList()
            .fullScreenCover(isPresented: .constant(sessionStore.isAnon), content: {
                Login()
            })
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
