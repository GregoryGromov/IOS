//
//  AddSetBWView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 20.01.2024.
//

import SwiftUI

struct AddSetBWView: View {
    
    @EnvironmentObject var viewModel: TrainingViewModel
    
    @State private var amount = ""
    
    @State private var thisExerciseSets: [Set]?
    
    //let weightOfUser = UserService.shared.getUserInfoFloat(key: "userWeight")
    
    init(selectedExercise: Exercise) {
        self.selectedExercise = selectedExercise
    }
    
    var selectedExercise: Exercise
    
    var body: some View {
        VStack {
            VStack {
                if let thisExerciseSets = thisExerciseSets {
                    ForEach(thisExerciseSets) { setItem in
                        SetItemBWView(setItem: setItem)
                            
                            .padding()
                            .padding(.horizontal, 7)
                    }
                } else {
                    Text("Не вошли в иф")
                }
                
            }
            .onAppear {
                //без этого почему-то при поялвении не инициализируется thisExerciseSets
                computeThisExerciseSets()
            }
            
            
            Text("\(selectedExercise.sets.count)")
            HStack {
                
                TextField("Amount", text: $amount)
            }
            Button {
                let newSet = Set(id: UUID().uuidString, weight: 228, amount: Int(amount) ?? 0)
                viewModel.addSetToExercise(exerciseId: selectedExercise.id, setItem: newSet)
                computeThisExerciseSets()
            } label: {
                Text("Add set")
            }
        }
    }
    
    private func computeThisExerciseSets() {
        for i in 0...(viewModel.currentTraining.exercises.count - 1) {
            if viewModel.currentTraining.exercises[i].id == selectedExercise.id {
                self.thisExerciseSets = viewModel.currentTraining.exercises[i].sets
            }
        }
    }
}

