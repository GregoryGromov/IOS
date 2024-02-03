//
//  ExercisesManager.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 15.01.2024.
//

import Foundation

class ExercisesManager {
    
    init() {
        reloadExercises()
    }
    
    static let shared = ExercisesManager()
    
    var exercisesItems: [ExerciseItem] = []
    
    let buildInExercisesItems = [
        ExerciseItem(name: "Подгягивание", muscleGroup: ["Arms", "Back"], isBodyweight: true, isSelected: false),
        ExerciseItem(name: "Жим лежа", muscleGroup: ["Chest", "Shoulders"], isBodyweight: false, isSelected: false),
        ExerciseItem(name: "Скручивание", muscleGroup: ["ABS"], isBodyweight: true, isSelected: false),
        ExerciseItem(name: "Тяга блока сидя", muscleGroup: ["Back"], isBodyweight: false, isSelected: false),
        ExerciseItem(name: "Тяга блока стоя", muscleGroup: ["Back"], isBodyweight: false, isSelected: false),
        ExerciseItem(name: "Присед", muscleGroup: ["Legs"], isBodyweight: false, isSelected: false),
        ExerciseItem(name: "Выход силой", muscleGroup: ["Arms", "Arms"], isBodyweight: true, isSelected: false),
    ]
    
    let muscleGroups = ["Arms", "Chest", "ABS", "Shoulders", "Legs", "Back", "Your"]
    
    func fetchUsersExercisesFromAppStorage() {
        let usersExerciseItems = AppStorageDataManager.shared.returnCustomExercises()
        for exerciseItem in usersExerciseItems {
            exercisesItems.append(exerciseItem)
        }
    }
    
    func reloadExercises() {
        self.exercisesItems = []
        self.exercisesItems = buildInExercisesItems
        fetchUsersExercisesFromAppStorage()
    }
    
    func fetchExerciseItems() -> [ExerciseItem] {
        return self.exercisesItems
    }
}
