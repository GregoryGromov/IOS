//
//  NewMessageView.swift
//  MessangerTutorial
//
//  Created by Григорий Громов on 04.02.2024.
//

import SwiftUI

struct NewMessageView: View {
    
    @State var searchText = ""
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = NewMessageViewModel()
    
    @Binding var selectedUser: User?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                TextField("To: ", text: $searchText)
                    .frame(height: 44)
                    .padding(.leading)
                    .background(Color(.systemGroupedBackground))
                
                Text("CONTACTS")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                ForEach (viewModel.users) { user in
                    VStack {
                        HStack {
                            CircularProfileImageView(user: user, size: .small )
                            
                            Text(user.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            Spacer()
                        }
                        .padding(.leading)
                        
                        Divider()
                            .padding(.leading, 40)
                    }
                    .onTapGesture {
                        selectedUser = user
                        dismiss()
                    }
                }
            }
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}
 
