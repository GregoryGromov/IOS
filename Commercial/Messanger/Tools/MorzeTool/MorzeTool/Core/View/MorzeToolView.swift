//
//  MorzeToolView.swift
//  MorzeTool
//
//  Created by Григорий Громов on 08.02.2024.
//

import SwiftUI

struct MorzeToolView: View {
    
    @State var morzeCode = ""
    var decodedText: String {
        
        var morzeString = ""
        
        for char in morzeCode {
            if char == "0" {
                morzeString += "."
            } else if char == "1" {
                morzeString += "-"
            } else if char == "/" {
                morzeString += "  "
            }
        }
        
        return morzeString
    }
    
    @State private var startTime: Date?
    @State private var endTime: Date?
    @State private var elapsedTime: TimeInterval = 0
    
    @State private var dragState = CGSize.zero
    
    @State var messagesArray = [String]()
    
    let coder = MorzeService()
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 100) {
                
                Text(morzeCode)
                Text(decodedText)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("\(elapsedTime, specifier: "%.2f") seconds")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 15.0).fill(.cyan)
                            .frame(width: 200, height: 150)
                    }
                    .padding()
                    .gesture(
                        DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onChanged { value in
                                if startTime == nil {
                                    startTime = Date()
                                }
                            }
                            .onEnded { value in
                                endTime = Date()
                                let xOffset = value.translation.width
                                let yOffset = value.translation.height
                                print(xOffset)
                                if let start = startTime, let end = endTime {
                                    elapsedTime = end.timeIntervalSince(start)
                                    if xOffset < -20 {
                                        print("Стираем")
                                        if !morzeCode.isEmpty {
                                            let lastIndex = morzeCode.index(before: morzeCode.endIndex)
                                            morzeCode.remove(at: lastIndex)
                                        }
                                    } else if xOffset > 20 {
                                        print("Пробел")
                                        morzeCode.append("/")
                                    } else if yOffset < -30 {
                                        print("Отправляем")
                                        messagesArray.append(morzeCode)
                                        morzeCode = ""
                                    } else {
                                        if elapsedTime > 0.25 {
                                            morzeCode += "1"
                                        } else {
                                            morzeCode += "0"
                                        }
                                    }
                                }
                                startTime = nil
                            }
                    )
                
                
                ScrollView {
                    ForEach(messagesArray, id: \.self) { message in
                        HStack {
                            Text(message)
                                .foregroundColor(.white)
                            Spacer()
                            Text(coder.morzeDecoder(message2: message))
                        }
                        .padding()
                    }
                }
                .background(Color.cyan)
                
            }
            .navigationTitle("MorzeTool")
        }
    }
}

