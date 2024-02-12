//
//  MessageService.swift
//  MessangerTutorial
//
//  Created by Григорий Громов on 06.02.2024.
//

import Foundation
import Firebase

struct MessageService {
    
    static let messageCollection = Firestore.firestore().collection("messages")
    
    static func sendMessage(_ messageText: String, toUser user: User) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = user.id
        
        let currentUserRef = messageCollection.document(currentUid).collection(chatPartnerId).document()
        let chatPartnerRef = messageCollection.document(chatPartnerId).collection(currentUid)
        
        let messageId = currentUserRef.documentID
        
        let message = Message(
            messageId: messageId,
            fromId: currentUid,
            toId: chatPartnerId,
            messageText: messageText,
            timestamp: Timestamp()
        )
        
        guard let messageData = try? Firestore.Encoder().encode(message) else { return }
        
        currentUserRef.setData(messageData)
        chatPartnerRef.document(messageId).setData(messageData)
    }
    
//    static func fetchMessages(fromUser user: User) async throws -> [Message] {
//        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
//        let chatPartnerId = user.id
//        
//        let currentUserRef = messageCollection.document(currentUid).collection(chatPartnerId)
//        let snapshot = try await currentUserRef.getDocuments()
//        print(snapshot.documents.compactMap({ try? $0.data(as: Message.self)}))
//        
//        return snapshot.documents.compactMap({ try? $0.data(as: Message.self)})
//    }
    
    static func observeMessages(chatPartner: User, completion: @escaping([Message]) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let query = messageCollection
            .document(currentUid)
            .collection(chatPartnerId)
            .order(by: "timestamp", descending: false)
        
        //в случае добавления: messages будет содержать только это одно добавленное сообщение
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added}) else { return }
            var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
            
            for (index, message) in messages.enumerated() where message.fromId != currentUid {
                messages[index].user = chatPartner
            }
            
            completion(messages)
        }
    }
}
