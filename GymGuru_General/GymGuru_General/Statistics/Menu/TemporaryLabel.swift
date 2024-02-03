//
//  TemporaryLabel.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 30.01.2024.
//

import SwiftUI

struct TemporaryLabel: View {
    
    let title: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color("ColorGray"))
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .foregroundStyle(.white)
                        .font(.title2)
                        .bold()
                }
            }
            .padding()
        }
        .frame(height: 90)
        .padding(.horizontal)
    }
}


