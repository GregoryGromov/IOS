//
//  UserService.swift
//  MessangerTutorial
//
//  Created by Григорий Громов on 05.02.2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class UserService {
    
    @Published var currenUser: User?
    
    static let shared = UserService()
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currenUser = user
    }
    
    static func fetchAllUsers(limit: Int? = nil) async throws -> [User] {
        let query = FirestoreConstants.UserCollection
        if let limit {
            query.limit(to: limit)
        }
        
        let snapshot = try await query.getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self)})
    }
    
    //мы вынуждены использовать completion handler вместо async throws, потому что данныя функция будет сипользоваться в другой функции, использующе completion handler, а смешивть два подхода в одной нельзя
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        FirestoreConstants.UserCollection.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            completion(user)
        }
    }
    
    
}
