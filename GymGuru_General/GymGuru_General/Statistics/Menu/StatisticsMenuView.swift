//
//  StatisticsMenuView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 13.01.2024.
//

import SwiftUI

struct StatisticsMenuView: View {
    
    @StateObject var profileViewModel = ProfileViewModel()
    @State var showProfileSheet = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Trainings")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Button {
                        showProfileSheet.toggle()
                    } label: {
                        if let image = profileViewModel.selectedImage { //!!!
                            Image (uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .cornerRadius (100)
                        } else {
                            Text("Profile")
                        }
                    }
                    
                }
                .padding()
                
                NavigationLink {
                    TrainingsStatisticsView()
                } label: {
                    TemporaryLabel(title: "Trainings statistics")
                }
                NavigationLink {
                    ListOfTrainings()
                } label: {
                    TemporaryLabel(title: "List of trainings")
                }
                
                
                HStack {
                    Text("Exercises")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                .padding()
                
                NavigationLink {
                    ExerciseStatisticsView()
                } label: {
                    TemporaryLabel(title: "Exercise statistics")
                }
                 
//                NavigationLink {
//                    ProxyTest()
//                } label: {
//                    TemporaryLabel(title: "Proxy test")
//                }
                Spacer()
            }
            .navigationTitle("Statistics")
            .navigationBarHidden(true)
            .sheet(isPresented: $showProfileSheet) {
                ProfileView().environmentObject(profileViewModel)
            }
        }
    }
}


