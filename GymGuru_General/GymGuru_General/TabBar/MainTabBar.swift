//
//  MainTabView.swift
//  InstagramTutorial
//
//  Created by Григорий Громов on 13.07.2023.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            //StatisticsView()
            StatisticsMenuView()
                .onAppear {
                    selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }.tag(0)
            
            TrainingRouterView()
                .onAppear {
                    selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "figure.strengthtraining.traditional")
                }.tag(1)
            
//            ProfileView()
//                .onAppear {
//                    selectedIndex = 2
//                }
//                .tabItem {
//                    Image(systemName: "person.fill")
//                }.tag(2)
        }
    }
    
    
}
