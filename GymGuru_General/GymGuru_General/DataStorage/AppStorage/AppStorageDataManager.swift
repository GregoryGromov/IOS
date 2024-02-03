//
//  AppStorageDataManager.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 22.12.2023.
//

import Foundation
import SwiftUI


class AppStorageDataManager {
    
    static let shared = AppStorageDataManager()
    
    let defaults = UserDefaults.standard
    
    
    func setTrainingInProgressToTrue() {
        defaults.set(true, forKey: "CurrentTrainingState")
    }
    
    func setTrainingInProgressToFalse() {
        defaults.set(false, forKey: "CurrentTrainingState")
    }
    
    func saveTrainingToAppStorage(training: Training) {
        print("ASM: запушена функция сохранения тренировки")
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(training) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "CurrentTraining")
            print("ASM: тренировка успешно сохранена")
            
        }
    }
    
    func fetchTrainingFromAppStorage() -> Training? {
        print("ASM: запушена функция получения тренировки")
        let defaults = UserDefaults.standard
        if let encodedTraining = defaults.object(forKey: "CurrentTraining") as? Data {
            let decoder = JSONDecoder()
            if let decodedTraining = try? decoder.decode(Training.self, from: encodedTraining) {
                print("ASM: тренировка успешно получена и декодированна")
                return decodedTraining
            }
        }
        return nil
    }
    
    func saveCustomExerciseItem(exerciseItem: ExerciseItem) {
        var existingExercises = returnCustomExercises()
        existingExercises.append(exerciseItem)
        saveExerciseItemsToAppStorage(exerciseItems: existingExercises)
    }
    
    func returnCustomExercises() -> [ExerciseItem] {
        
        var usersExercises: [ExerciseItem] = []
        
        let defaults = UserDefaults.standard
        if let encodedExercise = defaults.object(forKey: "UsersExercises") as? Data {
            let decoder = JSONDecoder()
            if let decodedExercise = try? decoder.decode([ExerciseItem].self, from: encodedExercise) {
                for exercise in decodedExercise {
                    usersExercises.append(exercise)
                }
            }
        }
        return usersExercises
    }
    
    private func saveExerciseItemsToAppStorage(exerciseItems: [ExerciseItem]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(exerciseItems) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "UsersExercises")
        }
        
        
        
    }
    
    func deleteAllExerciseFromAppStorage() {
        let encoder = JSONEncoder()
        let existingExerciseItems: [ExerciseItem] = []
        
        if let encoded = try? encoder.encode(existingExerciseItems) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "UsersExercises")
        }
    }
    
    func setUserInfo<T>(key: String, data: T) {
        defaults.set(data, forKey: key)
    }
    
    func getUserInfoString(key: String) -> String? {
        if let value = defaults.string(forKey: key) {
            return value
        } else {
            return nil
        }
    }

    func getUserInfoFloat(key: String) -> Float {
        return defaults.float(forKey: key)
    }
}






//    let testExercise = ExerciseItem(name: "TestExs", muscleGroup: ["Your"])
//    func saveExercise() {
//        let encoder = JSONEncoder()
//        var existingExerciseItems: [ExerciseItem] = []
//        existingExerciseItems.append(testExercise)
//
//        if let encoded = try? encoder.encode(existingExerciseItems) {
//            let defaults = UserDefaults.standard
//            defaults.set(encoded, forKey: "UsersExercises")
//        }
//    }
