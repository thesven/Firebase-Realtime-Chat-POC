//
//  ChatroomsViewModel.swift
//  RealTimeChat-Firebase
//
//  Created by Michael Svendsen on 2021-02-23.
//

import Foundation
import Firebase

struct Chatroom: Codable, Identifiable {
    var id: String
    var title: String
    var joinCode: Int
}

class ChatroomsViewModel: ObservableObject {
    
    @Published var chatrooms = [Chatroom]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    func fetchData() {
        if(user != nil){
            db.collection("chatrooms").whereField("users", arrayContains: user!.uid).addSnapshotListener({(snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("No Documents Returned")
                    return
                }
                
                // TODO change this into a function
                self.chatrooms = documents.map({docSnapshot -> Chatroom in
                    let data = docSnapshot.data()
                    let docId = docSnapshot.documentID
                    let title = data["title"] as? String ?? ""
                    let joinCode = data["joinCode"] as? Int ?? -1
                    return Chatroom(id: docId, title: title, joinCode: joinCode)
                })
                
            })
        }
    }
    
    func createChatroom(title: String, handler: @escaping () -> Void){
        if(user != nil){
            db.collection("chatrooms").addDocument(data: ["title": title,
                                                          "joinCode": Int.random(in: 10000..<99999),
                                                          "users": [user!.uid]]) {err in
                if let err = err{
                    print("error addig document! \(err)")
                } else {
                    handler()
                }
            }
        }
    }
    
    func joinChatroom(code: String, handler: @escaping () -> Void){
        if(user != nil){
            db.collection("chatrooms").whereField("joinCode", isEqualTo: Int(code)).getDocuments() { (snapshot, error) in
                if let error = error {
                    print("error getting documents \(error)")
                } else {
                    for document in snapshot!.documents {
                        self.db.collection("chatrooms").document(document.documentID).updateData(["users": FieldValue.arrayUnion([self.user!.uid])])
                        handler()
                    }
                }
            }
        }
    }
    
    public func doSearch(term: String) {
        print("perform search for \(term)")
        //check to see that the user is loged in
        if(user != nil){
            //get all messages from the sender
            Database.database().reference(withPath: "EfMijhHfW1ODz8WkHPKJ/messages").queryOrdered(byChild: "sender").queryEqual(toValue: user?.uid).getData(completion:  { (error, dataSnapshot) in
                guard let snap: DataSnapshot = dataSnapshot as? DataSnapshot else {
                    print("no results for term \(term)")
                    return
                }
                
                //get all of the unique chat IDs
                var postIds = [String]()
                for message in snap.children {
                    let data: DataSnapshot = (message as? DataSnapshot)!
                    let dict = data.value as? [String: String]
                    let chatID: String = (dict?["chatID"] ?? "") as String
                    if !postIds.contains(chatID){
                        postIds.append(chatID)
                    }
                }
                
                //get the individual chats
                self.db.collection("chatrooms").whereField(FieldPath.documentID(), in: postIds).getDocuments(completion: {(snapshot, error) in
                    guard let documents = snapshot?.documents else {
                        print("No Documents Returned")
                        return
                    }
                    
                    // TODO change this into a function
                    self.chatrooms = documents.map({docSnapshot -> Chatroom in
                        let data = docSnapshot.data()
                        let docId = docSnapshot.documentID
                        let title = data["title"] as? String ?? ""
                        let joinCode = data["joinCode"] as? Int ?? -1
                        return Chatroom(id: docId, title: title, joinCode: joinCode)
                    })
                })
                
            })
        }
    }
    
}
