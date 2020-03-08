//
//  Routine.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/7/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit

struct Routine {
    private(set) public var name:String
    private(set) public var image:UIImage?
    private(set) public var startDate:Date
    private(set) public var endDate:Date?
    private(set) public var owner:User
    private(set) public var days:[[ExerciseGroup]]?
    private(set) public var weekdays:[Weekday:ExerciseGroup]?
    
    init (
        withName name: String,
        image: UIImage,
        startDate start:Date,
        endDate end: Date?,
        owner:User,
        days:[[ExerciseGroup]]?,
        andWeekdays weekdays:[Weekday:ExerciseGroup]?
    ) {
        self.name = name
        self.image = image
        self.startDate = start
        self.endDate = end
        self.owner = owner
        self.days = days
        self.weekdays = weekdays
    }
    
    mutating func addDay(withExerciseGroupArray array:[ExerciseGroup]) {
        if let routineLenght = getRoutineLength(), routineLenght <= ((days?.count ?? 0) + (getweekdaysCount() ?? 0)) {
            if days != nil {
                days!.append(array)
            } else {
                days = [array]
            }
        }
    }
    
    func getRoutineLength() -> Int? {
        guard let end = endDate
            else { return nil }
        return Int(abs(end.distance(to: startDate))/86400)
    }
    
    func getweekdaysCount() -> Int? {
        
        return nil
    }
}

struct ExerciseGroup {
    private(set) public var name:String
    private(set) public var drills: [(numberOfDrills:Int?,drill:Drill)]
    
    init(
        withName name:String,
        andDrills drills:[(numberOfDrills:Int?,drill:Drill)]
    ) {
        self.name = name
        self.drills = drills
    }
    
    mutating func add(drill:Drill, times:Int?) {
        self.drills.append((times,drill))
    }
    
    mutating func autoGenerateName() {
        guard drills.count > 1, self.name != "N/A"
            else { return }
        var result = ""
        var muscleGroups:Set<String> = []
        for drillAppearence in drills {
            let currentMuscleGroup = "\(drillAppearence.drill.exercise.muscleGroup)"
            if !muscleGroups.contains(currentMuscleGroup) {
                if result != "" { result += ", "}
                result += currentMuscleGroup
                muscleGroups.insert(currentMuscleGroup)
            }
        }
        self.name = result
    }
}

struct Drill {
    private(set) public var reps: Int
    private(set) public var weight: Double?
    private(set) public var exercise:Exercise
    
    init(
        withExercise exercise:Exercise,
        reps: Int,
        andWeight weight:Double?
    ) {
        self.exercise = exercise
        self.reps = reps
        self.weight = weight
    }
}

enum Weekday {
    case monday,tuesday,wednesday,thursday,friday,saturday,sunday
}

extension Date {
    init(_ dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
}
