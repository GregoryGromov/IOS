//
//  TonnageChart.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 13.01.2024.
//

import SwiftUI
import Charts

struct TonnageChart: View {
    
    @StateObject var viewModel: TrainingsStaticticsViewModel
    @State var countOfTonnageBars = 3
    
    var averageTonnage: Int {
        var sumTonnage = 0
        for training in viewModel.allTrainings.suffix(viewModel.countOfBars) {
            sumTonnage += calculateTrainingTonnage(training: training)
        }
        
        return Int(sumTonnage / viewModel.countOfBars)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                            .fill(Color("ColorGray"))
//                .foregroundColor(Color("ColorGray"))
            VStack {
                HStack {
                    Text("Average workout tonnage is ") +
                    Text("\(averageTonnage) kg")
                        .bold()
                    Spacer()
                }
                Chart {
                    ForEach(viewModel.allTrainings.suffix(viewModel.countOfBars), id: \.self) { training in
                        BarMark(
                            x: .value("ID", training.id), //!!!Преполагается что массив тренировок предварительно отсортирован по Date
                            y: .value("Duration", calculateTrainingTonnage(training: training)))
                        .foregroundStyle(.orange)
                        
                    }
                    RuleMark(y: .value("Average", averageTonnage))
                        .foregroundStyle(.green)
                    
                }
                .chartXAxis(.hidden)
                
            }
            .padding()
        }
        .padding(.top)
        .padding(.horizontal)
    }
    
    func calculateTrainingTonnage(training: Training) -> Int {
        var tonnage = 0
        
        for exercise in training.exercises {
            for set in exercise.sets {
                tonnage += Int(Float(set.amount) * set.weight) //Убрать ? у weight - это будет обязательный параметр
            }
        }
        return tonnage
    }
}
//
//#Preview {
//    TonnageChart()
//}
