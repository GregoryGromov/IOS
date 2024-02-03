//
//  AddCustomExerciseView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 22.12.2023.
//

import SwiftUI

struct AddCustomExerciseView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: SelectMuscleGroupViewModel
    
    @State private var name = ""
    @State private var muscleGroup = ""
    
    var body: some View {
        VStack {
            TextField("Enter name", text: $name)
            TextField("Enter muscleGroup", text: $muscleGroup)
            
            Button {
                var muscleGroupArray: [String] = []
                muscleGroupArray.append("Your")
                muscleGroupArray.append(muscleGroup)
                let newExerciseItem = ExerciseItem(name: name, muscleGroup: muscleGroupArray, isBodyweight: false)
                AppStorageDataManager.shared.saveCustomExerciseItem(exerciseItem: newExerciseItem)
                viewModel.reloadExercises()
                dismiss()
                
            } label: {
                Text("Save custom exercise")
            }
        }
    }
}

#Preview {
    AddCustomExerciseView()
}
