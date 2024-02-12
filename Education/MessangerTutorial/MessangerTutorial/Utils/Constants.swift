//
//  Constants.swift
//  MessangerTutorial
//
//  Created by Григорий Громов on 06.02.2024.
//

import Foundation
import Firebase

struct FirestoreConstants {
    static let UserCollection = Firestore.firestore().collection("users")
    static let MessagesCollection = Firestore.firestore().collection("messages")
}
