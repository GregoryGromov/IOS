//
//  AddExerciseButton.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 19.12.2023.
//

import SwiftUI

struct AddExerciseButton: View {
    
    @EnvironmentObject var viewModel: TrainingViewModel
    
    var body: some View {
        Button {
            viewModel.showAddExerciseView.toggle()
        } label: {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 50, height: 50)
                    .background(Color(red: 0, green: 0.92, blue: 0))
                    .cornerRadius(100)
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.black)
            }
        }
    }
}

