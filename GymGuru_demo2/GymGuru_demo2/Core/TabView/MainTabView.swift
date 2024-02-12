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
            Text("Статистика")
                .onAppear {
                    selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }.tag(0)
            
            RouterView()
                .onAppear {
                    selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "figure.strengthtraining.traditional")
                }.tag(1)
        }
    }
}
