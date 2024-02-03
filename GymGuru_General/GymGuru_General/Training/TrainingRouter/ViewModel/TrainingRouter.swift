//
//  TrainingRouter.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 24.12.2023.
//

import Foundation
import SwiftUI


class TrainingRouter: ObservableObject {

    init() {
        detectState()
    }
    
    var currentTraining: Training?
    
    @Published var trainingInProgress = false
    
    
    let defaults = UserDefaults.standard
    
    func setTrainingInProgressToTrue() {
        defaults.set(true, forKey: "CurrentTrainingState")
    }
    
    func setTrainingInProgressToFalse() {
        defaults.set(false, forKey: "CurrentTrainingState")
    }
    
    func startTraining() {
        let newTraining = Training(
            id: UUID().uuidString,
            date: Date(),
            duration: 0,
            exercises: [])
        
        self.currentTraining = newTraining
        self.trainingInProgress = true
        AppStorageDataManager.shared.saveTrainingToAppStorage(training: newTraining)
        setTrainingInProgressToTrue()
    }
    
    func finishTraining() {
        setTrainingInProgressToFalse()
        detectState()
    }
    
    
    private func detectState() {
        let defaults = UserDefaults.standard
        let inProgress = defaults.bool(forKey: "CurrentTrainingState")
        
        if inProgress {
            let oldTraining = AppStorageDataManager.shared.fetchTrainingFromAppStorage()
            if let oldTraining = oldTraining {
                self.currentTraining = oldTraining
                self.trainingInProgress = true
            } else {
                print("DEBUG: не удалось загрузить тренировку из AppStorage")
            }
        } else {
            self.trainingInProgress = false
        }
    }
}
