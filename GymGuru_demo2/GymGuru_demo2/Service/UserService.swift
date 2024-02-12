//
//  UserService.swift
//  GymGuru_demo2
//
//  Created by Григорий Громов on 09.02.2024.
//

import Foundation

class UserService {
    
    static let shared = ExerciseService()
        
    let defaults = UserDefaults.standard

    func setUserInfo<T>(key: String, data: T) {
        defaults.set(data, forKey: key)
    }
    
    func getUserInfoString(key: String) -> String? {
        if let value = defaults.string(forKey: key) {
            return value
        } else {
            return nil
        }
    }

    func getUserInfoFloat(key: String) -> Float {
        return defaults.float(forKey: key)
    }
    
}
