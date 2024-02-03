//
//  SelectMuscleGroupViewModel.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 21.12.2023.
//

import Foundation

class SelectMuscleGroupViewModel: ObservableObject {
    
    var exercisesManager = ExercisesManager()
    
    init() {
        self.exercisesItems = exercisesManager.fetchExerciseItems()
    }
    
    @Published var exercisesItems: [ExerciseItem] = []

    var amountOfSelectedExercises: Int {
        return exercisesItems.filter({$0.isSelected}).count
    }
    
    func returnSelectedExercises() -> [Exercise] {
        let selectedExerciseItems = returnSelectedExerciseItems()
        let selectedExercises = convertExerciseItemsToExercises(exerciseItems: selectedExerciseItems)
        return selectedExercises
    }
    
    func switchIsSelected(exercise: ExerciseItem) {
        for i in 0...(exercisesItems.count - 1) {
            if exercisesItems[i].name == exercise.name {
                exercisesItems[i].isSelected.toggle()
            }
        }
    }
     
    
    private func returnSelectedExerciseItems() -> [ExerciseItem] {
        var selectedExercises: [ExerciseItem] = []
        
        for i in 0...(exercisesItems.count - 1) {
            if exercisesItems[i].isSelected {
                selectedExercises.append(exercisesItems[i])
            }
        }
        return selectedExercises
    }
    
    private func convertExerciseItemsToExercises(exerciseItems: [ExerciseItem]) -> [Exercise] {
        var exercises: [Exercise] = []
        for exerciseItem in exerciseItems {
            let exercise = Exercise(
                id: UUID().uuidString,
                name: exerciseItem.name,
                muscleGroup: exerciseItem.muscleGroup,
                isBodyweight: exerciseItem.isBodyweight,
                sets: [])
            exercises.append(exercise)
        }
        return exercises
    }
    
    func reloadExercises() {
        exercisesManager.reloadExercises()
        self.exercisesItems = exercisesManager.fetchExerciseItems()
    }
}














//    @Published var exercisesItemsMOCK = [
//        ExerciseItem(name: "Подгягивание", muscleGroup: ["Arms", "Back"], isSelected: false),
//        ExerciseItem(name: "Жим лежа", muscleGroup: ["Chest", "Shoulders"], isSelected: false),
//        ExerciseItem(name: "Скручивание", muscleGroup: ["ABS"], isSelected: false),
//        ExerciseItem(name: "Тяга блока сидя", muscleGroup: ["Back"], isSelected: false),
//        ExerciseItem(name: "Тяга блока стоя", muscleGroup: ["Back"], isSelected: false),
//        ExerciseItem(name: "Присед", muscleGroup: ["Legs"], isSelected: false),
//        ExerciseItem(name: "Выход силой", muscleGroup: ["Arms", "Arms"], isSelected: false),
//    ]
