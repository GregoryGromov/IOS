//
//  GreenCircles.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 19.12.2023.
//

import SwiftUI

struct GreenCircles: View {
    
    var amount: Int
    
    var body: some View {
        if amount < 5 && amount != 0 {
            ForEach(0...(amount - 1), id: \.self) { _ in
                Rectangle()
                .foregroundColor(.clear)
                .frame(width: 12, height: 12)
                .background(Color(red: 0, green: 0.92, blue: 0))
                .cornerRadius(10)
            }
        } else if amount != 0 {
            Text("\(amount)")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0, green: 0.92, blue: 0))
        }
    }
}

