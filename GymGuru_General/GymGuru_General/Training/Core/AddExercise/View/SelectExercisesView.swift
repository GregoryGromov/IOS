//
//  SelectExercisesView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 21.12.2023.
//

import SwiftUI

struct SelectExercisesView: View {
    
    @EnvironmentObject var viewModel: SelectMuscleGroupViewModel
    @Environment(\.dismiss) var dismiss
    
    let muscleGroup: String
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
//                    Image(systemName: "xmark.circle.fill")
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.title)
                        .foregroundColor(.white)
                }
                
                Spacer()
                Text(muscleGroup)
                    .offset(x: -10)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                
                
                
            }
            .padding()
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
            Spacer()
            Button {
                dismiss()
            } label: {
                Text("Выбрать")
                    .foregroundStyle(.black)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color(red: 0, green: 0.92, blue: 0))
                        
                    )
            }
        }
            .navigationBarTitle("Select exercise")
            .navigationBarHidden(true)
    }
}
