//
//  FileManager.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 20.01.2024.
//

import Foundation
import SwiftUI

class LocalFireManager {
    
    static let shared = LocalFireManager()
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        //Создаем папку
        createFolderIfNeeded(folderName: folderName)
        
        
        //Получаем путь для хранения изображения
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
        else { return }
        
        //Сохраняем изображение
        do {
            try data.write(to: url)
        } catch {
            print("Error saving image to FileManager: \(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path)
        else { return nil }
        return UIImage(contentsOfFile: url.path)
    }
     
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating directory with FileManager: \(error)")
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        
        guard let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first else { return nil }
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
    
}
