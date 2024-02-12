//
//  Set.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 19.12.2023.
//

import Foundation

struct Set: Identifiable, Codable, Hashable {
    let id: String
    var date = Date()
    var weight: Float
    var amount: Int
}


