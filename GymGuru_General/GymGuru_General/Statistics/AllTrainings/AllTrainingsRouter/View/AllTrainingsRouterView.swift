//
//  AllTrainingsRouterView.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 20.01.2024.
//

import SwiftUI

struct AllTrainingsRouterView: View {
    
    enum ShowTrainingsType {
        case list, calendar
    }
    
    @State var showTrainingType = ShowTrainingsType.list
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        showTrainingType = ShowTrainingsType.list
                    } label: {
                        Text("List")
                    }
                    
                    Button {
                        showTrainingType = ShowTrainingsType.calendar
                    } label: {
                        Text("Calendar")
                    }
                }
                
                if showTrainingType == .list {
                    ListOfTrainings()
                } else {
                    Text("Calendar")
                }
                
                  
                Spacer()
            }
        }
    }
}

#Preview {
    AllTrainingsRouterView()
}
