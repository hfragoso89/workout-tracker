//
//  ManagedExercise.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/21/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit
import CoreData

public class ManagedExercise: NSManagedObject {
    class func findOrCreateExercise(with exercise:Exercise, in context:NSManagedObjectContext) throws -> ManagedExercise {
        print("   findOrCreateExercise for: \(exercise)")
        let request:NSFetchRequest<ManagedExercise> = ManagedExercise.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", exercise.name)
        
        do {
            let matchingExercise = try context.fetch(request)
            if matchingExercise.count > 0 {
                assert(matchingExercise.count == 1, "findOrCreateExercise: Inconsistency found, more than one ManagedExercise with the same name.")
                print("    exercise found!")
                return matchingExercise[0]
            }
        }
        
        print("    new ManagedExercise")
        let createdExercise = ManagedExercise(context: context)
        createdExercise.name = exercise.name
        createdExercise.descriptionText = exercise.description
        createdExercise.image = exercise.image.pngData()
        // TODO: - Create initializer for Equipment(withManagedEquipment)
        print("   Assigning equipment: \(exercise.equipment)")
        if let unwrappedEquipment = exercise.equipment {
            createdExercise.equipment = try?ManagedEquipment.findOrCreateEquipment(matching: unwrappedEquipment, in: context)
        }
        print("    Assigning dificulty: \(exercise.dificulty)")
        createdExercise.dificulty = ManagedDificulty(context: context)
        createdExercise.dificulty?.name = exercise.dificulty?.rawValue ?? "0"
        // TODO: - Add variations
        print("    Assigning variations: \(exercise.variations)")
        if exercise.variations != nil {
            for variation in exercise.variations! {
                let newVariation = ManagedVariations(context: context)
                newVariation.name = variation
                createdExercise.addToVariations(newVariation)
            }
//            createdExercise.variations = NSSet(arrayLiteral: exercise.variations!.map() { ManagedVariations(context: context).name = $0 })
        }
        // TODO: - Add Drills
        return createdExercise
    }

}
