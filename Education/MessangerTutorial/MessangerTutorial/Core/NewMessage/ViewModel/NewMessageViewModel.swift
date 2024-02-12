//
//  NewMessageViewModel.swift
//  MessangerTutorial
//
//  Created by Григорий Громов on 06.02.2024.
//

import Foundation
import Firebase

class NewMessageViewModel: ObservableObject {
    
    @Published var users = [User]()    
    init() {
        Task { try await fetchUsers() }
       
    }
    
    @MainActor
    func fetchUsers() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let users = try await UserService.fetchAllUsers()
        self.users = users.filter({ $0.uid != currentUid })
    }
}
