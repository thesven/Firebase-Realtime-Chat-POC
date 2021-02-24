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
                HStack{
                    Text(chatroom.title)
                    Spacer()
                }
            }
            .navigationBarTitle("Chat Rooms")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Press Me") {
                        self.showJoin = true
                    }
                }
            }
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
