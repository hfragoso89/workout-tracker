//
//  Equipment.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/7/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit
import CoreData

struct Equipment {

    private(set) public var name: String
    private(set) public var description: String
    private(set) public var image: UIImage?
    private(set) public var muscleGroups: [MuscleGroup]?
    private(set) public var equipmentType: EquipmentType
    
    init(
        withName name: String,
        description: String,
        image: UIImage?,
        andMuscleGroups muscleGroups:[MuscleGroup]?
    ) {
        self.name = name
        self.description = description
        self.image = image
        self.muscleGroups = muscleGroups
        self.equipmentType = .none
    }
    
    init(
        withName name: String,
        description: String,
        image: UIImage?,
        type: EquipmentType,
        andMuscleGroups muscleGroups:[MuscleGroup]?
    ) {
        self.name = name
        self.description = description
        self.image = image
        self.muscleGroups = muscleGroups
        self.equipmentType = type
    }
    
    init(
        withManagedEquipment equipment: ManagedEquipment
    ) {
        self.name = equipment.name ?? ""
        self.description = equipment.descriptionText ?? ""
        if equipment.image != nil {
            self.image = UIImage(data: equipment.image!)
        } else {
            self.image = nil
        }
        self.muscleGroups = equipment.muscleGroup?.map() { (MuscleGroup(rawValue:($0 as? ManagedMuscleGroup)?.name ?? "Ninguno") ?? .undefined) } ?? [.undefined]
        self.equipmentType = EquipmentType(rawValue:equipment.equipmentType ?? "Ninguno") ?? .none
        
    }
}

enum EquipmentType:String {
    case none="Ninguno"
    case basicWeights="Pesas básicas"
    case barsNDumbells="Barras y mancuernas"
    case bars="Barras"
    case gymEquipment="Aparatos de gimnasio"
    case cones="Conos"
    case gymWeights="Pesas de gimnasio"
    case rope="Cuerda"
    case gloves="Guantes"
    case dumbells="Mancuernas"
    case trx="TRX"
    case advancedfutbolEquipment="Futbol avanzado"
    case advancedtenisEquipment="Tenis avanzado"
    case various="Varios tipos"
}
