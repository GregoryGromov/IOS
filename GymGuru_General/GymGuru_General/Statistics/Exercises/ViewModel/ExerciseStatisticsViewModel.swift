//
//  ExerciseStatisticsViewModel.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 14.01.2024.
//

import Foundation

class ExerciseStatisticsViewModel: ObservableObject {
    
    @Published var allTrainings: [Training]
    
    @Published var chartInfo: [MaxWeightExerciseSI] = []
    @Published var range: (Date, Date)? = nil
    @Published var usedExercises: [ExerciseSI] = []
    
    var usedExercisesNames: [String] = []
    @Published var selectedExerciseId: String = ""
    
    init() {
//        self.allTrainings = StatisticsDataManager.shared.getAllTrainings()
        self.allTrainings = DataMOCK.shared.TrainingsMOCK.reversed()
    }
    
    func computeStartedChartInfo() {
        chartInfo = findMaxWeightPerTraining(exerciseName: "Жим лежа")
        usedExercises = computeMostPopularExercisesInTrainings(trainings: allTrainings)
        selectedExerciseId = usedExercises[0].name
        
        for exercise in usedExercises {
            usedExercisesNames.append(exercise.name)
        }
    }
    
    func computeChartInfo(exercise: ExerciseSI) {
        chartInfo = findMaxWeightPerTraining(exerciseName: exercise.name)
        selectedExerciseId = exercise.name
    }
    
    
    func findMaxWeightPerTraining(exerciseName: String) -> [MaxWeightExerciseSI] {
        
        var maxWeigthExerciseISs: [MaxWeightExerciseSI] = []
        
        for training in allTrainings {
            
            //!!!Надо поменять название struct Set на что-то другое
            
            
            //запоминаем все сеты этого упражнения в данной тренировке
            for exercise in training.exercises {
                if exercise.name == exerciseName {
                    var rightExerciseSets = [Set(id: UUID().uuidString, weight: 0, amount: 0)]
                    for set_ in exercise.sets {
                        rightExerciseSets.append(set_)
                    }
                    //выберем сет с наибольшим весом
                    
                    rightExerciseSets.sort { (lhs, rhs) in return lhs.weight > rhs.weight }
                    
                    maxWeigthExerciseISs.append(
                        MaxWeightExerciseSI(name: exerciseName,
                                            weight: rightExerciseSets[0].weight, //!!!
                                            date: training.date)
                    )
                    
                }
            }
        }
        //        print("JJ: \(maxWeigthExerciseISs)")
        return maxWeigthExerciseISs
    }
    
    func computeMostPopularExercisesInTrainings(trainings: [Training]) -> [ExerciseSI] {
        var exerciseFrequency: [String:Int] = [:] //словарь типа [Название упражнения : суммарное симло сетов во всех тренировках]
        
        for training in trainings {
            for exercise in training.exercises {
                if exerciseFrequency[exercise.name] == nil {
                    exerciseFrequency[exercise.name] = exercise.sets.count
                } else {
                    exerciseFrequency[exercise.name]! += exercise.sets.count
                }
            }
        }
        
        //массив словарей вида (key: "Жим лежа", value: 4)
        let arrayOfExerciseFrequency = exerciseFrequency.sorted { $0.1 < $1.1 }
        
        //преобразуем в массив ExerciseSI - то есть удобных для отображения на графике структур
        
        var exerciseSIs: [ExerciseSI] = []
        for exerciseDictItem in arrayOfExerciseFrequency {
            let exerciseSI = ExerciseSI(name: exerciseDictItem.key, amountOfSets: exerciseDictItem.value)
            exerciseSIs.append(exerciseSI)
        }
        
        //чтобы шли от более частых к менее
        exerciseSIs = exerciseSIs.reversed()
        
        
        
        return exerciseSIs
        
    }
}
