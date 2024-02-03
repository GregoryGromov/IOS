//
//  AddExerciseView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 20.12.2023.
//


import SwiftUI

struct SelectMuscleGroupView: View {
        
    @EnvironmentObject var dataManager: TrainingDataManager
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = SelectMuscleGroupViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
//                        Image(systemName: "chevron.left.circle.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    Text("Muscle group")
                        .offset(x: -10)
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    
                    
                    
                }
                .padding()
                
                ScrollView {
                    
                    ForEach(ExercisesManager.shared.muscleGroups, id: \.self) { muscleGroup in
                        NavigationLink {
                            if muscleGroup == "Your" {
                                UsersExercisesView(muscleGroup: muscleGroup)
                                    .environmentObject(viewModel)
                            } else {
                                SelectExercisesView(muscleGroup: muscleGroup)
                                    .environmentObject(viewModel)
                            }
                            
                            
                        } label: {
                            VStack {
                                HStack {
                                    Text(muscleGroup)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.title)
                                }
                                //.background(muscleGroup == "Your" ? Color("ColorGray2"): nil)
                                .padding()
//                                .padding(.horizontal, 30)
                                
                                Divider()
                            }
                            
                            
                        }
                    }
                    .padding(.top, 30)
                }
                
                
//                Spacer()
                

                Button {
                    addSelectedExercisesToTraining()
                } label: {
                    Text("Add \(viewModel.amountOfSelectedExercises) exercises to training")
                        .foregroundStyle(.black)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(Color(red: 0, green: 0.92, blue: 0))
                            
                        )
                }
            }
        }
    }
    
    private func addSelectedExercisesToTraining() {
        let selectedExercises = viewModel.returnSelectedExercises()
        dataManager.addSelectedExerciseToTraining(exercises: selectedExercises)
        dismiss()
    }
}


