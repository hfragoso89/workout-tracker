//
//  ManagedEquipment.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/21/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit
import CoreData

public class ManagedEquipment: NSManagedObject {
    class func findOrCreateEquipment(matching equipment: Equipment, in context:NSManagedObjectContext) throws -> ManagedEquipment {
        print("     Entering findOrCreateEquipment for: \(equipment)")
        let request:NSFetchRequest<ManagedEquipment> = ManagedEquipment.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", equipment.name)
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "More than one user matching user")
                print("     EquipmentFound!")
                return matches [0]
            }
        } catch {
            throw error
        }
        print("     Create new ManagedEquipment")
        let createdEquipment = ManagedEquipment(context:context)
        createdEquipment.name = equipment.name
        createdEquipment.image = equipment.image?.pngData()
        createdEquipment.descriptionText = equipment.description
        createdEquipment.equipmentType = equipment.equipmentType.rawValue
        print("     Assign muscleGroups: \(equipment.muscleGroups)")
        if let unwrappedMuscleGroups = equipment.muscleGroups  {
            for muscleGroup in unwrappedMuscleGroups {
                createdEquipment.addToMuscleGroup(try!ManagedEquipment.findOrCreateMuscleGroup(with: muscleGroup, in: context))
            }
        }
        return createdEquipment
    }
    
    class func findOrCreateMuscleGroup(with muscleGroup:MuscleGroup, in context:NSManagedObjectContext) throws -> ManagedMuscleGroup {
        let request:NSFetchRequest<ManagedMuscleGroup> = ManagedMuscleGroup.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", muscleGroup.rawValue)
        do {
            let matchingMuscleGroups = try context.fetch(request)
            if matchingMuscleGroups.count > 0 {
                assert(matchingMuscleGroups.count == 1, "findOrCreateMuscleGroups: Inconsistency found, more than one matching muscleGroup")
                return matchingMuscleGroups[0]
            }
        } catch {
            throw error
        }
        
        let newManagedMuscleGroup = ManagedMuscleGroup(context: context)
        newManagedMuscleGroup.name = muscleGroup.rawValue
        return newManagedMuscleGroup
        
    }
    
}
