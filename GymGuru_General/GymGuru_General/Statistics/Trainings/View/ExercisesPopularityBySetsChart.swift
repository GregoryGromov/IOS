//
//  ExercisesPopularityBySetsChart.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 14.01.2024.
//

import SwiftUI
import Charts

struct ExercisesPopularityBySetsChart: View {
    
    @StateObject var viewModel: TrainingsStaticticsViewModel
    
    var popularExercises: [ExerciseSI] {
        return computeMostPopularExercisesInTrainings(trainings: viewModel.allTrainings)
    }
    
    var percentOfMostPopularExercise: Int {
        let fetchedPopularExercises = computeMostPopularExercisesInTrainings(trainings: viewModel.allTrainings)
        
        var countOfSets = 0
        for exerciseSI in fetchedPopularExercises {
            countOfSets += exerciseSI.amountOfSets
        }
        
        let percent = Int(Float(fetchedPopularExercises[0].amountOfSets) / Float(countOfSets) * 100)
        
        return percent
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color("ColorGray"))
            VStack {
                
                
                HStack {
                    Text("Most popular exercise is ") +
                    Text("\(popularExercises[0].name). ").bold() +
                    Text("It makes up ") +
                    Text("\(percentOfMostPopularExercise)% ").bold() +
                    Text("of all sets")
                    Spacer()
                }
                
                
                Chart {
                    ForEach(popularExercises, id: \.self) { exerciseItem in
                        SectorMark(
                            angle: .value("Sets", exerciseItem.amountOfSets),
                            innerRadius: .ratio(0.5),
                            angularInset: 2.0
                        )
                        .foregroundStyle(by: .value("Type", exerciseItem.name))
                        .cornerRadius(3.0)
                    }
                }
                
                .frame(height: 200)
            }
            .padding()
        }
        .padding(.top)
        .padding(.horizontal)
    }
    
    //нужно найти 5 самых популярных упражнений по количеству сетов
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
        
        var otherExercisesSetsCount = 0
        
        //всего в PieChart у нас будет 5 кусков, поэтому если различных упражнений за все тренировки набралось больше шести, то самые непопулярные мы объединим в один кусок и назовем его "Othes"
        if exerciseSIs.count < 6 {
            return exerciseSIs
        } else {
            
            //рассмотрим все, кроме 4х первых (то есть самых популярных) упражнений
            for i in 4...(exerciseSIs.count - 1) {
                otherExercisesSetsCount += exerciseSIs[i].amountOfSets
            }
            
            //в формате 4 самых популярных + "Othes"
            var popularExercisesFormatted: [ExerciseSI] = []
            for i in 0...3 {
                popularExercisesFormatted.append(exerciseSIs[i])
            }
            
            popularExercisesFormatted.append(ExerciseSI(name: "Othes", amountOfSets: otherExercisesSetsCount))
            
            return popularExercisesFormatted
        }
    }
}

