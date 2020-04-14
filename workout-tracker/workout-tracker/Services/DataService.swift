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
    
    private let user = User(withFirstName: "Héctor", lastName: "Fragoso",userName: "hfragoso", image: UIImage(named: "User_btn_dark")!, birthdate: Date("1989/12/31"), height: Height(withMValue: 1.75), weight: Weight(withKgValue: 80.1), andGender: .male)
    
    private let workoutTrackerUser = User(withFirstName: "Workout", lastName: "Tracker", userName: "workout-tracker", image: UIImage(named: "AppIcon")!, birthdate: Date("2020-03-01"), height: Height(withCmValue: 1.0), weight: Weight(withKgValue: 1.0), andGender: .undefined)
    
    private let routine = Routine(withName: "Gym beast", image: UIImage(named: "nopain")!, startDate: Date("2020/02/17"), endDate: Date("2020/04/17"), owner: User(withFirstName: "Héctor", lastName: "Fragoso",userName: "hfragoso", image: UIImage(named: "User_btn_dark")!, birthdate: Date("1989/12/31"), height: Height(withMValue: 1.75), weight: Weight(withKgValue: 80.1), andGender: .male), days:
        [
            [
                ExerciseGroup(withName: "Hombros", andDrills:
                    [
                        Drill(withExercise: Exercise(withName: "Press Neutro alternado con mancuerna", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .delts, equipment: Equipment(withName: "Mancuerna", description: "", image: UIImage(named: "dumbbell_icon_white"), type: .dumbells, andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 20, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 15)),
                        Drill(withExercise: Exercise(withName: "Lateral con mancuernas 21", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .traps, equipment: Equipment(withName: "Mancuerna", description: "", image: UIImage(named: "dumbbell_icon_white"), type: .dumbells, andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 21, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 10)),
                        Drill(withExercise: Exercise(withName: "Elevación frontal con barra Z", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .delts, equipment: Equipment(withName: "Barra Z", description: "", image: UIImage(named: "Z_bar_icon_white"), type: .bars, andMuscleGroups:nil), dificulty: nil, variations: ["Prono","Supino"]), reps: 15, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 40)),
                        Drill(withExercise: Exercise(withName: "Remo vertical con barra Z", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .traps, equipment: Equipment(withName: "Barra Z", description: "", image: UIImage(named: "Z_bar_icon_white"), type:.bars, andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 15, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 40))
                    ]
                ),
                ExerciseGroup(withName: "Triceps", andDrills:
                    [
                        Drill(withExercise: Exercise(withName: "Copa con 2 mancuernas incl.", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .triceps, equipment: Equipment(withName: "Mancuerna", description: "", image: UIImage(named: "dumbbell_icon_white")!, type: .dumbells, andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 15, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 20)),
                        Drill(withExercise: Exercise(withName: "Extensión Polea alta", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .triceps, equipment: nil, dificulty: nil, variations: nil), reps: 15, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 40)),
                        Drill(withExercise: Exercise(withName: "Extensión máquina", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .triceps, equipment: nil, dificulty: nil, variations: nil), reps: 15, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 40)),
                        Drill(withExercise: Exercise(withName: "Patada con barra Z", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .triceps, equipment: Equipment(withName: "Barra Z", description: "", image: UIImage(named: "Z_bar_icon_white")!, type: .bars, andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 15, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 40))
                    ]
                )
            ],
            [
                ExerciseGroup(withName: "Espalda (20-12-12-20)", andDrills:
                    [
                        Drill(withExercise: Exercise(withName: "Pulldown neutro", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .lats, equipment: nil, dificulty: nil, variations: nil), reps: 20, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 70)),
                        Drill(withExercise: Exercise(withName: "Remo sentado", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .back, equipment: nil, dificulty: nil, variations: nil), reps: 20, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 60)),
                        Drill(withExercise: Exercise(withName: "Pullover polea alta", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .lats, equipment: nil, dificulty: nil, variations: ["Prono","Supino"]), reps: 20, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 60)),
                        Drill(withExercise: Exercise(withName: "Remo pronunciado con barra Z", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .back, equipment: Equipment(withName: "Barra Z", description: "", image: UIImage(named: "Z_bar_icon_white")!, andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 20, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 40)),
                        Drill(withExercise: Exercise(withName: "Jalón supino con barra alta", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .lats, equipment: nil, dificulty: nil, variations: nil), reps: 20, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 60)),
                        Drill(withExercise: Exercise(withName: "Dominadas asistidas (P)", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .lats, equipment: Equipment(withName: "Barra Z", description: "", image: UIImage(named: "Z_bar_icon_white")!, andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 20, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 30))
                    ]
                ),
                ExerciseGroup(withName: "Abs", andDrills:
                    [
                        Drill(withExercise: Exercise(withName: "Rotación de piernas sobre balón", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .oblique, equipment: nil, dificulty: nil, variations: nil), reps: 20, numberOfDrills: 3, andWeightObject: nil),
                        Drill(withExercise: Exercise(withName: "Crunch con balón", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: Equipment(withName: "Pelota", description: "", image: UIImage(named: "fitness-ball_icon_white")!, andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 20, numberOfDrills: 3, andWeightObject: Weight(withKgValue: 4)),
                        Drill(withExercise: Exercise(withName: "Crunches en pelota suiza", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: Equipment(withName: "Pelota", description: "", image: UIImage(named: "fitness-ball_icon_white")!, andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 20, numberOfDrills: 3, andWeightObject: nil)
                    ]
                )
            ],
            [
                ExerciseGroup(withName: "Pecho", andDrills:
                    [
                        Drill(withExercise: Exercise(withName: "Press inclinado", description: "Iniciar en el pecho tocando clavívulas y subir manteniendo codos apuntando al frente", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .pecs, equipment: Equipment(withName: "Mancuerna", description: "", image: UIImage(named: "dumbbell_icon_white")!, andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 20, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 20)),
                        Drill(withExercise: Exercise(withName: "Press Iso máquina 2X1-5", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .pecs, equipment: nil, dificulty: nil, variations: nil), reps: 21, numberOfDrills: 4, andWeightObject: Weight(withLbValue:10)),
                        Drill(withExercise: Exercise(withName: "Pec Fly", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .pecs, equipment: nil, dificulty: nil, variations: nil), reps: 15, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 50)),
                        Drill(withExercise: Exercise(withName: "Press horizontal con disco", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .pecs, equipment: nil, dificulty: nil, variations: nil), reps: 15, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 70))
                    ]
                ),
                ExerciseGroup(withName: "Biceps", andDrills:
                    [
                        Drill(withExercise: Exercise(withName: "Curl 10-10-10", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .biceps, equipment: Equipment(withName: "Mancuerna", description: "", image: UIImage(named: "dumbbell_icon_white")!, andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 15, numberOfDrills: 4, andWeightObject: Weight(withLbValue:20)),
                        Drill(withExercise: Exercise(withName: "Curl máquina", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .biceps, equipment: nil, dificulty: nil, variations: nil), reps: 15, numberOfDrills: 4, andWeightObject:Weight(withLbValue: 40)),
                        Drill(withExercise: Exercise(withName: "Curl polea baja", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .biceps, equipment: nil, dificulty: nil, variations: nil), reps: 15, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 30)),
                        Drill(withExercise: Exercise(withName: "Curl polea alta (lazo)", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 15, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 70)),
                        Drill(withExercise: Exercise(withName: "Curl barra recta", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: Equipment(withName: "Barra plana", description: "", image: UIImage(named: "dumbbellBar_icon_white")!, andMuscleGroups:nil), dificulty: nil, variations: nil), reps: 15, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 70))
                    ]
                )
            ]
    ], andWeekdays:
    [
        .monday:
        [
            ExerciseGroup(withName: "Pierna", andDrills:
            [
                Drill(withExercise: Exercise(withName: "Sentadilla Perfecta", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 12, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 70)),
                Drill(withExercise: Exercise(withName: "Desplante caminando", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .hams, equipment: Equipment(withName: "Pelota", description: "", image: UIImage(named: "fitness-ball_icon_white"), andMuscleGroups: nil), dificulty: nil, variations: nil), reps: 20, numberOfDrills: 4, andWeightObject: Weight(withKgValue: 4)),
                Drill(withExercise: Exercise(withName: "Sentadilla Zorro", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .hams, equipment: Equipment(withName: "Kettlebell", description: "", image: UIImage(named: "kettlebell_icon_white"), andMuscleGroups: nil), dificulty: nil, variations: nil), reps: 15, numberOfDrills: 4, andWeightObject: Weight(withKgValue: 24)),
                Drill(withExercise: Exercise(withName: "Abductor-Aductor", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 15, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 60)),
                Drill(withExercise: Exercise(withName: "Extensión Ind-Sim", description: "Realizar 12 con cada pierna (peso medio) y 12 con ambas (peso alto)", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: nil, variations: nil), reps: 12, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 50)),
                Drill(withExercise: Exercise(withName: "Flex Rodilla 20-10", description: "Hacer 20 repeticiones con peso medio y 10 con peso alto", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .hams, equipment: nil, dificulty: nil, variations: nil), reps: 20, numberOfDrills: 4, andWeightObject: Weight(withLbValue: 50))
            ]),
            ExerciseGroup(withName: "Pantorrilla", andDrills:
            [
                Drill(withExercise: Exercise(withName: "Costurera", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .calves, equipment: nil, dificulty: nil, variations: nil), reps: 25, numberOfDrills: 3, andWeightObject: Weight(withLbValue: 45)),
                Drill(withExercise: Exercise(withName: "Flex Plantar", description: "", image: UIImage(named: "Routine_btn_dark")!, muscleGroup: .calves, equipment: Equipment(withName: "Máquina", description: "", image: UIImage(named: "gym_machine_icon_white"), andMuscleGroups: [MuscleGroup.undefined]), dificulty: nil, variations: nil), reps: 20, numberOfDrills: 3, andWeightObject: Weight(withLbValue: 60))
            ])
        ]
    ])
 
    private let topWorkouts = [
        WorkoutDay(withName: "Runner legs", image: UIImage(named: "runner")!, weekDay: nil, andExerciseGroups:
            [
                ExerciseGroup(withName: "Calentamiento", andDrills:
                    [
                    Drill(withExercise: Exercise(withName: "Elevación de rodilla", description: "Alternado", image: UIImage(named:"Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: .beginer, variations: nil), reps: 10, numberOfDrills: 1, andWeightObject: nil),
                    Drill(withExercise: Exercise(withName: "Rotación tobillo izquierdo", description: "", image: UIImage(named:"Routine_btn_dark")!, muscleGroup: .calves, equipment: nil, dificulty: .beginer, variations: nil), reps: 10, numberOfDrills: 1, andWeightObject: nil),
                    Drill(withExercise: Exercise(withName: "Rotación tobillo derecho", description: "", image: UIImage(named:"Routine_btn_dark")!, muscleGroup: .calves, equipment: nil, dificulty: .beginer, variations: nil), reps: 10, numberOfDrills: 1, andWeightObject: nil),
                    Drill(withExercise: Exercise(withName: "Flexión de rodillas", description: "Rodillas y tobillos juntos. Hacer flexión hasta 45 grados.", image: UIImage(named:"Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: .beginer, variations: nil), reps: 10, numberOfDrills: 1, andWeightObject: nil),
                    Drill(withExercise: Exercise(withName: "Extensión de cuadríceps", description: "Alternar: Mantener un pie en el suelo y el otro acercarlo al glúteo. La rodilla del pie que se levanta debe apuntar al suelo.", image: UIImage(named:"Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: .beginer, variations: nil), reps: 10, numberOfDrills: 1, andWeightObject: nil)
                    ]),
                ExerciseGroup(withName: "Cuadríceps", andDrills:
                    [
                        Drill(withExercise: Exercise(withName: "Squat", description: "", image: UIImage(named:"Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: .beginer, variations: nil), reps: 15, numberOfDrills: 3, andWeightObject: nil),
                    ]),
                ExerciseGroup(withName: "Pantorrillas", andDrills:
                [
                    Drill(withExercise: Exercise(withName: "Squat", description: "", image: UIImage(named:"Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: .beginer, variations: nil), reps: 15, numberOfDrills: 3, andWeightObject: nil),
                ])
        ]),
        WorkoutDay(withName: "Beach Body", image: UIImage(named: "beach_body")!, weekDay: nil, andExerciseGroups:
            [
                ExerciseGroup(withName: "Cuadríceps", andDrills:
                [
                    Drill(withExercise: Exercise(withName: "Squat", description: "", image: UIImage(named:"Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: .beginer, variations: nil), reps: 15, numberOfDrills: 3, andWeightObject: nil),
                ]),
                ExerciseGroup(withName: "Cuadríceps", andDrills:
                [
                    Drill(withExercise: Exercise(withName: "Squat", description: "", image: UIImage(named:"Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: .beginer, variations: nil), reps: 15, numberOfDrills: 3, andWeightObject: nil),
                ])
            ]),
        WorkoutDay(withName: "Yoga morning", image: UIImage(named: "yoga")!, weekDay: nil, andExerciseGroups:
            [
                ExerciseGroup(withName: "Cuadríceps", andDrills:
                [
                    Drill(withExercise: Exercise(withName: "Squat", description: "", image: UIImage(named:"Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: .beginer, variations: nil), reps: 15, numberOfDrills: 3, andWeightObject: nil),
                ]),
                ExerciseGroup(withName: "Cuadríceps", andDrills:
                [
                    Drill(withExercise: Exercise(withName: "Squat", description: "", image: UIImage(named:"Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: .beginer, variations: nil), reps: 15, numberOfDrills: 3, andWeightObject: nil),
                ]),
            ]),
        WorkoutDay(withName: "No1. Runner", image: UIImage(named: "reach_goal")!, weekDay: nil, andExerciseGroups:
            [
                ExerciseGroup(withName: "Cuadríceps", andDrills:
                [
                    Drill(withExercise: Exercise(withName: "Squat", description: "", image: UIImage(named:"Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: .beginer, variations: nil), reps: 15, numberOfDrills: 3, andWeightObject: nil),
                ]),
                ExerciseGroup(withName: "Cuadríceps", andDrills:
                [
                    Drill(withExercise: Exercise(withName: "Squat", description: "", image: UIImage(named:"Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: .beginer, variations: nil), reps: 15, numberOfDrills: 3, andWeightObject: nil),
                ]),
            ]),
        WorkoutDay(withName: "Rise up 'n shine", image: UIImage(named: "daily_workout")!, weekDay: nil, andExerciseGroups:
            [
                ExerciseGroup(withName: "Cuadríceps", andDrills:
                [
                    Drill(withExercise: Exercise(withName: "Squat", description: "", image: UIImage(named:"Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: .beginer, variations: nil), reps: 15, numberOfDrills: 3, andWeightObject: nil),
                ]),
                ExerciseGroup(withName: "Cuadríceps", andDrills:
                [
                    Drill(withExercise: Exercise(withName: "Squat", description: "", image: UIImage(named:"Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: .beginer, variations: nil), reps: 15, numberOfDrills: 3, andWeightObject: nil),
                ]),
            ]),
        WorkoutDay(withName: "Greater Strenght", image: UIImage(named: "beast_mode")!, weekDay: nil, andExerciseGroups:
            [
                ExerciseGroup(withName: "Cuadríceps", andDrills:
                [
                    Drill(withExercise: Exercise(withName: "Squat", description: "", image: UIImage(named:"Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: .beginer, variations: nil), reps: 15, numberOfDrills: 3, andWeightObject: nil),
                ]),
                ExerciseGroup(withName: "Cuadríceps", andDrills:
                [
                    Drill(withExercise: Exercise(withName: "Squat", description: "", image: UIImage(named:"Routine_btn_dark")!, muscleGroup: .quads, equipment: nil, dificulty: .beginer, variations: nil), reps: 15, numberOfDrills: 3, andWeightObject: nil),
                ]),
            ])
    ]
    
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
    
    private let goalsArray = ["Tonificar", "Fortalecer", "Aumentar masa muscular", "Bajar de peso", "Ejercitarme en casa", "Mantenerme en forma", "Liberar estrés", "Ponerme mamadísimo", "Otro"]
    
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
    
    func getWTUser() -> User {
        return workoutTrackerUser
    }
    
    func getRoutine() -> Routine {
        return routine
    }
    
    func getEquipment() -> [String:Equipment] {
        return equipmentOptions
    }
    
    func getTopWorkouts() -> [WorkoutDay] {
        return topWorkouts
    }
    
    func getDefaultImage() -> UIImage {
        return defaultImage
    }
    
    func getGoalsArray() -> [String] {
        return goalsArray
    }
    
}

enum appImages:String {
    case beach_body_male="beach_body"
    case beach_body_female="beachGirl"
    case beast_mode="beast_mode"
    case best_self="best_self"
    case boxer_power="boxer_power"
    case daily_workout="daily_workout"
    case futbol_player="futbol_player"
    case handstand_man="handstand_man"
    case nopain="nopain"
    case plank_girl="plank_girl"
    case reach_goal="reach_goal"
    case runner="runner"
    case yoga="yoga"
}
