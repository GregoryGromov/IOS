//
//  DataMOCK.swift
//  GymGuru_General
//
//  Created by Григорий Громов on 14.01.2024.
//

import Foundation

class DataMOCK {
    
    static let shared = DataMOCK()
    
    //18 штук
    static let SetsMOCK = [
        Set(id: UUID().uuidString, date: Date(), weight: 50, amount: 12), //0
        Set(id: UUID().uuidString, date: Date(), weight: 50, amount: 8),
        Set(id: UUID().uuidString, date: Date(), weight: 50, amount: 6),
        Set(id: UUID().uuidString, date: Date(), weight: 20, amount: 12),
        Set(id: UUID().uuidString, date: Date(), weight: 20, amount: 8), //4
        Set(id: UUID().uuidString, date: Date(), weight: 20, amount: 6),
        Set(id: UUID().uuidString, date: Date(), weight: 70, amount: 12),
        Set(id: UUID().uuidString, date: Date(), weight: 70, amount: 8),
        Set(id: UUID().uuidString, date: Date(), weight: 70, amount: 6),
        Set(id: UUID().uuidString, date: Date(), weight: 15, amount: 12), //9
        Set(id: UUID().uuidString, date: Date(), weight: 15, amount: 8),
        Set(id: UUID().uuidString, date: Date(), weight: 15, amount: 6),
        Set(id: UUID().uuidString, date: Date(), weight: 90, amount: 12),
        Set(id: UUID().uuidString, date: Date(), weight: 90, amount: 8),
        Set(id: UUID().uuidString, date: Date(), weight: 90, amount: 6), //14
        Set(id: UUID().uuidString, date: Date(), weight: 100, amount: 12),
        Set(id: UUID().uuidString, date: Date(), weight: 100, amount: 8),
        Set(id: UUID().uuidString, date: Date(), weight: 100, amount: 6),
        Set(id: UUID().uuidString, date: Date(), weight: 100, amount: 6),
        Set(id: UUID().uuidString, date: Date(), weight: 40, amount: 12),
        Set(id: UUID().uuidString, date: Date(), weight: 40, amount: 8), //20
        Set(id: UUID().uuidString, date: Date(), weight: 40, amount: 6),
        Set(id: UUID().uuidString, date: Date(), weight: 30, amount: 12),
        Set(id: UUID().uuidString, date: Date(), weight: 30, amount: 8), //23
        Set(id: UUID().uuidString, date: Date(), weight: 30, amount: 6),
        Set(id: UUID().uuidString, date: Date(), weight: 130, amount: 6),
        Set(id: UUID().uuidString, date: Date(), weight: 130, amount: 6),
        Set(id: UUID().uuidString, date: Date(), weight: 130, amount: 6),
    ]
    
    
//    let TrainingsMOCKforTime: [Training] = [
//        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-86400),
//                 dateEnd: Date.now.addingTimeInterval(-86200),
//                duration: 1920,
//                 exercises: [
//                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
//                        SetsMOCK[10],
//                        SetsMOCK[2],
//                        SetsMOCK[17]
//                    ]),
//                    Exercise(id: UUID().uuidString, name: "Присед", muscleGroup: ["Legs", "Back"], isBodyweight: false, sets: [
//                        SetsMOCK[13],
//                        SetsMOCK[2],
//                    ]),
//                    
//                 ]),
//        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-86300),
//                 dateEnd: Date.now.addingTimeInterval(-86200),
//                duration: 1920,
//                 exercises: [
//                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
//                        SetsMOCK[10],
//                        SetsMOCK[2],
//                        SetsMOCK[17]
//                    ]),
//                    Exercise(id: UUID().uuidString, name: "Присед", muscleGroup: ["Legs", "Back"], isBodyweight: false, sets: [
//                        SetsMOCK[13],
//                        SetsMOCK[2],
//                    ]),
//                    
//                 ]),
//        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-86400),
//                 dateEnd: Date.now.addingTimeInterval(-86100),
//                duration: 1920,
//                 exercises: [
//                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
//                        SetsMOCK[10],
//                        SetsMOCK[2],
//                        SetsMOCK[17]
//                    ]),
//                    Exercise(id: UUID().uuidString, name: "Присед", muscleGroup: ["Legs", "Back"], isBodyweight: false, sets: [
//                        SetsMOCK[13],
//                        SetsMOCK[2],
//                    ]),
//                    
//                 ]),
//        
////        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-359200),
////                 dateEnd: Date.now.addingTimeInterval(-358200), duration: 2820,
////                 exercises: [
////                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
////                        SetsMOCK[5],
////                        SetsMOCK[13]
////                    ]),
////                    Exercise(id: UUID().uuidString, name: "Присед", muscleGroup: ["Legs", "Back"], isBodyweight: false, sets: [
////                        SetsMOCK[9],
////                        SetsMOCK[7],
////                    ]),
////                 ]),
////        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-431000),
////                 dateEnd: Date.now.addingTimeInterval(-430000),
////                 duration: 3240,
////                 exercises: [
////                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
////                        SetsMOCK[3],
////                        SetsMOCK[0],
////                        SetsMOCK[7]
////                    ])
////                 ]),
////        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-704800),
////                 dateEnd: Date.now.addingTimeInterval(-703800),duration: 4240,
////                 exercises: [
////                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
////                        SetsMOCK[5],
////                        SetsMOCK[3],
////                        SetsMOCK[0]
////                    ])
////                 ]),
////        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-804800),
////                 dateEnd: Date.now.addingTimeInterval(-803800),
////                 duration: 940,
////                 exercises: [
////                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
////                        SetsMOCK[5],
////                        SetsMOCK[3],
////                        SetsMOCK[0]
////                    ]),
////                    Exercise(id: UUID().uuidString, name: "Присед", muscleGroup: ["Legs", "Back"], isBodyweight: false, sets: [
////                        SetsMOCK[15],
////                        SetsMOCK[8],
////                    ]),
////                 ]),
////        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-904800),
////                 dateEnd: Date.now.addingTimeInterval(-903800),
////                 duration: 2240,
////                 exercises: [
////                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
////                        SetsMOCK[11],
////                        SetsMOCK[20],
////                    ])
////                 ]),
////        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-1004800),
////                 dateEnd: Date.now.addingTimeInterval(-1003800),duration: 1240,
////                 exercises: [
////                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
////                        SetsMOCK[11],
////                        SetsMOCK[23],
////                    ]),
////                    Exercise(id: UUID().uuidString, name: "Присед", muscleGroup: ["Legs", "Back"], isBodyweight: false, sets: [
////                        SetsMOCK[5],
////                        SetsMOCK[26],
////                    ]),
////                 ]),
//    ]
    
    
    
    let TrainingsMOCK: [Training] = [
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(0),
                 dateEnd: Date.now.addingTimeInterval(1000),
                duration: 1920,
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[10],
                        SetsMOCK[2],
                        SetsMOCK[17]
                    ]),
                    Exercise(id: UUID().uuidString, name: "Присед", muscleGroup: ["Legs", "Back"], isBodyweight: false, sets: [
                        SetsMOCK[13],
                        SetsMOCK[2],
                    ]),
                    
                 ]),
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-20000),
                 dateEnd: Date.now.addingTimeInterval(-20500), duration: 2820,
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[5],
                        SetsMOCK[13]
                    ]),
                    Exercise(id: UUID().uuidString, name: "Присед", muscleGroup: ["Legs", "Back"], isBodyweight: false, sets: [
                        SetsMOCK[9],
                        SetsMOCK[7],
                    ]),
                 ]),
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-431000),
                 dateEnd: Date.now.addingTimeInterval(-430000),
                 duration: 3240,
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[3],
                        SetsMOCK[0],
                        SetsMOCK[7],
                        SetsMOCK[3],
                        SetsMOCK[0],
                    ])
                 ]),
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-704800),
                 dateEnd: Date.now.addingTimeInterval(-703800),duration: 4240,
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[5],
                        SetsMOCK[3],
                        SetsMOCK[0]
                    ]),
                    Exercise(id: UUID().uuidString, name: "Тяга блока", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[5],
                        SetsMOCK[3],
                        SetsMOCK[0]
                    ]),
                    Exercise(id: UUID().uuidString, name: "Молот", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[3],
                        SetsMOCK[9],
                    ])
                 ]),
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-804800),
                 dateEnd: Date.now.addingTimeInterval(-803800),
                 duration: 940,
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[5],
                        SetsMOCK[3],
//                        SetsMOCK[0],
//                        SetsMOCK[26],
//                        SetsMOCK[9],
//                        SetsMOCK[3],
//                        SetsMOCK[0],
//                        SetsMOCK[26],
                    ]),
                    Exercise(id: UUID().uuidString, name: "Присед", muscleGroup: ["Legs", "Back"], isBodyweight: false, sets: [
                        SetsMOCK[15],
                        SetsMOCK[8],
                    ]),
                    Exercise(id: UUID().uuidString, name: "Молот", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[1],
                        SetsMOCK[13],
                    ])
                 ]),
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-904800),
                 dateEnd: Date.now.addingTimeInterval(-903800),
                 duration: 2240,
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[11],
                        SetsMOCK[20],
                        SetsMOCK[26],
                        SetsMOCK[9],
                    ])
                 ]),
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-1004800),
                 dateEnd: Date.now.addingTimeInterval(-1003800),duration: 1240,
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[11],
                        SetsMOCK[23],
                    ]),
                    Exercise(id: UUID().uuidString, name: "Присед", muscleGroup: ["Legs", "Back"], isBodyweight: false, sets: [
                        SetsMOCK[5],
                        SetsMOCK[26],
                    ]),
                 ]),
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-1104800),
                 dateEnd: Date.now.addingTimeInterval(-1103800),
                 duration: 2240,
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Молот", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[11],
                        SetsMOCK[20],
                        SetsMOCK[3],
                        SetsMOCK[0],
                        SetsMOCK[3],
                        SetsMOCK[0],
                    ])
                 ]),
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-704800),
                 dateEnd: Date.now.addingTimeInterval(-703800),duration: 4240,
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
  
                        SetsMOCK[0]
                    ]),
                    Exercise(id: UUID().uuidString, name: "Молот", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[3],
                        SetsMOCK[9],
                    ])
                 ]),
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-1404800),
                 dateEnd: Date.now.addingTimeInterval(-1403800),duration: 1240,
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Жим лежа", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[11],
                        SetsMOCK[23],
                    ]),
                    Exercise(id: UUID().uuidString, name: "Присед", muscleGroup: ["Legs", "Back"], isBodyweight: false, sets: [
                        SetsMOCK[5],
                        SetsMOCK[26],
                        SetsMOCK[5],
                        SetsMOCK[26],
 

                    ]),
                 ]),
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-1504800),
                 dateEnd: Date.now.addingTimeInterval(-1503800),
                 duration: 2240,
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Молот", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        SetsMOCK[11],
                        
                        SetsMOCK[0],
                        SetsMOCK[3],
                        SetsMOCK[0],
                    ])
                 ]),
        Training(id: UUID().uuidString, date: Date.now.addingTimeInterval(-2004800),
                 dateEnd: Date.now.addingTimeInterval(-2003800),
                 duration: 2240,
                 exercises: [
                    Exercise(id: UUID().uuidString, name: "Молот", muscleGroup: ["Chest", "Shoulders", "Arms"], isBodyweight: false, sets: [
                        
                        SetsMOCK[20],
                        SetsMOCK[3],
                        SetsMOCK[0],
                      
             
                    ])
                 ]),
    ]
    
}
