//
//  RegistrationViewModel.swift
//  MessangerTutorial
//
//  Created by Григорий Громов on 05.02.2024.
//

import SwiftUI


class RegistrationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var fullname = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(withEmail: email, password: password, fullname: fullname)
    }
}
