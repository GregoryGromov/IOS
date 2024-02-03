//
//  Program.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 29.01.2024.
//

import SwiftUI

struct Program: Identifiable {
    let id = UUID().uuidString
    var name: String
    let exercises: [ExerciseItem]
    
    static let ProgramsMOCK: [Program] = [
        Program(
            name: "Разминка",
            exercises: []
        ),
        Program(
            name: "Заминка",
            exercises: []
        )
    ]
    
}
