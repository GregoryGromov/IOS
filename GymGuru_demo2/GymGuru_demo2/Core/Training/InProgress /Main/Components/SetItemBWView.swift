//
//  SetItemBWView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 20.01.2024.
//

import SwiftUI

struct SetItemBWView: View {
    
    var setItem: Set
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color(red: 0.28, green: 0.28, blue: 0.28))
                    .frame(width: 320, height: 40)
                Text(String(setItem.amount))
                    .foregroundColor(.white)
                    .font(.headline)
                    .fontWeight(.bold)
                
            }
        }
    }
}
