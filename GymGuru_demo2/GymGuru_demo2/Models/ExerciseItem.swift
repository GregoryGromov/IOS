//
//  ExerciseItem.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 20.12.2023.
//

import Foundation

struct ExerciseItem: Hashable, Codable {
    let name: String
    let muscleGroup: [String]
    let isBodyweight: Bool
    var isSelected = false
}
