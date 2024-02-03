//
//  ListOfTrainingsViewModel.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 20.01.2024.
//

import Foundation

class ListOfTrainingsViewModel: ObservableObject {
    
    @Published var traings: [Training]
    
    init() {
        self.traings = CoreDataManager.shared.getTrainings()
    }
}
