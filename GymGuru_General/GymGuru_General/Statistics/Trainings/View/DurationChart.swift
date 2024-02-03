//
//  DurationChart.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 13.01.2024.
//

import SwiftUI
import Charts

struct DurationChart: View {
    
    @StateObject var viewModel: TrainingsStaticticsViewModel
    
    var averageDuration: Int {
        var sumDurationPerPeriod = 0
        for training in viewModel.allTrainings.suffix(viewModel.countOfBars) {
            sumDurationPerPeriod += training.duration / 60
        }
        
        return Int(sumDurationPerPeriod / viewModel.countOfBars)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("ColorGray"))
//                .fill(.black)
                
            
            VStack {
                HStack {
                    Text("Average workout duration is ") +
                    Text("\(averageDuration) minutes")
                        .bold()
                    Spacer()
                }
                
                if viewModel.allTrainings.count >= 3 {
                    VStack {
                        Chart {
                            ForEach(viewModel.allTrainings.suffix(viewModel.countOfBars), id: \.self) { training in
                                BarMark(
                                    x: .value("ID", training.id), //!!!Преполагается что массив тренировок предварительно отсортирован по Date
                                    y: .value("Duration", training.duration / 60))
                                
                            }
                            RuleMark(y: .value("Average", averageDuration))
                                .foregroundStyle(.green)
                        }
                        .chartYAxis {
                            AxisMarks(values: [0, 15, 30, 45, 60])
                        }
                        .chartXAxis(.hidden)
                    }
                } else {
                    Text("Для создания статистики необходимо иметь хотя бы три завершенных тренировки")
                }
            }
            .padding()
        }
        .padding(.top)
        .padding(.horizontal)
    }
}

//#Preview {
//    DurationChart()
//}
