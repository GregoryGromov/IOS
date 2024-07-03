//
//  DataManager.swift
//  Combine+2VM
//
//  Created by Григорий Громов on 03.07.2024.
//

import Foundation

import Combine


class DataManager {
    static let shared = DataManager()
        
    @Published var text = "Hello, I am your destiny"
    
    func updateText(_ newText: String) {
        text = newText
    }
}



//class DataManager {
//    static let shared = DataManager()
//    
//    private var cancellables = Set<AnyCancellable>()
//    
//    @Published var text = "Hello, I am your destiny"
//    
//    private init() {
//        $text
//            .sink { newText in
//                print("DataManager: Text changed to \(newText)")
//            }
//            .store(in: &cancellables)
//    }
//    
//    func updateText(_ newText: String) {
//        text = newText
//    }
//}
