//
//  PrimaryView.swift
//  Combine+2VM
//
//  Created by Григорий Громов on 03.07.2024.
//

import SwiftUI
import Combine




import Combine

struct PrimaryView: View {
    @StateObject var viewModel = PrimaryViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.labelText)
            Button("Show edit view") {
                viewModel.showSheet = true
            }
        }
        .sheet(isPresented: $viewModel.showSheet) {
            SecondaryView(viewModel: SecondaryViewModel())
        }
    }
}

class PrimaryViewModel: ObservableObject {
    @Published var labelText = ""
    @Published var showSheet = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        DataManager.shared.$text
            .assign(to: \.labelText, on: self)
            .store(in: &cancellables)
    }
}
