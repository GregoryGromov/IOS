//
//  ChatBubble.swift
//  MessangerTutorial
//
//  Created by Григорий Громов on 05.02.2024.
//



import SwiftUI

struct ChatBubble: Shape {
    
    let isFromCurrentUser: Bool
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: [
                                    .topLeft,
                                    .topRight,
                                    isFromCurrentUser ? .bottomLeft : .bottomRight
                                ],
                                cornerRadii: CGSize(width: 16, height: 16))
//                                cornerRadii: CGSize(width: 16, height: 0))


                                return Path(path.cgPath)
    }
    
}


