//
//  DataService.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/7/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit
import CoreData

class DataService {
    
    static let instance = DataService()
    
    private let defaultImage = UIImage(named: "Routine_btn_dark")!
    
    private let user = User(withFirstName: "Héctor", lastName: "Fragoso", image: UIImage(named: "User_btn_dark")!, birthdate: Date("1989/12/31"), height: Height(withMValue: 1.75), weight: Weight(withKgValue: 80.1), andGender: .male)
    
    private let routine = Routine(withName: "Rutina 1", image: UIImage(named: "Weights_image")!, startDate: Date("2020/02/17"), endDate: Date("2020/03/17"), owner: User(withFirstName: "Héctor", lastName: "Fragoso", image: UIImage(named: "User_btn_dark")!, birthdate: Date("1989/12/31"), height: Height(withMValue: 1.75), weight: Weight(withKgValue: 80.1), andGender: .male), days:
        [
            [
                ExerciseGroup(withName: "Hombros", andDrills:
                    [
                        (4, Drill(withExercise: Exercise(withName: "Press Neutro alternado con mancuerna", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .delts, equipment: Equipment(withName: "Mancuerna", description: "", image: UIImage(named: "dumbbell_icon_white"), andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 20, andWeight: 15)),
                        (4, Drill(withExercise: Exercise(withName: "Lateral con mancuernas 21", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .traps, equipment: Equipment(withName: "Mancuerna", description: "", image: UIImage(named: "dumbbell_icon_white"), andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 21, andWeight: 10)),
                        (4, Drill(withExercise: Exercise(withName: "Elevación frontal con barra Z", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .delts, equipment: Equipment(withName: "Barra Z", description: "", image: UIImage(named: "Z_bar_icon_white"), andMuscleGroups:nil), dificulty: nil, variations: ["Prono","Supino"]), reps: 15, andWeight: 40)),
                        (4, Drill(withExercise: Exercise(withName: "Remo vertical con barra Z", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .traps, equipment: Equipment(withName: "Barra Z", description: "", image: UIImage(named: "Z_bar_icon_white"), andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 15, andWeight: 40))
                    ]
                ),
                ExerciseGroup(withName: "Triceps", andDrills:
                    [
                        (4, Drill(withExercise: Exercise(withName: "Copa con 2 mancuernas incl.", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .triceps, equipment: Equipment(withName: "Mancuerna", description: "", image: UIImage(named: "dumbbell_icon_white")!, andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 15, andWeight: 20)),
                        (4, Drill(withExercise: Exercise(withName: "Extensión Polea alta", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .triceps, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 40)),
                        (4, Drill(withExercise: Exercise(withName: "Extensión máquina", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .triceps, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 40)),
                        (4, Drill(withExercise: Exercise(withName: "Patada con barra Z", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .triceps, equipment: Equipment(withName: "Barra Z", description: "", image: UIImage(named: "Z_bar_icon_white")!, andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 15, andWeight: 40))
                    ]
                )
            ],
            [
                ExerciseGroup(withName: "Espalda (20-12-12-20)", andDrills:
                    [
                        (4, Drill(withExercise: Exercise(withName: "Pulldown neutro", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .lats, equipment: nil, dificulty: nil, variations: nil), reps: 20, andWeight: 70)),
                        (4, Drill(withExercise: Exercise(withName: "Remo sentado", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .back, equipment: nil, dificulty: nil, variations: nil), reps: 20, andWeight: 60)),
                        (4, Drill(withExercise: Exercise(withName: "Pullover polea alta", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .lats, equipment: nil, dificulty: nil, variations: ["Prono","Supino"]), reps: 20, andWeight: 60)),
                        (4, Drill(withExercise: Exercise(withName: "Remo pronunciado con barra Z", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .back, equipment: Equipment(withName: "Barra Z", description: "", image: UIImage(named: "Z_bar_icon_white")!, andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 20, andWeight: 40)),
                        (4, Drill(withExercise: Exercise(withName: "Jalón supino con barra alta", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .lats, equipment: nil, dificulty: nil, variations: nil), reps: 20, andWeight: 60)),
                        (4, Drill(withExercise: Exercise(withName: "Dominadas asistidas (P)", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .lats, equipment: Equipment(withName: "Barra Z", description: "", image: UIImage(named: "Z_bar_icon_white")!, andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 20, andWeight: 30))
                    ]
                ),
                ExerciseGroup(withName: "Abs", andDrills:
                    [
                        (3, Drill(withExercise: Exercise(withName: "Rotación de piernas sobre balón", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .oblique, equipment: nil, dificulty: nil, variations: nil), reps: 20, andWeight: nil)),
                        (3, Drill(withExercise: Exercise(withName: "Crunch con balón", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: Equipment(withName: "Pelota", description: "", image: UIImage(named: "fitness-ball_icon_white")!, andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 20, andWeight: 4)),
                        (3, Drill(withExercise: Exercise(withName: "Crunches en pelota suiza", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: Equipment(withName: "Pelota", description: "", image: UIImage(named: "fitness-ball_icon_white")!, andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 20, andWeight: nil))
                    ]
                )
            ],
            [
                ExerciseGroup(withName: "Pecho", andDrills:
                    [
                        (4, Drill(withExercise: Exercise(withName: "Press inclinado", description: "Iniciar en el pecho tocando clavívulas y subir manteniendo codos apuntando al frente", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .pecs, equipment: Equipment(withName: "Mancuerna", description: "", image: UIImage(named: "dumbbell_icon_white")!, andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 20, andWeight: 20)),
                        (4, Drill(withExercise: Exercise(withName: "Press Iso máquina 2X1-5", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .pecs, equipment: nil, dificulty: nil, variations: nil), reps: 21, andWeight: 10)),
                        (4, Drill(withExercise: Exercise(withName: "Pec Fly", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .pecs, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 50)),
                        (4, Drill(withExercise: Exercise(withName: "Press horizontal con disco", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .pecs, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 70))
                    ]
                ),
                ExerciseGroup(withName: "Biceps", andDrills:
                    [
                        (4, Drill(withExercise: Exercise(withName: "Curl 10-10-10", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .biceps, equipment: Equipment(withName: "Mancuerna", description: "", image: UIImage(named: "dumbbell_icon_white")!, andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 15, andWeight: 20)),
                        (4, Drill(withExercise: Exercise(withName: "Curl máquina", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .biceps, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 40)),
                        (4, Drill(withExercise: Exercise(withName: "Curl polea baja", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .biceps, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 30)),
                        (4, Drill(withExercise: Exercise(withName: "Curl polea alta (lazo)", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 70)),
                        (4, Drill(withExercise: Exercise(withName: "Curl barra recta", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: Equipment(withName: "Barra plana", description: "", image: UIImage(named: "dumbbellBar_icon_white")!, andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 15, andWeight: 70))
                    ]
                )
            ]
    ], andWeekdays:
    [
        .monday:
        [
            ExerciseGroup(withName: "Pierna", andDrills:
            [
                (4, Drill(withExercise: Exercise(withName: "Sentadilla Perfecta", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 12, andWeight: 70)),
                (4, Drill(withExercise: Exercise(withName: "Desplante caminando", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .hams, equipment: Equipment(withName: "Pelota", description: "", image: UIImage(named: "fitness-ball_icon_white"), andMuscleGroups: nil), dificulty: nil, variations: nil), reps: 20, andWeight: 4)),
                (4, Drill(withExercise: Exercise(withName: "Sentadilla Zorro", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .hams, equipment: Equipment(withName: "Kettlebell", description: "", image: UIImage(named: "kettlebell_icon_white"), andMuscleGroups: nil), dificulty: nil, variations: nil), reps: 15, andWeight: 24)),
                (4, Drill(withExercise: Exercise(withName: "Abductor-Aductor", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 15, andWeight: 60)),
                (4, Drill(withExercise: Exercise(withName: "Extensión Ind-Sim", description: "Realizar 12 con cada pierna (peso medio) y 12 con ambas (peso alto)", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 12, andWeight: 50)),
                (4, Drill(withExercise: Exercise(withName: "Flex Rodilla 20-10", description: "Hacer 20 repeticiones con peso medio y 10 con peso alto", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .hams, equipment: nil, dificulty: nil, variations: nil), reps: 20, andWeight: 50))
            ]),
            ExerciseGroup(withName: "Pantorrilla", andDrills:
            [
                (3, Drill(withExercise: Exercise(withName: "Costurera", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .calves, equipment: nil, dificulty: nil, variations: nil), reps: 25, andWeight: 45)),
                (3, Drill(withExercise: Exercise(withName: "Flex Plantar", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .calves, equipment: Equipment(withName: "Máquina", description: "", image: UIImage(named: "gym_machine_icon_white"), andMuscleGroups: [MuscleGroup.undefined]), dificulty: nil, variations: nil), reps: 20, andWeight: 60))
            ])
        ]
    ])
 
    private let equipmentOptions = [
        "ZBar": Equipment(withName: "Barra Z", description: "", image: UIImage(named: "Z_bar_icon_white")!, andMuscleGroups:
            [
                MuscleGroup.biceps,
                MuscleGroup.pecs,
                MuscleGroup.back,
                MuscleGroup.biceps,
                MuscleGroup.forearms,
                MuscleGroup.lats,
                MuscleGroup.triceps,
                MuscleGroup.delts
            ]
        ),
        "D_bar": Equipment(withName: "Barra plana", description: "", image: UIImage(named: "dumbbellBar_icon")!, andMuscleGroups:
            [
                MuscleGroup.biceps,
                MuscleGroup.pecs,
                MuscleGroup.back,
                MuscleGroup.biceps,
                MuscleGroup.forearms,
                MuscleGroup.lats,
                MuscleGroup.triceps,
                MuscleGroup.delts
            ]
        ),
        "Dumbell": Equipment(withName: "Mancuerna", description: "", image: UIImage(named: "dumbbell_icon_white")!, andMuscleGroups:
            [
                MuscleGroup.biceps,
                MuscleGroup.pecs,
                MuscleGroup.back,
                MuscleGroup.biceps,
                MuscleGroup.forearms,
                MuscleGroup.lats,
                MuscleGroup.triceps,
                MuscleGroup.delts,
                MuscleGroup.traps,
                MuscleGroup.quads,
                MuscleGroup.calves
            ]
        ),
        "KettleBell": Equipment(withName: "KettleBell", description: "", image: UIImage(named: "kettlebell_icon_white")!, andMuscleGroups:
            [
                MuscleGroup.biceps,
                MuscleGroup.pecs,
                MuscleGroup.back,
                MuscleGroup.biceps,
                MuscleGroup.forearms,
                MuscleGroup.lats,
                MuscleGroup.triceps,
                MuscleGroup.quads,
                MuscleGroup.calves,
                MuscleGroup.traps,
                MuscleGroup.delts,
                MuscleGroup.glutes
            ]
        ),
        "Machine": Equipment(withName: "Máquina", description: "", image: UIImage(named: "gym_machine_icon_white")!, andMuscleGroups: [MuscleGroup.undefined]
        ),
        "Ball": Equipment(withName: "Pelota", description: "", image: UIImage(named: "fitness-ball_icon_white")!, andMuscleGroups:
            [
                MuscleGroup.biceps,
                MuscleGroup.pecs,
                MuscleGroup.back,
                MuscleGroup.biceps,
                MuscleGroup.forearms,
                MuscleGroup.lats,
                MuscleGroup.triceps,
                MuscleGroup.quads,
                MuscleGroup.calves,
                MuscleGroup.traps,
                MuscleGroup.delts,
                MuscleGroup.glutes,
                MuscleGroup.lowerAbs,
                MuscleGroup.upperAbs,
                MuscleGroup.oblique
            ]
        ),
    ]

    
    // MARK: - CoreDataManagement
    
    func createData() {
        // Refer to container in AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        //Create a context from container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Create entity
        let exerciseEntity = NSEntityDescription.entity(forEntityName: "Exercise", in: managedContext)!
        
        //
        let exercise = NSManagedObject(entity: exerciseEntity, insertInto: managedContext)
        exercise.setValue("Rotación de piernas sobre balón", forKey: "name")
        if let imageData = UIImage(named: "Routine_btn_dark")?.pngData() {
            exercise.setValue(imageData, forKey: "image")
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Couldn't save. \(error), \(error.userInfo)")
        }
        
    }
    
    
    
    func createUserInfo() {
        if !checkIfUserDataExists() {
            
            let managedContext = AppDelegate.viewContext
            
            let currentUser = ManagedUser(context:managedContext)
            /*
            currentUser.firstName = "Héctor"
            currentUser.lastName = "Fragoso"
            currentUser.dateOfBirth = Date("1989-12-31")
            */
        }
        return
    }
    
    private func fetchInformation(for entity:String) -> [NSManagedObject]? {
        
        //Create a context from container
        let managedContext = AppDelegate.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            return result as? [NSManagedObject]
        } catch {
            print("Unable to retrieve information for entity: \(entity)")
            return nil
        }
        
    }
    
    func checkIfCurrentRoutineExists() -> Bool {
        return fetchInformation(for: "Routine")?.count ?? 0 > 0
    }
    
    func checkIfUserDataExists() -> Bool {
        return fetchInformation(for: "User")?.count ?? 0 > 0
    }
    
    func getUser() -> User {
        return user
    }
    
    func getRoutine() -> Routine {
        return routine
    }
    
    func getEquipment() -> [String:Equipment] {
        return equipmentOptions
    }

    private let exercises = ["Sentadilla Perfecta", "Desplante caminando C/P", "Sentadilla Zorro C/K", "Abductor-Aductor", "Extensión Ind-Sim", "Flex Rodilla 20-10"]
    private let reps = ["12", "20", "15", "15", "12", "20-10"]
    private let drills = ["4", "4", "4", "4", "4", "4"]
}
