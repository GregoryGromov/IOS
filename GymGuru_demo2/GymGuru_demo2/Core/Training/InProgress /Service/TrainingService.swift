//
//  AppStorageDataManager.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 22.12.2023.
//

import Foundation
import SwiftUI


class TrainingService {
    
    static let shared = TrainingService()
    
    let trainingStateKey = "CurrentTrainingState"
    let trainingKey = "CurrentTraining"
    
    let defaults = UserDefaults.standard
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func setTrainingInProgressToTrue() {
        defaults.set(true, forKey: trainingStateKey)
    }
    
    func setTrainingInProgressToFalse() {
        defaults.set(false, forKey: trainingStateKey)
    }
    
    func saveTrainingToUD(training: Training) {
        print("DEBUG: зашло в saveTrainingToUD")
        if let encoded = try? encoder.encode(training) {
            defaults.set(encoded, forKey: trainingKey)
            print("DEBUG: Тренировка успешно сохранена")
        }
    }
    
    func fetchTrainingFromUD() -> Training? {
        if let encodedTraining = defaults.object(forKey: trainingKey) as? Data {
            print("DEBUG: Тренировка успешно получена")
            if let decodedTraining = try? decoder.decode(Training.self, from: encodedTraining) {
                print("DEBUG: Тренировка успешно получена и декодированна")
                return decodedTraining
            }
        }
        print("DEBUG: Не удалось получить тренировку")
        return nil
    }    
    
    func isTrainingInProgress() -> Bool {
        
        return defaults.bool(forKey: trainingStateKey)
    }
}





