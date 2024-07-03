//
//  SwiftUIView.swift
//  Combine+2VM
//
//  Created by Григорий Громов on 03.07.2024.
//

import SwiftUI
import Combine


struct SecondaryView: View {
    
    @StateObject var viewModel: SecondaryViewModel
    
    var body: some View {
        VStack {
            TextField("Edit it...", text: $viewModel.editedText)
                .background(Color.blue)
            
            Button("Update Text") {
                viewModel.updateText()
            }
        }
    }
}



import Combine

class SecondaryViewModel: ObservableObject {
    @Published var editedText = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        DataManager.shared.$text
            .assign(to: \.editedText, on: self)
            .store(in: &cancellables)
    }
    
    func updateText() {
        DataManager.shared.updateText(editedText)
    }
}
