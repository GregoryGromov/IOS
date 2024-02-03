//
//  ProfileViewModel.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 20.01.2024.
//

import SwiftUI
import PhotosUI

@MainActor
final class ProfileViewModel: ObservableObject {
    
    init() {
        if let profilePhoto = LocalFireManager.shared.getImage(imageName: "profile", folderName: "images") {
            self.selectedImage = profilePhoto
        } else {
            print("Ошибка загрузки фото профиля из FileManager")
        }
         
        let dataManager = AppStorageDataManager.shared
        
        if let userName = dataManager.getUserInfoString(key: "userName") {
            self.userName = userName
        }
        
        self.userWeight = dataManager.getUserInfoFloat(key: "userWeight")
}
    
    @Published private(set) var selectedImage: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    
    @Published var userName = ""
    @Published var userWeight: Float
    
    @Published var showSheet = false
    //@Published var userHeight: Float = 171
    
    func saveUserWeight() {
        AppStorageDataManager.shared.setUserInfo(key: "userWeight", data: userWeight)
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                    LocalFireManager.shared.saveImage(image: uiImage, imageName: "profile", folderName: "images")
                    return
                }
            }
        }
    }
}
