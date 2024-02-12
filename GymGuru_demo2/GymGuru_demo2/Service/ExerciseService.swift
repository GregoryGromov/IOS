//
//  ExerciseService.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 09.02.2024.
//

import Foundation

class ExerciseService {
    
    static let shared = ExerciseService()
    
    let userExercisesKey = "UsersExercises"
    
    let defaults = UserDefaults.standard
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    
    //Добавление собственного упражнения
    func saveCustomExercise(exercise: ExerciseItem) {
        var existingExercises = fetchCustomExercises()
        existingExercises.append(exercise)
        saveExerciseToUD(exercises: existingExercises)
    }
    
    
    //Получение собственных упражнений
    func fetchCustomExercises() -> [ExerciseItem] {
        var usersExercises: [ExerciseItem] = []
        
        if let encodedExercise = defaults.object(forKey: userExercisesKey) as? Data {
            if let decodedExercise = try? decoder.decode([ExerciseItem].self, from: encodedExercise) {
                for exercise in decodedExercise {
                    usersExercises.append(exercise)
                }
            }
        }
        return usersExercises
    }
    
    
    //Сохранение массива [ExerciseItem] в UserDefaults
    private func saveExerciseToUD(exercises: [ExerciseItem]) {
        if let encoded = try? encoder.encode(exercises) {
            defaults.set(encoded, forKey: userExercisesKey)
        }
    }
    
    //Удаление всех пользовательсктх упражнений из UserDefaults
    func deleteAllExerciseFromAppStorage() {
        let existingExerciseItems: [Exercise] = []
        if let encoded = try? encoder.encode(existingExerciseItems) {
            defaults.set(encoded, forKey: userExercisesKey)
        }
    }
}
