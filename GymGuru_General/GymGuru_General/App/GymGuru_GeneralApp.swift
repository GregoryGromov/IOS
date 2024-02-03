//
//  GymGuru_GeneralApp.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 19.12.2023.
//

import SwiftUI

@main
struct GymGuru_GeneralApp: App {
    var body: some Scene {
        WindowGroup {
//            TrainingView()
//                .preferredColorScheme(.dark)
//            TrainingRouterView()
//                .preferredColorScheme(.dark)
            MainTabView()
                .preferredColorScheme(.dark)
            
        }
        
    }
}
