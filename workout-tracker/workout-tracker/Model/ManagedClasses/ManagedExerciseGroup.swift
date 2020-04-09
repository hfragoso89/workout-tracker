//
//  ManagedExerciseGroup.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/21/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit
import CoreData

public class ManagedExerciseGroup: NSManagedObject {
    class func findOrCreateExerciseGroup(with exerciseGroup:ExerciseGroup, in context:NSManagedObjectContext) throws -> ManagedExerciseGroup {
        print(" findOrCreateExerciseGroup for: \(exerciseGroup)")
        let request:NSFetchRequest<ManagedExerciseGroup> = ManagedExerciseGroup.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", exerciseGroup.name)
        
        do {
            let matchingExerciseGroup = try context.fetch(request)
            if matchingExerciseGroup.count > 0 {
                assert(matchingExerciseGroup.count == 1, "More than one ExerciseGroup match found")
                print(" Exercise Group found!")
                return matchingExerciseGroup[0]
            }
        } catch {
            throw error
        }
        
        print(" new ManagedExerciseGroup")
        let createdExerciseGroup = ManagedExerciseGroup(context: context)
        //TODO: set variables
        createdExerciseGroup.name = exerciseGroup.name
        do {
            for drill in exerciseGroup.drills {
                createdExerciseGroup.addToDrills(try ManagedDrill.findOrCreateDrill(with: drill, in: context))
            }
        } catch {
            throw error
        }
        return createdExerciseGroup
        
    }
    
}
