//
//  ControlWidgetView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 19.12.2023.
//

import SwiftUI

struct MainControlWidget: View {
    
    @EnvironmentObject var viewModel: TrainingRouter
    

    
    
    //Вынести в vm
    
    @State var selectedProgram: Program?
    @State var alreadySelected = false
    
    
    
    var body: some View {
        
        
        
        VStack {
            
            VStack {
                HStack(alignment: .top) {
                    
                    
                    
                    Spacer()
                    
                    Text("00:00")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    
                }
                .padding()
                .padding(.horizontal, 26)
                .padding(.bottom, 0)
                HStack {
                    Spacer()
                    Button {
                        
                        viewModel.startTraining()
                        
                        
                    } label: {
                        Text("Начать")
                            .frame(width: 280, height: 30)
                            .foregroundColor(.black)
                            .font(.title2)
                            .padding(10)
//                            .background(Color(red: 0.85, green: 0.85, blue: 0.85))
//                            .cornerRadius(15)
                            .background(
                                RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color("ColorGray3"))
                            )
                        
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
                    
            }
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color.white)
            )
            .padding()
            
            
            HStack {
                Text("Choose program")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            .padding()
            
            
            
            VStack {
                ForEach(Program.ProgramsMOCK) { program in
                    HStack {
                        Text(program.name)
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(program.exercises.count) exercises")
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous).fill(program.id == selectedProgram?.id ? Color("ColorGray2") : Color("ColorGray"))
                    )
                    .onTapGesture {
                        if alreadySelected && program.id == selectedProgram?.id {
                            alreadySelected = false
                            selectedProgram = nil
                        } else {
                            alreadySelected = true
                            selectedProgram = program
                        }
                        
                        
                    }
                    .padding(.top, 4)
                    .padding(.horizontal)
                    
                }
            }
            
            Spacer()
            
            
        }
       
    }
}

