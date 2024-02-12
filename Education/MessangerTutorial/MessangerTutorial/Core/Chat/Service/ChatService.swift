//
//  ChatService.swift
//  MessangerTutorial
//
//  Created by Григорий Громов on 06.02.2024.
//

import SwiftUI
import Firebase

struct ChatService {
    
    let chatPartner: User
    
    func sendMessage(_ messageText: String) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let currentUserRef = FirestoreConstants.MessagesCollection.document(currentUid).collection(chatPartnerId).document()
        let chatPartnerRef = FirestoreConstants.MessagesCollection.document(chatPartnerId).collection(currentUid)
        
        let recentCurrentUserRef = FirestoreConstants.MessagesCollection.document(currentUid).collection("recent-messages").document(chatPartnerId)
        let recentPartnerRef = FirestoreConstants.MessagesCollection.document(chatPartnerId).collection("recent-messages").document(currentUid)
        
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
        
        recentCurrentUserRef.setData(messageData)
        recentPartnerRef.setData(messageData)
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
    
    func observeMessages(completion: @escaping([Message]) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let query = FirestoreConstants.MessagesCollection
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
