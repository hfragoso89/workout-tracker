//
//  ManagedWorkoutDay.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/21/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit
import CoreData

public class ManagedWorkoutDay: NSManagedObject {
    class func getWeekdayArray(_ set:Set<ManagedWorkoutDay>) -> [Weekday:[ExerciseGroup]] {
        var result:[Weekday:[ExerciseGroup]] = [:]
        for workoutDay in set {
            switch workoutDay.weekDay {
            case 1:
                result.updateValue(workoutDay.exerciseGroups!.map(){ ExerciseGroup(withManagedExerciseGroup: $0 as! ManagedExerciseGroup) }, forKey: .monday)
            case 2:
                result.updateValue(workoutDay.exerciseGroups!.map(){ ExerciseGroup(withManagedExerciseGroup: $0 as! ManagedExerciseGroup) }, forKey: .tuesday)
            case 3:
                result.updateValue(workoutDay.exerciseGroups!.map(){ ExerciseGroup(withManagedExerciseGroup: $0 as! ManagedExerciseGroup) }, forKey: .wednesday)
            case 4:
                result.updateValue(workoutDay.exerciseGroups!.map(){ ExerciseGroup(withManagedExerciseGroup: $0 as! ManagedExerciseGroup) }, forKey: .thursday)
            case 5:
                result.updateValue(workoutDay.exerciseGroups!.map(){ ExerciseGroup(withManagedExerciseGroup: $0 as! ManagedExerciseGroup) }, forKey: .friday)
            case 6:
                result.updateValue(workoutDay.exerciseGroups!.map(){ ExerciseGroup(withManagedExerciseGroup: $0 as! ManagedExerciseGroup) }, forKey: .saturday)
            case 7:
                result.updateValue(workoutDay.exerciseGroups!.map(){ ExerciseGroup(withManagedExerciseGroup: $0 as! ManagedExerciseGroup) }, forKey: .sunday)
            default: break

            }
        }
        return result
    }
    
    class func getWorkoutDaysArray(_ set:Set<ManagedWorkoutDay>) -> [[ExerciseGroup]] {
        var result:[[ExerciseGroup]] = [[]]
        for workoutDay in set {
            if workoutDay.weekDay == 0 {
                result.append(workoutDay.exerciseGroups!.map(){ ExerciseGroup(withManagedExerciseGroup: $0 as! ManagedExerciseGroup) })
            }
        }
        return result
    }
    
    class func extractWorkouDaytSet(with routine:Routine, in context:NSManagedObjectContext) throws -> NSSet? {
        print("Enterting extractWorkoutDaySetMethod")
        var resultSet:Array<ManagedWorkoutDay> = []
        do {
            print("+++adding \(routine.days?.count) days")
            for day in routine.days ?? [] {
                print("++++trying to append new WOD: \(day)")
                resultSet.append(try ManagedWorkoutDay.findOrCreateWorkoutday(with: WorkoutDay(withImage: UIImage(named: "Weights_image")!, andExerciseGroups: day), in: context))
                print("++++didFinish append new WOD")
            }
            for weekday in routine.weekdays ?? [:] {
                print("++++trying to append new WOWD: \(weekday)")
                resultSet.append(try ManagedWorkoutDay.findOrCreateWorkoutday(with: WorkoutDay(withImage: UIImage(named: "Weights_image")!, weekDay: weekday.key, andExerciseGroups: weekday.value), in: context))
                print("++++didFinish append new WOWD")
            }
        } catch {
            print("*** Error in extractWorkoutDaySet Method: \(error.localizedDescription)")
            throw error
        }
        print(">> Ready to return \(resultSet.count) elements from: \(resultSet)")
        let result = NSSet(array: resultSet)
        return result
//        return NSSet(arrayLiteral: resultSet)
    }
    
    class func findOrCreateWorkoutday(with workoutDay:WorkoutDay, in context:NSManagedObjectContext) throws -> ManagedWorkoutDay {
        print("--> findOrCreateWorkoutDay for: \(workoutDay.name)")
        let request:NSFetchRequest<ManagedWorkoutDay> = ManagedWorkoutDay.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", workoutDay.name)
        
        do {
            let matchingWorkoutDay = try context.fetch(request)
            if matchingWorkoutDay.count > 0 {
                assert(matchingWorkoutDay.count == 0 , "findOrCreateWorkoutday: Inconsistency found, more than one matching workoutdayFound")
                print("--> findOrCreateWorkoutDay for: \(workoutDay.name)")
                return matchingWorkoutDay[0]
            }
            
        } catch {
            throw error
        }
        
        print("--> new ManagedWorkoutday")
        let createdWorkoutDay = ManagedWorkoutDay(context: context)
        createdWorkoutDay.name = workoutDay.name
        createdWorkoutDay.image = workoutDay.image.pngData()
        createdWorkoutDay.weekDay = Int16(workoutDay.weekDay?.rawValue ?? 0)
        print("--> adding \(workoutDay.exerciseGroups?.count) exerciseGroups to MangedWorkoutDay")
        do {
            //createdWorkoutDay.exerciseGroups = workoutDay.exerciseGroups != nil ? NSSet(arrayLiteral: workoutDay.exerciseGroups!.map(){ try ManagedExerciseGroup.findOrCreateExerciseGroup(with: $0, in: context) }) : nil
            if let unwrappedExerciseGroups = workoutDay.exerciseGroups {
                for exerciseGroup in unwrappedExerciseGroups {
                    let newExerciseGroup = try ManagedExerciseGroup.findOrCreateExerciseGroup(with: exerciseGroup, in: context)
                    createdWorkoutDay.addToExerciseGroups(newExerciseGroup
                    )
                }
            }
        } catch {
            print(">>>Error adding exerciseGroups!\n\(error.localizedDescription)")
        }
        return createdWorkoutDay
    }
    
}
