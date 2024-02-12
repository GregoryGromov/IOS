//
//  ControlWidgetView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 19.12.2023.
//

import SwiftUI

struct ControlWidgetView: View {
    
    @EnvironmentObject var viewModel: TrainingViewModel
    
    @State var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    @State var trainingDuration = 0
    @State var formattedDuration = ""
    
    var amountOfExercises: Int {
        return viewModel.currentTraining.exercises.count
    }
    
    var amountOfSets: Int {
        var setCounter = 0
        for exercise in viewModel.currentTraining.exercises {
            setCounter += exercise.sets.count
        }
        return setCounter
    }
    
    var body: some View {
        VStack { 
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("\(amountOfExercises) exercises")
                    Text("\(amountOfSets) sets")
                }
                .foregroundColor(.gray)
                .font(.headline)
                .padding(.bottom, 3)
                
                Spacer()
                Text(formattedDuration)
                    
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .onReceive(self.timer) { time in
                        trainingDuration  += 1
                        formattedDuration = viewModel.secondsToTime(inSeconds: trainingDuration)
                        
                    }
            }
            .padding()
            .padding(.horizontal, 26)
            .padding(.bottom, 0)
            
            
            HStack {
                Spacer()
                Button {
                    viewModel.finishTraining()
                } label: {
                    Text("Завершить")
                        .frame(width: 280, height: 30)
                        .foregroundColor(.black)
                        .font(.title2)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color("ColorGray3"))
                        )
                    
                }
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 20)
        }
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color.white)
        )
        .onAppear {
            //trainingDuration = viewModel.currentTraining.duration
            trainingDuration = viewModel.computeTrainingDuration()
        }
    }
}







//            HStack(alignment: .top) {
//
//                VStack(alignment: .leading) {
//                    Text("2 exercises")
//                    Text("7 sets")
//                }
//                .foregroundColor(.gray)
//                .font(.headline)
//                .padding(.bottom, 3)
//
//                Spacer()
//
//                Text("\(trainingDuration)s")
//                    .font(.title)
//                    .foregroundStyle(.black)
//                    .onReceive(self.timer) { time in
//                        if isTimerRunning {
//                            trainingDuration  += 1
//                        }
//                    }
//
//
//            }
//            .padding()
//            .padding(.horizontal, 26)
//            .padding(.bottom, 0)
//            HStack {
//                Button {
//                    if isTimerRunning {
//                        isTimerRunning = false
//                    } else {
//                        isTimerRunning = true
//                    }
//
//                } label: {
//                    if isTimerRunning {
//                        Text("Stop")
//                            .frame(width: 140, height: 30)
//                            .foregroundColor(.black)
//                            .font(.title2)
//                            .background(Color(red: 0.85, green: 0.85, blue: 0.85))
//                            .cornerRadius(15)
//                    } else {
//                        Text("Continue")
//                            .frame(width: 140, height: 30)
//                            .foregroundColor(.black)
//                            .font(.title2)
//                            .background(Color(red: 0.85, green: 0.85, blue: 0.85))
//                            .cornerRadius(15)
//                    }
//
//                }
//                Spacer()
//                Button {
//                    print("Finish training")
//                    viewModel.setDuration(duration: trainingDuration)
//                    viewModel.finishTraining()
//                    trainingRouter.setTrainingInProgressToFalse()
//                    trainingRouter.detectState()
//                } label: {
//                    Text("Finish")
//                        .frame(width: 140, height: 30)
//                        .foregroundColor(.black)
//                        .font(.title2)
//                        .background(Color(red: 0.85, green: 0.85, blue: 0.85))
//                        .cornerRadius(15)
//                }
//            }
//            .padding(.horizontal, 30)
//            .padding(.bottom, 20)
                
