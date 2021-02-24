//
//  Messages.swift
//  RealTimeChat-Firebase
//
//  Created by Michael Svendsen on 2021-02-24.
//

import SwiftUI

struct Messages: View {
    
    let chatroom: Chatroom
    @ObservedObject var viewModel = MessagesViewModel()
    @State var messageField  = ""
    
    init(chatroom: Chatroom){
        print("Chat Room Init")
        self.chatroom = chatroom
        viewModel.fetchData(docId: chatroom.id)
        print(viewModel.messages.count)
    }
    
    var body: some View {
        VStack{
            List(viewModel.messages){ message in
                HStack{
                    Text(message.content)
                    Spacer()
                }
            }
            HStack{
                TextField("Enter Message ...", text: $messageField)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    viewModel.sendMessage(messageContent: messageField, docId: chatroom.id)
                }, label: {
                    Image(systemName: "paperplane.circle.fill")
                })
            }
        }
        .navigationTitle(chatroom.title)
    }
}

struct Messages_Previews: PreviewProvider {
    static var previews: some View {
        Messages(chatroom: Chatroom(id: "EfMijhHfW1ODz8WkHPKJ", title: "My Chat Room", joinCode: 81618))
    }
}
