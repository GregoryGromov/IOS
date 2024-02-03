//
//  ComplitedTrainingView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 20.01.2024.
//

import SwiftUI

struct ComplitedTrainingView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var training: Training
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left.circle.fill") // set image here
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .font(.title)
                }
                Spacer()
                Text("Trainings")
                    .font(.title)
                    .fontWeight(.bold)
                    .offset(x: -15)
                Spacer()
            }
            .padding()
            ScrollView(showsIndicators: false) {
                VStack {
                    
                    HStack {
                        Text("\(training.date.formatted(.dateTime.day().month()))")
                            .font(.title)
                            
                        Spacer()
                        Text("\(Int(training.duration / 60)) min")
                            .font(.title3)
                    }
                    .padding()
                    .fontWeight(.bold)
                    
                    
                    ForEach(training.exercises) { exercise in
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color("ColorGray"))
                            HStack {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(exercise.name)
                                            .font(.title3)
                                        Spacer()
                                    }
                                    
                                    Spacer()
                                }
                               
                                    
                                    VStack(alignment: .leading) {
                                        ForEach(exercise.sets.sorted {$0.weight < $1.weight}) { set_ in
                                         
                                                
                                                if exercise.isBodyweight {
                                                    Text("x ") +
                                                    Text("\(set_.amount)")
                                                        .fontWeight(.bold)
                                                } else {
                                                    Text("\(String(format: "%.1f", set_.weight))")
                                                        .fontWeight(.bold) +
                                                    Text(" kg x ") +
                                                    Text("\(set_.amount)")
                                                        .fontWeight(.bold)
                                                }
                                            }
                                            .font(.title3)
                                    }
                                    .padding(.trailing, 20)
                                    
                                
                            }
                            .padding()
                            .frame(height: 100)
                        }
                    
                        
                    }
                    
                        
                      
                    }
                .navigationBarHidden(true)
                }
                .padding()
        }
        
        }
    }


