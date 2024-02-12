//
//  ControlWidgetView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 19.12.2023.
//

import SwiftUI

struct TrainingStartView: View {
    
    //%1 как лучше сделать этот момент: данные viewModel в качестве внешнего объекта нужна только для того, чтобы запустить тренировку. Минус этой реализации состоит в том, что мы в отдельный вью передаем вью модель другого вью.
    
    //Альтернативой служат реализации либо через Combine, чтобы RouterViewModel слушала какое-нибудь своство в TrainingViewModel, либо чтобы мы получали @EnvironmentObject и по хитрому передавали его в TrainingViewModel.
    
    //Но и та, и та реализации выглядет чересчур надуманными
    
    
    //Мое предложение, сделать так:
//    @EnvironmentObject var router: RouterViewModel
    
    let router: RouterViewModel
    @StateObject var viewModel: TrainingStartViewModel
    
    init(router: RouterViewModel) {
        self._viewModel = StateObject(wrappedValue: TrainingStartViewModel(router: router))
        self.router = router
    }
    
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
                        //router.startTraining()
                        viewModel.startTraining()
                    } label: {
                        Text("Начать")
                            .frame(width: 280, height: 30)
                            .foregroundColor(.black)
                            .font(.title2)
                            .padding(10)
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
            
            Spacer()
            
            
        }
        
    }
}

