//
//  Exercise.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/7/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit
import CoreData

struct Exercise {
    
    private(set) public var name:String
    private(set) public var description:String
    private(set) public var image:UIImage
    private(set) public var muscleGroup:MuscleGroup
    private(set) public var muscleGroupSet:Set<MuscleGroup>
    private(set) public var equipment: Equipment?
    private(set) public var dificulty: Dificulty?
    private(set) public var variations:[String]?
    
    init(
        withName name:String,
        description: String,
        image: UIImage,
        muscleGroup: MuscleGroup,
        equipment: Equipment?,
        dificulty: Dificulty?,
        variations: [String]?
    ) {
        
        self.name = name
        self.description = description
        self.image = image
        self.muscleGroup = muscleGroup
        self.muscleGroupSet = [muscleGroup]
        self.equipment = equipment
        self.dificulty = dificulty
        self.variations = variations
    }
    
    init(
        withManagedExercise exercise:ManagedExercise
    ) {
        
        self.name = exercise.name!
        self.description = exercise.descriptionText ?? ""
        if exercise.image != nil {
            self.image = UIImage(data: exercise.image!)!
        } else {
            self.image = UIImage(named: "Routine_btn_dark")!
        }
        self.muscleGroupSet = Set(exercise.muscleGroup?.map() { (MuscleGroup.init(rawValue:($0 as? ManagedMuscleGroup)?.name ?? "ND") ?? .undefined) } ?? [MuscleGroup.undefined])
        self.muscleGroup = self.muscleGroupSet.first ?? .undefined
        if exercise.equipment != nil {
            self.equipment = Equipment(withManagedEquipment:exercise.equipment!)
        } else {
            self.equipment = nil
        }
        self.dificulty = Dificulty(rawValue: exercise.dificulty?.name ?? "No definido")
        self.variations = exercise.variations?.map(){ ($0 as! ManagedVariations).name ?? "" }
    }
    
    mutating func changeImage(withImage image:UIImage) {
        self.image = image
    }
    
    func copyExcercise(withVariations variations:[String]) -> Exercise {
        return Exercise(withName: self.name, description: self.description, image: self.image, muscleGroup: self.muscleGroup, equipment: self.equipment, dificulty: self.dificulty, variations: variations)
    }
    
    
}

enum MuscleGroup:String {
    case pecs="Pectorales"
    case traps="Trapecios"
    case delts="Deltoides"
    case biceps="Biceps"
    case triceps="Triceps"
    case forearms="Antebrazos"
    case lats="Laterales"
    case back="Espalda"
    case lowerBack="Espalda baja"
    case neck="Cuello"
    case oblique="Oblicuos"
    case lowerAbs="Abominal bajo"
    case upperAbs="Abdominal superio"
    case glutes="Gúteos"
    case quads="Cuadríceps"
    case hams="Isquiotibiales"
    case calves="Pantorrillas"
    case undefined="ND"
}

enum Dificulty:String {
    // dificulty levels for the Exercises
    case beginer="Principiante"
    case intermediate="Intermedio"
    case advanced="Avanzado"
    case expert="Experto"
    case notDefined="No definido"
    case notApplicable="N/A"
}

