//
//  UsersExercisesView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 22.12.2023.
//

import SwiftUI

struct UsersExercisesView: View {
    @EnvironmentObject var viewModel: SelectMuscleGroupViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var showAddCustomExerciseView = false
    
    let muscleGroup: String
    
    var body: some View {
        VStack {
            ForEach(viewModel.exercisesItems.filter({ $0.muscleGroup.contains(muscleGroup)}), id: \.self)  { exercise in
                VStack{
                    HStack {
                        Text(exercise.name)
                            .padding()
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                        if exercise.isSelected == true {
                            ZStack {
                                Image(systemName: "checkmark.circle")
                                    .font(.title)
                                    .foregroundColor(Color(red: 0, green: 0.92, blue: 0))
                            }
                            
                        } else {
                            Image(systemName: "circle")
                                .font(.title)
                                .foregroundColor(Color(red: 0, green: 0.92, blue: 0))

                        }
                        
                    }
                    .onTapGesture {
                        viewModel.switchIsSelected(exercise: exercise)
                    }
                    .padding()
                    Divider()
                }
            }
            Button {
                showAddCustomExerciseView.toggle()
            } label: {
                Text("Добавить своё")
                    .foregroundStyle(.black)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color(red: 0, green: 0.92, blue: 0))
                        
                    )
            }
        }
        .sheet(isPresented: $showAddCustomExerciseView) {
            AddCustomExerciseView()
                .environmentObject(viewModel)
        }
    }
}


