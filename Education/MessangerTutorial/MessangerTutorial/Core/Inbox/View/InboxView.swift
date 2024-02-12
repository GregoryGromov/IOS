//
//  InboxView.swift
//  MessangerTutorial
//
//  Created by Григорий Громов on 04.02.2024.
//

import SwiftUI

struct InboxView: View {
    
    @State var showNewMessageView = false
    @State var showChat = false
    
    
    @State var selectedUser: User?
    
    @StateObject var viewModel = InboxViewModel()
    
    
    
    var body: some View {
        NavigationStack {
            List {
               
                ActiveNowView()
                    .listRowSeparator(.hidden)
                    .listRowInsets (EdgeInsets ())
                    .padding (.vertical)
               
                    ForEach(viewModel.recentMessages) { message in
                        ZStack {
                            NavigationLink(value: message) {
                                EmptyView()
                            }.opacity(0.0)
                            
                            InboxRowView(message: message)
                        }
                    }
            }
            .listStyle(PlainListStyle())
            .onChange(of: selectedUser, perform: { newValue in
                showChat = newValue != nil
            })
            .navigationDestination(for: Message.self, destination: { message in
                if let user = message.user {
                    ChatView(user: user)
                }
            })
            .navigationDestination(for: Route.self, destination: { route in
                switch route {
                case .profile(let user):
                    ProfileView(user: user)
                case .chatView(let user):
                    ChatView(user: user)
                }
                
            })
            .navigationDestination(isPresented: $showChat, destination: {
                if let user = selectedUser {
                    ChatView(user: user)
                }
            })
            .fullScreenCover(isPresented: $showNewMessageView, content: {
                NewMessageView(selectedUser: $selectedUser)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if let user = viewModel.currentUser {
                        NavigationLink(value: Route.profile(user)) {
                            HStack {
                                CircularProfileImageView(user: viewModel.currentUser, size: .xSmall)
                                Text("Chats")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                            }
                        }
                    }
  
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNewMessageView.toggle()
                        selectedUser = nil
                    } label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.black, Color(.systemGray5))
                    }
                }
            }
        }
    }
}

#Preview {
    InboxView()
}
