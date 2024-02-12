//
//  TrainingRouterView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 24.12.2023.
//

import SwiftUI

struct RouterView: View {
    
    @StateObject var viewModel = RouterViewModel()
    
    
    
    
    var body: some View {
        VStack {
            if viewModel.trainingInProgress {
                TrainingView(router: viewModel)
            } else {
                TrainingStartView(router: viewModel)
            }
        }
    }
}


