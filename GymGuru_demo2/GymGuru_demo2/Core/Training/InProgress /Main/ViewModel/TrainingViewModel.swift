//
//  TrainingViewModel.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 19.12.2023.
//

import Foundation
import SwiftUI




class TrainingViewModel: ObservableObject {
    
    init(router: RouterViewModel) {
        
        if TrainingService.shared.isTrainingInProgress() {
            let oldTraining = TrainingService.shared.fetchTrainingFromUD()
            //print("DEBUG: Старая тренировка была получена")
            if let training = oldTraining {
                self.currentTraining = training
                
            } else {
               
                //print("DEBUG/WARNING: не удалось загрузить тренировку из UserDefaults, поэтому начата новая")
//                let newTraining = Training(
//                    id: UUID().uuidString,
//                    date: Date(),
//                    exercises: []
//                )
                self.currentTraining = TrainingViewModel.createNewTraining()

            }
        } else {
            let newTraining = TrainingViewModel.createNewTraining()
            self.currentTraining = newTraining
            router.setTrainingInProgress()
            TrainingService.shared.saveTrainingToUD(training: newTraining)
            
            //print("DEBUG: Создана новая тренировка")
        }
        self.router = router
    }
    
//    deinit {
//        print("DEBUG: TrainingViewModel уничтожена")
//    }
    
    let router: RouterViewModel
    
    @Published var currentTraining: Training
    
    @Published var showAddSetView = false
    @Published var showAddExerciseView = false
    
    @Published var selectedExercie: Exercise? = nil
    @Published var setsOfSelectedExercise: [Set]? = []
    
    
    static func createNewTraining() -> Training {
        let newTraining = Training(
            id: UUID().uuidString,
            date: Date(),
            exercises: []
        )
        return newTraining
    }
    
    
    
    
    func finishTraining() {
        self.currentTraining.dateEnd = Date()
//        CoreDataManager.shared.addTraining(training: currentTraining)
        router.finishTraining()
    }
    
    
    
    
    func toggleFold(exerciseId: String) {
        for i in 0...(currentTraining.exercises.count - 1) {
            if currentTraining.exercises[i].id == exerciseId {
                withAnimation() {
                    currentTraining.exercises[i].isFolded.toggle()
                }
                return
            }
        }
    }
    
    
    
    func addSetToExercise(exerciseId: String, setItem: Set) {
        for i in 0...(currentTraining.exercises.count - 1) {
            if currentTraining.exercises[i].id == exerciseId {
                currentTraining.exercises[i].sets.append(setItem)
                return
            }
        }
        saveTraining()
    }
    
    func addSelectedExerciseToTraining(exercises: [Exercise]) {
        for exercise in exercises {
            self.currentTraining.exercises.append(exercise)
        }
        saveTraining()
    }
    
    
    func saveTraining() {
        TrainingService.shared.saveTrainingToUD(training: currentTraining)
    }
    
    func deleteExercise(exerciseId: String) {
        for i in 0..<currentTraining.exercises.count {
            if currentTraining.exercises[i].id == exerciseId {
                currentTraining.exercises.remove(at: i)
                saveTraining()
                return
            }
        }
    }
    
    func deleteSet(exerciseId: String, setId: String) {
        for i in 0..<currentTraining.exercises.count {
            if currentTraining.exercises[i].id == exerciseId {
                for j in 0..<currentTraining.exercises[i].sets.count {
                    if currentTraining.exercises[i].sets[j].id == setId {
                        currentTraining.exercises[i].sets.remove(at: j)
                        saveTraining()
                        return
                    }
                }
            }
        }        
    }
    
    
    func computeTrainingDuration() -> Int {
        let dateInterval = DateInterval(start: currentTraining.date, end: Date())
        let durationInSeconds = dateInterval.duration
        let trainingDuration = Int(durationInSeconds)
        //let formattedDuration = secondsToTime(inSeconds: trainingDuration)
        print("DEBUG: trainingDuration = \(trainingDuration)")
        return trainingDuration
    }
    
    func secondsToTime(inSeconds: Int) -> String {
        let seconds = inSeconds % 60
        let minutes = (inSeconds % 3600) / 60
        let hours = inSeconds / 3600
        
        if hours > 0 {
            if hours > 9 {
                if minutes > 9 {
                    if seconds > 9 {
                        return "\(hours):\(minutes):\(seconds)"
                    } else {
                        return "\(hours):\(minutes):0\(seconds)"
                    }
                } else {
                    if seconds > 9 {
                        return "\(hours):0\(minutes):\(seconds)"
                    } else {
                        return "\(hours):0\(minutes):0\(seconds)"
                    }
                }
            } else {
                if minutes > 9 {
                    if seconds > 9 {
                        return "0\(hours):\(minutes):\(seconds)"
                    } else {
                        return "0\(hours):\(minutes):0\(seconds)"
                    }
                } else {
                    if seconds > 9 {
                        return "0\(hours):0\(minutes):\(seconds)"
                    } else {
                        return "0\(hours):0\(minutes):0\(seconds)"
                    }
                }
            }
        } else {
            if minutes > 9 {
                if seconds > 9 {
                    return "\(minutes):\(seconds)"
                } else {
                    return "\(minutes):0\(seconds)"
                }
            } else {
                if seconds > 9 {
                    return "0\(minutes):\(seconds)"
                } else {
                    return "0\(minutes):0\(seconds)"
                }
            }
        }
    }
    
    func countTrainigExercises() -> Int {
        return currentTraining.exercises.count
    }
}




