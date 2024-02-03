//
//  TrainingsStatistics.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 13.01.2024.
//

import Foundation
import SwiftUI
import Charts

//struct ExerciseSI: Hashable {
//    let name: String
//    let amountOfSets: Int
//}

struct TrainingsStatisticsView: View {
    
    @StateObject var viewModel = TrainingsStaticticsViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    enum FilterTraining {
        case all, last5, last10, last20, none
    }
    
    @State var selectedFilter: FilterTraining = .last5
    
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            //TimeChart(viewModel: viewModel)
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
                Text("Trainings")
                    .font(.title)
                    .fontWeight(.bold)
                    .offset(x: -15)
                Spacer()
            }
            .padding()
            HStack {
                if viewModel.allTrainings.count <= 30 {
                    
                    Button {
                        withAnimation {
                            viewModel.countOfBars = viewModel.allTrainings.count
                            selectedFilter = .all
                        }
                        
                    } label: {
                        Text("All")
                            .foregroundStyle(.white)
                            .font(.title3)
                            .padding(15)
                            .frame(width: 60)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 20
                                )/*.stroke(.white, lineWidth: 3)*/
                                .fill(selectedFilter == .all ? Color("ColorGray2") : Color("ColorGray"))
                            )
                            
                    }
                }
                if viewModel.allTrainings.count >= 5 {
                    Button {
                        withAnimation {
                            viewModel.countOfBars = 5
                            selectedFilter = .last5
                        }
                    } label: {
                        Text("5 last")
                            .foregroundStyle(.white)
                            .font(.title3)
                            .padding(15)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 20
                                )/*.stroke(.white, lineWidth: 3)*/
                                    .fill(selectedFilter == .last5 ? Color("ColorGray2") : Color("ColorGray"))
                            )
                    }
                }
                if viewModel.allTrainings.count >= 10 {
                    Button {
                        withAnimation {
                            viewModel.countOfBars = 10
                            selectedFilter = .last10
                        }
                    } label: {
                        Text("10 last")
                            .foregroundStyle(.white)
                            .font(.title3)
                            .padding(15)
                            .background(
                                RoundedRectangle(
                                    
                                    cornerRadius: 20
                                )/*.stroke(.white, lineWidth: 3)*/
                                    .fill(selectedFilter == .last10 ? Color("ColorGray2") : Color("ColorGray"))
                            )
                    }
                }
                if viewModel.allTrainings.count >= 20 {
                    Button {
                        withAnimation {
                            viewModel.countOfBars = 20
                            selectedFilter = .last20
                        }
                    } label: {
                        Text("20 last")
                            .foregroundStyle(.white)
                            .font(.title3)
                            .padding(10)
                            .background(
                                RoundedRectangle(
                                    
                                    cornerRadius: 20
                                )/*.stroke(.white, lineWidth: 3)*/
                                .fill(selectedFilter == .last20 ? Color("ColorGray") : .black)
                            )
                    }
                }
                Spacer()
            }
            .padding(.top)
            .padding(.horizontal)
            DurationChart(viewModel: viewModel)
            TonnageChart(viewModel: viewModel)
            ExercisesPopularityBySetsChart(viewModel: viewModel)
        }
        //        .navigationBarTitle("")
        .navigationBarHidden(true)
        //.navigationBarBackButtonHidden(true)
        //        .navigationBarItems(leading: btnBack)
    }
    
    //    var btnBack : some View { Button(action: {
    //            self.presentationMode.wrappedValue.dismiss()
    //            }) {
    //                HStack {
    //                Image(systemName: "chevron.left.circle.fill") // set image here
    //                    .aspectRatio(contentMode: .fit)
    //                    .foregroundColor(.white)
    //                    .font(.title2)
    ////                    Text("s")
    //                }
    //            }
    //        }
}
















//    var mostPopularExercise: (exerciseItem: ExerciseSI, persent: Int) {
//        let mostPopularExercises = computeMostPopularExercisesInTrainings(trainings: viewModel.allTrainings)
//
//        var amount = 0
//
//        for exerciseItem in computeMostPopularExercisesInTrainings(trainings: viewModel.allTrainings) {
//            amount += exerciseItem.amountOfSets
//        }
//
//        let percent = Int((Float(mostPopularExercises[0].amountOfSets) / Float(amount)) * 100)
//
//
//
//        return (mostPopularExercises[0], percent)
//    }
