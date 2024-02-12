//
//  SetItemView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 19.12.2023.
//

import SwiftUI

struct SetItemView: View {
    
    var setItem: Set
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color(red: 0.28, green: 0.28, blue: 0.28))
                    .frame(width: 150, height: 40)
                Text(String(setItem.weight))
                    .foregroundColor(.white)
                    .font(.headline)
                    .fontWeight(.bold)
                
            }
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color(red: 0.28, green: 0.28, blue: 0.28))
                    .frame(width: 150, height: 40)
                Text(String(setItem.amount))
                    .foregroundColor(.white)
                    .font(.headline)
                    .fontWeight(.bold)
                
            }
        }
    }
}






//        HStack {
//            Text(String(setItem.weight ?? 50))
//                .foregroundColor(.white)
//                .font(.headline)
//                .fontWeight(.bold)
//                .background(
//                    RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color(red: 0.28, green: 0.28, blue: 0.28))
//                        .frame(width: 150, height: 40)
//                )
//            Spacer()
//            Text(String(setItem.amount))
//                .foregroundColor(.white)
//                .font(.headline)
//                .fontWeight(.bold)
//                .background(
//                    RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color(red: 0.28, green: 0.28, blue: 0.28))
//                        .frame(width: 150, height: 40)
//                )
//        }
