//
//  ContentViewModel.swift
//  MessangerTutorial
//
//  Created by Григорий Громов on 05.02.2024.
//

import Firebase
import Combine

class ContentViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        AuthService.shared.$userSession.sink { [weak self] userSessionFromAuthService in
            self?.userSession = userSessionFromAuthService
        }.store(in: &cancellables)
    }
}
