//
//  DataService.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/7/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit

class DataService {
    
    static let instance = DataService()
    
    private let defaultImage = UIImage(named: "Routine_btn_dark")!
    
    private let user = User(firstName: "Héctor", lastName: "Fragoso", image: UIImage(named: "User_btn_dark")!, birhdate: Date("1989/12/31"), gender: .male)
    
    private let routine = Routine(withName: "Rutina 1", image: UIImage(named: "Weights_image")!, startDate: Date("2020/02/17"), endDate: Date("2020/03/17"), owner: User(firstName: "Héctor", lastName: "Fragoso", image: UIImage(named: "User_btn_dark")!, birhdate: Date("1989/12/31"), gender: .male), days:
        [
            [
                ExerciseGroup(withName: "Pierna", andDrills:
                [
                    (4, Drill(withExercise: Exercise(withName: "Sentadilla Perfecta", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 12, andWeight: 70)),
                    (4, Drill(withExercise: Exercise(withName: "Desplante caminando C/P", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 20, andWeight: 4)),
                    (4, Drill(withExercise: Exercise(withName: "Sentadilla Zorro C/K", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 24)),
                    (4, Drill(withExercise: Exercise(withName: "Abductor-Aductor", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 60)),
                    (4, Drill(withExercise: Exercise(withName: "Extensión Ind-Sim", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 12, andWeight: 50)),
                    (4, Drill(withExercise: Exercise(withName: "Flex Rodilla 20-10", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 20, andWeight: 50))
                ])
            ],
            [
                ExerciseGroup(withName: "Hombros", andDrills:
                    [
                        (4, Drill(withExercise: Exercise(withName: "Press Neutro alternado con mancuerna", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 20, andWeight: 20)),
                        (4, Drill(withExercise: Exercise(withName: "Lateral con mancuernas 21", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 21, andWeight: 10)),
                        (4, Drill(withExercise: Exercise(withName: "Elevación frontal con barra Z", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: ["Prono","Supino"]), reps: 15, andWeight: 50)),
                        (4, Drill(withExercise: Exercise(withName: "Remo vertical con barra Z", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 70))
                    ]
                ),
                ExerciseGroup(withName: "Triceps", andDrills:
                    [
                        (4, Drill(withExercise: Exercise(withName: "Copa con 2 mancuernas incl.", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 20)),
                        (4, Drill(withExercise: Exercise(withName: "Extensión Polea alta", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 40)),
                        (4, Drill(withExercise: Exercise(withName: "Extensión máquina", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 30)),
                        (4, Drill(withExercise: Exercise(withName: "Patada con barra Z", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 70))
                    ]
                )
            ],
            [
                ExerciseGroup(withName: "Hombros", andDrills:
                    [
                        (4, Drill(withExercise: Exercise(withName: "Press Neutro alternado con mancuerna", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 20, andWeight: 20)),
                        (4, Drill(withExercise: Exercise(withName: "Lateral con mancuernas 21", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 21, andWeight: 10)),
                        (4, Drill(withExercise: Exercise(withName: "Elevación frontal con barra Z", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: ["Prono","Supino"]), reps: 15, andWeight: 50)),
                        (4, Drill(withExercise: Exercise(withName: "Remo vertical con barra Z", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 70))
                    ]
                ),
                ExerciseGroup(withName: "Triceps", andDrills:
                    [
                        (4, Drill(withExercise: Exercise(withName: "Copa con 2 mancuernas incl.", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 20)),
                        (4, Drill(withExercise: Exercise(withName: "Extensión Polea alta", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 40)),
                        (4, Drill(withExercise: Exercise(withName: "Extensión máquina", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 30)),
                        (4, Drill(withExercise: Exercise(withName: "Patada con barra Z", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 70))
                    ]
                )
            ],
            [
                ExerciseGroup(withName: "Hombros", andDrills:
                    [
                        (4, Drill(withExercise: Exercise(withName: "Press Neutro alternado con mancuerna", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 20, andWeight: 20)),
                        (4, Drill(withExercise: Exercise(withName: "Lateral con mancuernas 21", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 21, andWeight: 10)),
                        (4, Drill(withExercise: Exercise(withName: "Elevación frontal con barra Z", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: ["Prono","Supino"]), reps: 15, andWeight: 50)),
                        (4, Drill(withExercise: Exercise(withName: "Remo vertical con barra Z", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 70))
                    ]
                ),
                ExerciseGroup(withName: "Triceps", andDrills:
                    [
                        (4, Drill(withExercise: Exercise(withName: "Copa con 2 mancuernas incl.", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 20)),
                        (4, Drill(withExercise: Exercise(withName: "Extensión Polea alta", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 40)),
                        (4, Drill(withExercise: Exercise(withName: "Extensión máquina", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 30)),
                        (4, Drill(withExercise: Exercise(withName: "Patada con barra Z", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 70))
                    ]
                )
            ]
    ], andWeekdays: nil)
    
    
//    private let categories = [
//        Category(title: "SHIRTS", imageName: "shirts.png"),
//        Category(title: "HODDIES", imageName: "hoodies.png"),
//        Category(title: "HATS", imageName: "hats.png"),
//        Category(title: "DIGITAL", imageName: "digital.png")
//    ]
//    
//    func getCategories() -> [Category] {
//        return categories
//    }
    
    func getUser() -> User {
        return user
    }
    
    func getRoutine() -> Routine {
        return routine
    }
    
    private let exercises = ["Sentadilla Perfecta", "Desplante caminando C/P", "Sentadilla Zorro C/K", "Abductor-Aductor", "Extensión Ind-Sim", "Flex Rodilla 20-10"]
    private let reps = ["12", "20", "15", "15", "12", "20-10"]
    private let drills = ["4", "4", "4", "4", "4", "4"]
}
