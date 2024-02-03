//
//  TrainingViewModel.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 19.12.2023.
//

import Foundation
import SwiftUI


class TrainingDataManager: ObservableObject {
    
    
    
    init(currentTraining: Training, program: Program?) {
        self.currentTraining = currentTraining
        
        //смотрим в процессе ли тренировка
        let defaults = UserDefaults.standard
        
        let inProgress = defaults.bool(forKey: "CurrentTrainingState")
        
        if inProgress {
            print("Тренировка в процесее")
        } else {
            print("Не, нет тренировки в процессе")
            let newTraining = Training(
                id: UUID().uuidString,
                date: Date(),
                duration: 0,
                exercises: []
            )
            self.currentTraining = newTraining
        }
            
        self.trainingInProgress = false
    }
    
    
    @Published var currentTraining: Training
    
    @Published var showAddSetView = false
    @Published var selectedExercie: Exercise? = nil
    @Published var showAddExerciseView = false
    @Published var setsOfSelectedExercise: [Set]? = []

    var trainingInProgress: Bool
    
    func finishTraining() {
        self.currentTraining.dateEnd = Date()
        AppStorageDataManager.shared.setTrainingInProgressToFalse()
        CoreDataManager.shared.addTraining(training: currentTraining)
    }
    
    func startTraining() {
        let training = Training(id: UUID().uuidString, duration: 0, exercises: [])
        self.currentTraining = training
        self.trainingInProgress = true
    }
    
    func toggleFold(exerciseId: String) {
        for i in 0...(currentTraining.exercises.count - 1) {
            if currentTraining.exercises[i].id == exerciseId {
                withAnimation() {
                    currentTraining.exercises[i].isFolded.toggle()
                }
            }
        }
    }
    

    
    func addSetToExercise(exerciseId: String, setItem: Set) {
        for i in 0...(currentTraining.exercises.count - 1) {
            if currentTraining.exercises[i].id == exerciseId {
                currentTraining.exercises[i].sets.append(setItem)
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
        AppStorageDataManager.shared.saveTrainingToAppStorage(training: currentTraining)
    }
    
    func setDuration(duration: Int) {
        self.currentTraining.duration = duration
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
    
    
    func computeTrainingDuration() -> String {
        let dateInterval = DateInterval(start: currentTraining.date, end: Date())
        let durationInSeconds = dateInterval.duration
        let trainingDuration = Int(durationInSeconds)
        let formattedDuration = secondsToTime(inSeconds: trainingDuration)
        return formattedDuration
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




//    @Published var exercisesItemsMOCK = [
//        ExerciseItem(name: "Подгягивание", muscleGroup: ["Arms", "Back"], isSelected: false),
//        ExerciseItem(name: "Жим лежа", muscleGroup: ["Chest", "Shoulders"], isSelected: false),
//        ExerciseItem(name: "Скручивание", muscleGroup: ["ABS"], isSelected: false),
//        ExerciseItem(name: "Тяга блока сидя", muscleGroup: ["Back"], isSelected: false),
//        ExerciseItem(name: "Тяга блока стоя", muscleGroup: ["Back"], isSelected: false),
//        ExerciseItem(name: "Присед", muscleGroup: ["Legs"], isSelected: false),
//        ExerciseItem(name: "Выход силой", muscleGroup: ["Arms", "Arms"], isSelected: false),
//    ]



//    func addSetToExerciseMOCK(exerciseId: String, setItem: Set) {
//        for i in 0...(ExercisesMOCK.count - 1) {
//            if ExercisesMOCK[i].id == exerciseId {
//                ExercisesMOCK[i].sets.append(setItem)
//            }
//        }
//    }

//    func returnSelectedExercises() -> [ExerciseItem] {
//        var selectedExercises: [ExerciseItem] = []
//
//        for i in 0...(exercisesItemsMOCK.count - 1) {
//            if exercisesItemsMOCK[i].isSelected {
//                selectedExercises.append(exercisesItemsMOCK[i])
//            }
//        }
//
//
//        return selectedExercises
//    }

//    func convertExerciseItemsToExercises(exerciseItems: [ExerciseItem]) -> [Exercise] {
//        var exercises: [Exercise] = []
//        for exerciseItem in exerciseItems {
//            let exercise = Exercise(
//                id: UUID().uuidString,
//                name: exerciseItem.name,
//                muscleGroup: exerciseItem.muscleGroup,
//                isBodyweight: false,
//                sets: [])
//            exercises.append(exercise)
//        }
//        return exercises
//    }

//    func switchIsSelected(exercise: ExerciseItem) {
//        for i in 0...(exercisesItemsMOCK.count - 1) {
//            if exercisesItemsMOCK[i].name == exercise.name {
//                exercisesItemsMOCK[i].isSelected.toggle()
//            }
//        }
//    }

//    func cleanSelectedExerciseItems() {
//        for i in 0...(exercisesItemsMOCK.count - 1) {
//            exercisesItemsMOCK[i].isSelected = false
//        }
//    }

//    func addSelectedExerciseToTraining() {
//
//        let selectedExercisesItems = returnSelectedExercises()
//        let selectedExercises = convertExerciseItemsToExercises(exerciseItems: selectedExercisesItems)
//
//        for exercise in selectedExercises {
//            self.ExercisesMOCK.append(exercise)
//        }
//
//        cleanSelectedExerciseItems()
//    }


//    @Published var ExercisesMOCK = [
//        Exercise(
//            id: UUID().uuidString,
//            name: "Push-ups",
//            muscleGroup: ["Arms", "Chest"],
//            isBodyweight: true,
//            sets: [
//                Set(id: UUID().uuidString, amount: 20),
//                Set(id: UUID().uuidString, amount: 25)
//            ]
//        ),
////        Exercise(
////            id: UUID().uuidString,
////            name: "Push-ups",
////            muscleGroup: ["Arms", "Chest"],
////            isBodyweight: true,
////            sets: [
////                Set(id: UUID().uuidString, amount: 20),
////                Set(id: UUID().uuidString, amount: 25),
////                Set(id: UUID().uuidString, amount: 30)
////            ]
////        ),
//    ]


//    func addExerciseMOCK() {
//        let exercise = Exercise(
//            id: UUID().uuidString,
//            name: "Push-ups",
//            muscleGroup: ["Arms", "Chest"],
//            isBodyweight: true,
//            sets: [
//                Set(id: UUID().uuidString, amount: 20),
//                Set(id: UUID().uuidString, amount: 25),
//                Set(id: UUID().uuidString, amount: 30)
//            ]
//        )
//        self.currentTraining.exercises.append(exercise)
//
//    }
