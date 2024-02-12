//
//  Training.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 19.12.2023.
//

import Foundation

struct Training: Identifiable, Codable, Hashable {
    let id: String
    var date = Date()
    var dateEnd: Date?
    var exercises: [Exercise]
}
