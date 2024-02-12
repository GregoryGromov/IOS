//
//  InboxViewModel.swift
//  MessangerTutorial
//
//  Created by Григорий Громов on 05.02.2024.
//

import Foundation
import Combine
import Firebase


class InboxViewModel: ObservableObject {
    
    @Published var currentUser: User?
    @Published var recentMessages = [Message]()
    
    
    private var cancellables = Set<AnyCancellable>()
    private let service = InboxService()
    
    init() {
        setupSubscribers()
        service.observeRecentMessages()
    }

    private func setupSubscribers() {
        UserService.shared.$currenUser.sink { [weak self] currentUserFromUserService in
            self?.currentUser = currentUserFromUserService
        }.store(in: &cancellables)
        
        service.$documentChanges.sink { [weak self] changes in
            self?.loadInitialMessages(fromChanges: changes)
        }.store(in: &cancellables)
    }
    
    //преобразует полученные данные в тип данный Message и получает информацию об отправителе 
    private func loadInitialMessages(fromChanges changes: [DocumentChange]) {
        var messages = changes.compactMap({ try? $0.document.data(as: Message.self) })
        
        for i in 0 ..< messages.count {
            let message = messages[i]
            
            //для каждого сообщения загружаем информацию о его отправителе
            UserService.fetchUser(withUid: message.chatPartnerId) { user in
                messages[i].user = user
                 
                //добавил я:
                self.recentMessages.removeAll{$0.user == user}
                self.recentMessages.insert(messages[i], at: 0)
                
//                self.recentMessages.append(messages[i])
            }
        }
    }
    
    
}
