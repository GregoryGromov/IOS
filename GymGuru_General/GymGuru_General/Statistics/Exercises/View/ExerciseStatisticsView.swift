//
//  ExerciseStatisticsView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 14.01.2024.
//

import SwiftUI
import Charts

struct ExerciseStatisticsView: View {
    
    @StateObject var viewModel = ExerciseStatisticsViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                HStack {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left.circle.fill") // set image here
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .font(.title)
                    }
                    Spacer()
                    Text("Exercises")
                        .font(.title)
                        .fontWeight(.bold)
                        .offset(x: -15)
                    Spacer()
                }
                .padding()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.usedExercises, id: \.self) { exercise in
                            Button() {
                                viewModel.computeChartInfo(exercise: exercise)
                                
                            } label: {
                                Text(exercise.name)
                                    .foregroundStyle(.white)
                                    .font(.title3)
                                    .padding()
                                    .background(
                                        RoundedRectangle(
                                            cornerRadius: 20
                                        )/*.stroke(.white, lineWidth: 3)*/
                                            .fill(viewModel.selectedExerciseId == exercise.name ? Color("ColorGray2") : Color("ColorGray"))
                                    )
                            }
                        }
                    }
                    
                }
                .padding(.horizontal)
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("ColorGray"))
                    VStack {
                        
                        Chart {
                            ForEach(viewModel.chartInfo.sorted {$0.date < $1.date}, id: \.self) { chartItem in
                                LineMark (
                                    x: .value("Day", chartItem.date),
                                    y: .value("Weight", chartItem.weight)
                                )
                            }
                            .symbol(by: .value("Type", ""))
                            //.interpolationMethod (.cardinal)
                            
                            if let range = viewModel.range {
                                RectangleMark(
                                    xStart: .value("Range Start", range.0),
                                    xEnd: .value("Range End", range.1)
                                )
                                .foregroundStyle(.gray.opacity(0.2))
                            }
                            
                        }
                        .aspectRatio(1.0, contentMode: .fit)
                        
                    }
                    .padding()
                    .onAppear {
                        viewModel.computeStartedChartInfo()
                    }
                }
                .padding(.top)
                .padding(.horizontal)
                
                Spacer()
            }
            
            
        }
        .navigationBarHidden(true)
    }
}









//            .chartOverlay { proxy in
//                GeometryReader { g in
//                    Rectangle().fill(.clear).contentShape(Rectangle())
//                        .gesture (DragGesture()
//                            .onChanged { value in
//                                // Find the x coordinates in the chart's plot area.
//                                let startX = value.startLocation.x - g[proxy.plotAreaFrame].origin.x
//                                let currentX = value.location.x - g[proxy.plotAreaFrame].origin.x
//                                // Find the date values at the x coordinates.
//                                if let startDate: Date = proxy.value(atX: startX), let currentDate: Date = proxy.value(atX: currentX) {
//                                    range = (startDate, currentDate)
//                                }
//
//                            }
//                            .onEnded
//                                  {_ in range = nil } // Clear state on gesture end.
//                        )
//                }
//            }
