//
//  ChatViewModel.swift
//  MessangerTutorial
//
//  Created by Григорий Громов on 06.02.2024.
//

import Foundation

class ChatViewModel: ObservableObject {
    
    @Published var messageText = ""
    @Published var messages = [Message]()
    
    let service: ChatService
    
    init(user: User) {
        self.service = ChatService(chatPartner: user)
        observeMessages()
    }
    
    func observeMessages() {
        service.observeMessages() { messages in
            self.messages.append(contentsOf: messages)

        }
    }
    
    func sendMessage() {
        service.sendMessage(messageText)
    }
}
