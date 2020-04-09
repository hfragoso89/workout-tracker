//
//  ManagedRoutine.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/21/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit
import CoreData

public class ManagedRoutine: NSManagedObject {
    class func findOrCreateRoutine(matching routine:Routine, in context:NSManagedObjectContext) throws -> ManagedRoutine {
        let request:NSFetchRequest<ManagedRoutine> = ManagedRoutine.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", routine.name)
        
        do {
            let routinesWtihMatchingName = try context.fetch(request)
            if routinesWtihMatchingName.count > 0 {
                assert(routinesWtihMatchingName.count == 1, "More than one routine with the same name found")
                return routinesWtihMatchingName[0]
            }
        } catch {
            throw error
        }
        let newRoutine = createManagedRoutine(with: routine, in: context)
        return newRoutine
    }
    
    class func createManagedRoutine(with routine:Routine, in context:NSManagedObjectContext) -> ManagedRoutine {
        let newRoutine = ManagedRoutine(context: context)
        newRoutine.name = routine.name
        newRoutine.image = routine.image?.pngData()
        newRoutine.startDate = routine.startDate
        newRoutine.endDate = routine.endDate
        print("assigning owner")
        if routine.owner != nil, let managedUser = try?ManagedUser.findOrCreateUser(matching: routine.owner!, in: context), ManagedUser.isMyUser(managedUser) {
            newRoutine.owner = managedUser
        }
        print("assigning author")
        newRoutine.author = try?ManagedUser.findOrCreateUser(matching: routine.author, in: context)
        print("assigning routineQueue")
        var routineQueue = ""
        routine.routineQueue.forEach() { routineQueue += String($0) }
        newRoutine.routineQueue = routineQueue
        print("assigning creating workoutDaySet")
        newRoutine.workoutDays = try?ManagedWorkoutDay.extractWorkouDaytSet(with: routine, in: context)
        
        return newRoutine
    }
    
    // TODO: - findMyCurrentRoutine method
    class func findMyCurrentRoutine(in context:NSManagedObjectContext) throws -> ManagedRoutine? {
        let request:NSFetchRequest<ManagedRoutine> = ManagedRoutine.fetchRequest()
        request.predicate = NSPredicate(format: "owner.me == YES AND startDate < %@ AND endDate >= %@", NSDate(), NSDate())
        
        do {
            let routinesWtihMatchingName = try context.fetch(request)
            if routinesWtihMatchingName.count > 0 {
                assert(routinesWtihMatchingName.count == 1, "findMyCurrentRoutine: More than one current routines found")
                return routinesWtihMatchingName[0]
            }
        } catch {
            throw error
        }
        return nil
    }
    
    // TODO: - findMyOldRoutines method
    class func findMyCurrentOldRoutines(in context:NSManagedObjectContext) throws -> [ManagedRoutine]? {
        let request:NSFetchRequest<ManagedRoutine> = ManagedRoutine.fetchRequest()
        request.predicate = NSPredicate(format: "user.me == YES")
        
        do {
            let routinesWtihMatchingName = try context.fetch(request)
            if routinesWtihMatchingName.count > 0 {
                return routinesWtihMatchingName
            }
        } catch {
            throw error
        }
        return nil
    }
}
