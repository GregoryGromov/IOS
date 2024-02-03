//
//  StatisticsDataManager.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 13.01.2024.
//

import Foundation

class StatisticsDataManager {
    
    static let shared = StatisticsDataManager()
    
    func getAllTrainings() -> [Training] {
        let fetchedTrainings = CoreDataManager.shared.getTrainings()
        return fetchedTrainings
    }
    
    
    
}
