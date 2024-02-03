//
//  ProfileView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 24.12.2023.
//

import SwiftUI
import PhotosUI

@MainActor
struct ProfileView: View {
    
    @EnvironmentObject private var viewModel: ProfileViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 40) {
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.white)
                }
                Spacer()
                Text("Profile")
                    .offset(x: -10)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            
            PhotosPicker(selection: $viewModel.imageSelection, matching: .images) {
                if let image = viewModel.selectedImage {
                    Image (uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .cornerRadius (100)
                } else {
                    Text("Добавить фото профиля")
                        .foregroundColor(.red)
                }
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color("ColorGray2"))
                
                HStack {
                    Text("Weight: \(String(format: "%.1f", viewModel.userWeight)) kg")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    Button {
                        viewModel.showSheet = true
                    } label: {
                        Image(systemName: "pencil.circle")
                            .font(.title)
                            .foregroundColor(.orange)
                    }
                }
                .padding()
                
            }
            .frame(width: 340, height: 70)
            .padding()
            
            Spacer()
        }
        .sheet(isPresented: $viewModel.showSheet) {
            EditWeightView()
                .environmentObject(viewModel)
                .font(.largeTitle)
                .presentationDetents([.height(150)])
                .onDisappear {
                    viewModel.saveUserWeight()
                }
        }
    }
}

