import Foundation
import Combine


class DataManager {
    static let shared = DataManager()
        
    @Published var text = "Hello, I am your destiny"
    
    func updateText(_ newText: String) {
        text = newText
    }
}

