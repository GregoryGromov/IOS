//
//  TrainingRouterView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 24.12.2023.
//

import SwiftUI

struct TrainingRouterView: View {
    
    @StateObject var viewModel = TrainingRouter()
    
    
    
    
    var body: some View {
        VStack {
            if viewModel.trainingInProgress {
                if let currentTraining = viewModel.currentTraining {
                    TrainingView(currentTraining: currentTraining)
                        .environmentObject(viewModel)
                } else {
                    Text("DEBUG: Хотя тренировка в процессе, ее не удалось загрузить из AppStorage #001")
                }
            } else {
                MainControlWidget()
                    .environmentObject(viewModel)
                Spacer()
            }
        }
    }
}

