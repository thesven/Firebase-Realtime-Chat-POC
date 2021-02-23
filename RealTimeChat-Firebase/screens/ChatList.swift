//
//  ChatList.swift
//  RealTimeChat-Firebase
//
//  Created by Michael Svendsen on 2021-02-23.
//

import SwiftUI

struct ChatList: View {
    
    @ObservedObject var viewModel = ChatroomsViewModel()
    
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
        }
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList()
    }
}
