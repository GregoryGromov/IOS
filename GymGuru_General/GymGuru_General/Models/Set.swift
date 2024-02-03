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
    
//    var weight: Float? 19:53 15.01
    var weight: Float

    var amount: Int
}


