//
//  LoginViewModel.swift
//  MessangerTutorial
//
//  Created by Григорий Громов on 05.02.2024.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
