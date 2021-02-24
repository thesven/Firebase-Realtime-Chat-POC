# Firebase-Realtime-Chat-POC

iOS POC using firebase firestore and realtime databases


## Dependencies
- SwiftUI
- Firebase


## To Run:
- clone repo
- cd {repo_directory}
- pod install
- open up the workspace
- run


## Database Structure

### Cloud Firestore
collection:
- chatrooms

chatrooms:
- joinCode: String
- title: String
- users: Array

### Realtime

- chatroom_document_id
  - messages
    - messages (with auto id)
      - content
      - displayName
      - sender
      - sentAt 
