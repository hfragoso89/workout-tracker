//
//  Routine.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/7/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit

class Routine {
    private(set) public var name:String
    private(set) public var image:UIImage?
    private(set) public var startDate:Date
    private(set) public var endDate:Date?
    private(set) public var owner:User
    private(set) public var days:[[ExerciseGroup]]?
    private(set) public var weekdays:[Weekday:[ExerciseGroup]]?
    private var routineQueue:[Int]
    
    init (
        withName name: String,
        image: UIImage,
        startDate start:Date,
        endDate end: Date?,
        owner:User,
        days:[[ExerciseGroup]]?,
        andWeekdays weekdays:[Weekday:[ExerciseGroup]]?
    ) {
        self.name = name
        self.image = image
        self.startDate = start
        self.endDate = end
        self.owner = owner
        self.days = days
        self.weekdays = weekdays
        self.routineQueue = []
        self.routineQueue = computeRoutineQueue()
    }
    
    func addDay(withExerciseGroupArray array:[ExerciseGroup]) {
        if let routineLenght = getRoutineLength(), routineLenght <= ((days?.count ?? 0) + (getweekdaysCount() ?? 0)) {
            if days != nil {
                days!.append(array)
            } else {
                days = [array]
            }
        }
        self.routineQueue = computeRoutineQueue()
    }
    
    func getRoutineLength() -> Int? {
        guard let end = endDate
            else { return nil }
        return Int(abs(end.distance(to: startDate))/86400)
    }
    
    private func computeRoutineQueue() -> [Int] {
        guard let routineSize = days?.count
        else {return []}
        
        var nextIndex = routineQueue.count == 0 ? 0 : routineQueue[0]
        var queue = [Int]()
        let routineLenght = getRoutineLength() ?? 365
        for _ in 0..<routineLenght {
            queue.append(nextIndex)
            nextIndex += 1
            if nextIndex == routineSize {
                nextIndex = 0
            }
        }
        return queue
    }
    
    func getweekdaysCount() -> Int? {
        
        return nil
    }
    
    func peekNextRoutine() -> [ExerciseGroup] {
        
        // Verify if there are weekday specific routines
        if let count = weekdays?.count, count >= 0 {
            
            //Get today's weekday value
            let today = Date()
            let gregorian = Calendar(identifier: Calendar.Identifier.gregorian)
            let weekday = gregorian.component(Calendar.Component.weekday, from: today)
            
            //Return weekday routine if exists
            if let dateRoutine = weekdays![Weekday.init(rawValue: weekday)!] {
                return dateRoutine
            }
        }
        
        // Return next routine in Regular Queue
        return days?[routineQueue[0]] ?? []
    
    }
    
    func popNextRoutine() {
        // Verify if there are weekday specific routines
        if let count = weekdays?.count, count >= 0 {
            
            //Get today's weekday value
            let today = Date()
            let gregorian = Calendar(identifier: Calendar.Identifier.gregorian)
            let weekday = gregorian.component(Calendar.Component.weekday, from: today)
            
            //Return weekday routine if exists
            if let _ = weekdays![Weekday.init(rawValue: weekday)!] {
                return
            }
        }
        
        // Return next routine in Regular Queue
        routineQueue.remove(at: 0)
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

enum Weekday:Int {
    case sunday=1,monday,tuesday,wednesday,thursday,friday,saturday
    func EnglishString() -> String {
        switch self {
        case .sunday:
            return "Sunday"
        case .monday:
            return "Monday"
        case .tuesday:
            return "Tuesday"
        case .wednesday:
            return "Wednesday"
        case .thursday:
            return "Thursday"
        case .friday:
            return "Friday"
        case .saturday:
            return "Saturday"
        }
    }
    func SpanishString() -> String {
        switch self {
        case .sunday:
            return "Domingo"
        case .monday:
            return "Lunes"
        case .tuesday:
            return "Martes"
        case .wednesday:
            return "Miércoles"
        case .thursday:
            return "Jueves"
        case .friday:
            return "Viernes"
        case .saturday:
            return "Domingo"
        }
    }
    func getValidationListArray() -> [String] {
        var result = ["No definido"]
        for day in 1...7 {
            result.append(Weekday(rawValue: day)?.SpanishString() ?? "")
        }
        return result
    }
}

extension Date {
    init(_ dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
    
    init(_ dateString:String, withStyle style:DateFormatter.Style, andLocale locale:Locale) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateStyle = style
        dateStringFormatter.timeStyle = .none
        dateStringFormatter.locale = locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
    
    func generateString(withDateStyle dateStyle:DateFormatter.Style, timeStyle: DateFormatter.Style, andLocale locale:Locale) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        formatter.locale = locale
        return formatter.string(from: self)
    }
}
