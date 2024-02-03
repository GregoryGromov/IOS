//
//  ListOfTrainings.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 20.01.2024.
//

import SwiftUI

struct ListOfTrainings: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = ListOfTrainingsViewModel()
    @State var SortDateFromNewToOld = false
    
    @State var selectedFilter: FilterTraining = .byDate
    
    enum FilterTraining {
        case byDate, byDuration
    }
    
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
                Text("Trainings")
                    .font(.title)
                    .fontWeight(.bold)
                    .offset(x: -15)
                Spacer()
            }
            .padding()
            HStack {
                
                
                Button {
                    
                    if SortDateFromNewToOld {
                        viewModel.traings.sort { $0.date < $1.date }
                    } else {
                        viewModel.traings.sort { $0.date > $1.date }
                    }
                    SortDateFromNewToOld.toggle()
                    selectedFilter = .byDate
                    
                } label: {
                    Text("Date")
                        .foregroundStyle(.white)
                        .font(.title3)
                        .padding(15)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 20
                            )/*.stroke(.white, lineWidth: 3)*/
                                .fill(selectedFilter == .byDate ? Color("ColorGray2") : Color("ColorGray"))
                        )
                    
                }
                
                Button {
                    
                    viewModel.traings.sort { $0.duration > $1.duration }
                    selectedFilter = .byDuration
                    
                } label: {
                    Text("Duration")
                        .foregroundStyle(.white)
                        .font(.title3)
                        .padding(15)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 20
                            )/*.stroke(.white, lineWidth: 3)*/
                            .fill(selectedFilter == .byDuration ? Color("ColorGray2") : Color("ColorGray"))
                        )
 
                    
                }
                
                
                Spacer()
            }
            .padding(.top)
            .padding(.horizontal)
            
            
            VStack {
                ForEach(viewModel.traings) { training in
                //ForEach(DataMOCK.shared.TrainingsMOCK) { training in
                
                    NavigationLink {
                        ComplitedTrainingView(training: training)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color("ColorGray"))
                            HStack {
                                Text("\(training.date.formatted(.dateTime.day().month()))")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .padding()
                                Spacer()
                                Text("\(Int(training.duration / 60)) min")
                                Image(systemName: "chevron.right")
                                    .padding()
                                    .font(.title3)
                                    .fontWeight(.bold)
                            }
                            .foregroundStyle(.white)
                            .padding()
                        }
                        
                    }
                }
            }
            .padding()
            }
        }
        .navigationBarHidden(true)
    }
}

