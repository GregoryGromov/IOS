//
//  Exercise.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 19.12.2023.
//

import Foundation

struct Exercise: Identifiable, Codable, Hashable {
    let id: String
    var date = Date()
    let name: String
    let muscleGroup: [String]
    let isBodyweight: Bool
    var sets: [Set]
    var isFolded = false
}


