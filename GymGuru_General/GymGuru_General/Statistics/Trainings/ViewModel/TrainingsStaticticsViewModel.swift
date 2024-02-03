//
//  TrainingsStaticticsViewModel.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 13.01.2024.
//

import Foundation

class TrainingsStaticticsViewModel: ObservableObject {
    
    @Published var allTrainings: [Training]
    @Published var countOfBars = 5
    
    init() {
//        self.allTrainings = StatisticsDataManager.shared.getAllTrainings()
        self.allTrainings = DataMOCK.shared.TrainingsMOCK.reversed()
    }
}
