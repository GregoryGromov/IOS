//
//  TrainingView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 19.12.2023.
//

import SwiftUI

struct TrainingView: View {
    
    @EnvironmentObject var trainingRouter: TrainingRouter
    @StateObject var viewModel: TrainingDataManager
    
    init(currentTraining: Training) {
        self._viewModel = StateObject(wrappedValue: .init(currentTraining: currentTraining, program: nil))
    }
    
    var body: some View {
        NavigationStack {
            //Главный виджет управления тренировкой
            ControlWidgetView()
                .environmentObject(viewModel)
                .environmentObject(trainingRouter)
                .padding()
//                .padding(.bottom, 0)
//                .padding(.top, 0)
            
            //Кнопка добавления упражнения
            AddExerciseButton()
                .environmentObject(viewModel)
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
                                        
//                                        Button {
//                                            viewModel.deleteExercise(exerciseId: exercise.id)
//                                        } label: {
//                                            Image(systemName: "trash.fill")
//                                                .font(.title)
//                                                .foregroundColor(.red)
//                                        }
                                        
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
                                                
//                                                Button {
//                                                    viewModel.deleteSet(exerciseId: exercise.id, setId: setItem.id)
//                                                } label: {
//                                                    Image(systemName: "trash.fill")
//                                                        .foregroundStyle(.red)
//                                                }
//                                                .padding()
                                            }
                                            
                                        }
                                        
//                                        Button {
//                                         
//                                                viewModel.selectedExercie = exercise
//                                                viewModel.showAddSetView.toggle()
//                                            
//                                            
//                                        } label: {
//                                            Text("Add set")
//                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            .onTapGesture {
                                viewModel.selectedExercie = exercise
                                viewModel.showAddSetView.toggle()
                            }
                        }
                        //.onDelete(perform: delete)
                        
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color(red: 0.13, green: 0.13, blue: 0.13))
                                .padding(.horizontal, 19)
                            
                        )
                        
                    //}
                    //Spacer()
                        
                }
                .sheet(isPresented: $viewModel.showAddExerciseView) {
                    SelectMuscleGroupView()
                        .environmentObject(viewModel)
                    
                    
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


