//
//  TrainingRouter.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 24.12.2023.
//

import Foundation
import SwiftUI

class TrainingStartViewModel: ObservableObject {
    
    let router: RouterViewModel
    
    init(router: RouterViewModel) {
        self.router = router
    }
    
    func startTraining() {
        router.startTraining()
    }
}

