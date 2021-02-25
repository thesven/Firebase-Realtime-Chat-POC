//
//  MessagesViewModal.swift
//  RealTimeChat-Firebase
//
//  Created by Michael Svendsen on 2021-02-24.
//

import Foundation
import Firebase

struct Message: Codable, Identifiable{
    var id: String
    var content: String
    var name: String
}

class MessagesViewModel: ObservableObject {
    
    @Published var messages = [Message]()
    private let db = Database.database()
    private let user = Auth.auth().currentUser
    private let dbref = Database.database().reference()
    
    func setObserver(docId: String){
        db.reference(withPath: docId).observe(DataEventType.value, with: {(snapshot) in
            if snapshot.exists(){
                let dataSnap: DataSnapshot = snapshot.childSnapshot(forPath: "messages")
                
                var newMessages = [Message]()
                for child in dataSnap.children {
                    let snap: DataSnapshot = (child as? DataSnapshot)!
                    let dict = snap.value as? [String: String]
                    let messageContent = dict?["content"]
                    print("content :: \(messageContent)")
                    let displayName = dict?["displayName"]
                    let message = Message(id: snap.key, content: messageContent ?? "", name: displayName ?? "")
                    newMessages.append(message)
                }
                self.messages = newMessages
                print(self.messages)
            }
        })
    }
    
    func sendMessage(messageContent: String, docId: String){
        if user != nil {
            let formatter = DateFormatter()
            let date: String = formatter.string(from: Date())
            dbref.child(docId).child("messages").childByAutoId().setValue([
                "content": messageContent,
                "displayName": user?.email as Any,
                "sentAt": date,
                "sender": user?.uid as Any,
                "chatID": docId
            ])
        }
    }
    
}
