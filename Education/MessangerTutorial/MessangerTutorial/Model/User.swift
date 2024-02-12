//
//  User.swift
//  MessangerTutorial
//
//  Created by Григорий Громов on 05.02.2024.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable, Hashable {
    @DocumentID var uid: String?
    let fullname: String
    let email: String
    var profileImageUrl: String?
    
    var id: String {
        return uid ?? NSUUID().uuidString
    }
    
//    var firstName: String {
//        return fullname.components(separatedBy: " ")[0]
//    }
    
    var firstName: String {
        let formatter = PersonNameComponentsFormatter()
        let components = formatter.personNameComponents(from: fullname)
        return components?.givenName ?? fullname
    }
}

extension User {
    static let MOCK_USER = User(fullname: "Vania Face", email: "inlovewithro@outlook.com", profileImageUrl: "face")
}
