//
//  TimeChart.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 16.01.2024.
//

//
//  DurationChart.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 13.01.2024.
//

import SwiftUI
import Charts

struct TimeChart: View {
    
    @StateObject var viewModel: TrainingsStaticticsViewModel
    @State var countOfDurationBars = 3
    

    
    var averageDuration: Int {
        var sumDurationPerPeriod = 0
        for training in viewModel.allTrainings.suffix(countOfDurationBars) {
            sumDurationPerPeriod += training.duration
        }

        return Int(sumDurationPerPeriod / countOfDurationBars)
    }
    
    var body: some View {
        VStack {
//            if viewModel.allTrainings.count >= 3 {
            if true {
                VStack {
                    Chart {
                        ForEach(viewModel.allTrainings.suffix(countOfDurationBars), id: \.self) { training in
                            BarMark(
                                x: .value("ID", training.id), //!!!Преполагается что массив тренировок предварительно отсортирован по Date
//                                y: .value("Duration", training.duration))
                                yStart: .value("Training Min", training.date),
                                yEnd: .value("Training Max", training.dateEnd!)
                                //width: .ratio(0.6)
                            )
                            //.opacity(0.3)
                        }
                    }
                    .chartXAxis(.hidden)
                    HStack {
                        if viewModel.allTrainings.count <= 30 {
                            
                            Button {
                                withAnimation {
                                    countOfDurationBars = viewModel.allTrainings.count
                                }
                                
                            } label: {
                                Text("All")
                            }
                        }
                        if viewModel.allTrainings.count >= 5 {
                            Button {
                                withAnimation {
                                    countOfDurationBars = 5
                                }
                            } label: {
                                Text("5 last")
                            }
                        }
                        if viewModel.allTrainings.count >= 10 {
                            Button {
                                withAnimation {
                                    countOfDurationBars = 10
                                }
                            } label: {
                                Text("10 last")
                            }
                        }
                        if viewModel.allTrainings.count >= 20 {
                            Button {
                                withAnimation {
                                    countOfDurationBars = 20
                                }
                            } label: {
                                Text("20 last")
                            }
                        }
                        
                        
                    }
                }
            } else {
                Text("Для создания статистики необходимо иметь хотя бы три завершенных тренировки")
            }
        }
        .padding()
    }
}

