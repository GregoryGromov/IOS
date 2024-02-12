//
//  InboxRowView.swift
//  MessangerTutorial
//
//  Created by Григорий Громов on 04.02.2024.
//

import SwiftUI

struct InboxRowView: View {
    
    let message: Message
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            CircularProfileImageView(user: message.user, size: .large)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(message.user?.fullname ?? "Anonymous")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(message.messageText)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }
            
            HStack {
                Text(message.timestampString)
                Image(systemName: "chevron.right")
            }
            .font(.footnote)
            .foregroundColor(.gray)
            
        }
        .frame(height: 72)
    }
}

