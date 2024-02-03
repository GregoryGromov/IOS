//
//  EditWeightView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 30.01.2024.
//

import SwiftUI

struct EditWeightView: View {
    
    @EnvironmentObject var viewModel: ProfileViewModel
    
    var body: some View {
        ZStack {
            Color("ColorGray2")
                .ignoresSafeArea()
            HStack {
                Button {
                    viewModel.userWeight -= 0.1
                } label: {
                    Image(systemName: "minus.circle")
                }
                
                Text("\(String(format: "%.1f", viewModel.userWeight)) kg")
                    .frame(width: 130)
                
                Button {
                    viewModel.userWeight += 0.1
                } label: {
                    Image(systemName: "plus.circle")
                }
                
            }
        }
        
        
    }
}

#Preview {
    EditWeightView()
}
