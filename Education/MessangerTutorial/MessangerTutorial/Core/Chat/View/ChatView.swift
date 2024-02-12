//
//  ChatView.swift
//  MessangerTutorial
//
//  Created by Григорий Громов on 05.02.2024.
//

import SwiftUI

struct ChatView: View {
    
    @StateObject var viewModel: ChatViewModel
    let user: User
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user))
        self.user = user
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Text("\(viewModel.messages.count) messages")
                    
                    CircularProfileImageView(user: user, size: .xLarge)
                    
                    VStack(spacing: 4) {
                        Text(user.fullname)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Text("Messanger")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                LazyVStack {
                    ForEach(viewModel.messages) { message in
                        CharMessageCell(message: message)
                    }
                }
            }
            Spacer()
            ZStack(alignment: .trailing) {
                TextField("Message...", text: $viewModel.messageText, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 52)
                    .background (Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                    .font(.subheadline)
                
                
                Button {
                    viewModel.sendMessage()
                    viewModel.messageText = ""
                } label: {
                    Text ("Send" )
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                }
                
                
                
            }
            .padding()
        }
        .navigationTitle(user.fullname)
        .navigationBarTitleDisplayMode(.inline)
    }
}

