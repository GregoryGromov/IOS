//
//  AddSetView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 20.12.2023.
//

import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color("ColorGray3"))
                    //.frame(width: 150, height: 40)
            )
            
    
    }
}

struct AddSetView: View {
    
    @EnvironmentObject var viewModel: TrainingDataManager
    
    @Environment(\.dismiss) var dismiss
    
    @State private var weight = ""
    @State private var amount = ""
    
    @State private var thisExerciseSets: [Set]?
    
    init(selectedExercise: Exercise) {
        self.selectedExercise = selectedExercise
    }
    
    var selectedExercise: Exercise
    
    var body: some View {
        VStack {
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.white)
                }
                
                Spacer()
                Text(selectedExercise.name)
                    .offset(x: -10)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                
                
                
            }
            .padding()
            Spacer()
            
            VStack {
                if let thisExerciseSets = thisExerciseSets {
                    ForEach(thisExerciseSets) { setItem in
                        SetItemView(setItem: setItem)
                            .padding(.vertical, 3)
                            .padding(.horizontal, 18)
                    }
                } else {
                    Text("Не вошли в иф")
                }
                
            }
            .onAppear {
                //без этого почему-то при поялвении не инициализируется thisExerciseSets
                computeThisExerciseSets()
            }
            
            
            HStack {
                TextField("", text: $weight)
                    .textFieldStyle(OvalTextFieldStyle())
                    .foregroundColor(.black)
                    .frame(width: 160, height: 40)
                    .padding(.horizontal, 15)


                TextField("", text: $amount)
                    .textFieldStyle(OvalTextFieldStyle())
                    .foregroundColor(.black)
                    .frame(width: 160, height: 40)
                    .padding(.horizontal, 15)
//                    .overlay {
//                        if weight.isEmpty {
//                            Text("Weight")
//                                .fontWeight(.bold)
//                        }
//                    }
            }
                    .padding(.top, 30)
                Button {
                    let newSet = Set(id: UUID().uuidString, weight: Float(weight) ?? 0, amount: Int(amount) ?? 0)
                    viewModel.addSetToExercise(exerciseId: selectedExercise.id, setItem: newSet)
                    computeThisExerciseSets()
                    weight = ""
                    amount = ""
                    
                } label: {
                    Text("Add set")
                        .frame(height: 30)
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous).fill(.black)
                        )
                        .padding()
                }
            Spacer()
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

