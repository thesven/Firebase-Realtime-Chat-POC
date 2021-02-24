//
//  Join.swift
//  RealTimeChat-Firebase
//
//  Created by Michael Svendsen on 2021-02-23.
//

import SwiftUI

struct Join: View {

    @Binding var isOpen: Bool
    
    @State var joinCode = ""
    @State var roomTitle = ""
    
    var viewModel = ChatroomsViewModel()

    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    Text("Join a Chat Room")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    TextField("Enter the Chat ID", text: $joinCode)
                    Button(action: {
                        viewModel.joinChatroom(code: joinCode) {
                            self.isOpen = false
                        }
                    }, label: {
                        Text("Join")
                    })
                }.padding(.bottom)
                VStack{
                    Text("Create a Chat Room")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    TextField("Enter A Chat Name", text: $roomTitle)
                    Button(action: {
                        viewModel.createChatroom(title: roomTitle) {
                            self.isOpen = false
                        }
                    }, label: {
                        Text("Join")
                    })
                }.padding(.top)
            }
                .navigationTitle("Join or Create")
        }
    }
}

struct Join_Previews: PreviewProvider {
    static var previews: some View {
        Join(isOpen: .constant(true) )
    }
}
