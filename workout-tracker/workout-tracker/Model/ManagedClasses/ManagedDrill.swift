//
//  ManagedDrill.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/21/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit
import CoreData

public class ManagedDrill: NSManagedObject {
    class func findOrCreateDrill(with drill:Drill, in context:NSManagedObjectContext) throws -> ManagedDrill {
        print(" findOrCreateDrill for: \(drill)")
        let request:NSFetchRequest<ManagedDrill> = ManagedDrill.fetchRequest()
        request.predicate = NSPredicate(format: "(exercise.name like %@) AND (numberOfDrills == %@) AND (reptetitions == %@)", drill.exercise.name,"\(drill.numberOfDrills ?? 0)", "\(drill.reps)")
//        request.predicate = NSPredicate(format: "exercise.name like %@", drill.exercise.name)
        
        do {
            let matchingDrill  = try context.fetch(request)
            if matchingDrill.count > 0 {
                assert(matchingDrill.count == 1, "findOrCreateDrill: Inconsistency found, more than one MAnagedDrill with the same combination.")
                print("  Drill found!")
                return matchingDrill[0]
            }
        }
        
        print("  new ManagedDrill")
        let createdDrill = ManagedDrill(context: context)
        createdDrill.reptetitions = Int16(drill.reps)
        createdDrill.numberOfDrills = (drill.numberOfDrills != nil ? Int16(drill.numberOfDrills!) : nil)!
        createdDrill.weight = drill.weight?.doubleValue(for: .kg, withPrecision: 1) ?? 0
        createdDrill.weightUnit = 0
        // TODO: - Add exercise
        print("  adding drill.exercise")
        createdDrill.exercise = try? ManagedExercise.findOrCreateExercise(with: drill.exercise, in: context)
        return createdDrill
    }
}
