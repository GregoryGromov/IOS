//
//  TrainingView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 19.12.2023.
//

import SwiftUI

struct TrainingView: View {
    
    @StateObject var viewModel: TrainingViewModel
    
    init(router: RouterViewModel) {
        self._viewModel = StateObject(wrappedValue: TrainingViewModel(router: router))
    }
    
    
    
    var body: some View {
        NavigationStack {
            ControlWidgetView()
                .environmentObject(viewModel)
            


            
            //Кнопка добавления упражнения
            AddExerciseButton()
                .padding(.top, 3)
                .padding(.bottom, 7)
                .environmentObject(viewModel)
            
            
            ScrollView {
                VStack {
                    
                    //List {
                        ForEach(viewModel.currentTraining.exercises) { exercise in
                            VStack{
                                HStack {
                                    Text(exercise.name)
                                        .padding(.horizontal, 35)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                    Spacer()
                                    
                                    GreenCircles(amount: exercise.sets.count)
                                    
                                    HStack {
                                        Button {
                                            viewModel.toggleFold(exerciseId: exercise.id)
                                        } label: {
                                            if exercise.isFolded {
                                                Image(systemName: "chevron.down")
                                                    .font(.title3)
                                                    .padding(.horizontal)
                                                    .foregroundColor(.white)
                                            } else {
                                                Image(systemName: "chevron.up")
                                                    .font(.title3)
                                                    .padding(.horizontal)
                                                    .foregroundColor(.white)
                                            }
                                        }
                                    }
                                    
                                }
                                if !exercise.isFolded {
                                    VStack {
                                        
                                        ForEach(exercise.sets) { setItem in
                                            HStack {
                                                if exercise.isBodyweight {
                                                    SetItemBWView(setItem: setItem)
                                                        .padding(.vertical, 4)
                                                        .padding(.horizontal, 20)
                                                } else {
                                                    SetItemView(setItem: setItem)
                                                        .padding(.vertical, 4)
                                                        .padding(.horizontal, 20)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .onTapGesture {
                                viewModel.selectedExercie = exercise
                                viewModel.showAddSetView.toggle()
                            }
                        }
                    
                        
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color(red: 0.13, green: 0.13, blue: 0.13))
                                .padding(.horizontal, 19)
                            
                        )
                        
                    //}
                    //Spacer()
                        
                }
                .sheet(isPresented: $viewModel.showAddExerciseView) {
//                    SelectMuscleGroupView()
//                        .environmentObject(viewModel)
                    Text("Выберите группу мышц")
                }
            }
            .sheet(isPresented: $viewModel.showAddSetView, content: {
                if let selectedExercie = viewModel.selectedExercie {
                    if selectedExercie.isBodyweight {
                        AddSetBWView(selectedExercise: selectedExercie)
                            .environmentObject(viewModel)
                    } else {
                        AddSetView(selectedExercise: selectedExercie)
                            .environmentObject(viewModel)
                            
                    }
                    
                } else {
                    Text("Ошибка 1")
                }
            })
        }
    }
    
//    func delete(at offsets: IndexSet) {
//        viewModel.currentTraining.exercises.remove(atOffsets: offsets)
//    }
}


