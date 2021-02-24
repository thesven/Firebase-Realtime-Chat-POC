//
//  ChatList.swift
//  RealTimeChat-Firebase
//
//  Created by Michael Svendsen on 2021-02-23.
//

import SwiftUI

struct ChatList: View {
    
    @ObservedObject var viewModel = ChatroomsViewModel()
    @State var showJoin = false
    
    init() {
        viewModel.fetchData()
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.chatrooms) { chatroom in
                NavigationLink(
                    destination: Messages(chatroom: chatroom)){
                    HStack{
                        Text(chatroom.title)
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Chat Rooms")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        self.showJoin = true
                    }, label: {
                        Image(systemName: "plus.circle")
                    })
                }
            }.listItemTint(.purple)
            .sheet(isPresented: self.$showJoin, content: {
                Join(isOpen: $showJoin)
            })
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList()
    }
}
