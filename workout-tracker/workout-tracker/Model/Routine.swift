//
//  Routine.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/7/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit
import CoreData

class Routine {

    //MARK: - Attributes
    private(set) public var name:String
    private(set) public var image:UIImage?
    private(set) public var description:String
    private(set) public var equipmentDescription:String
    private(set) public var startDate:Date
    private(set) public var endDate:Date?
    private(set) public var owner:User?
    private(set) public var author:User
    private(set) public var days:[[ExerciseGroup]]?
    private(set) public var weekdays:[Weekday:[ExerciseGroup]]?
    private(set) public var workoutDays:[WorkoutDay]?
    private(set) public var routineQueue:[Int]
    
    //MARK: - Initizalizers
    init (
        withName name: String,
        image: UIImage,
        startDate start:Date,
        endDate end: Date?,
        owner:User?,
        days:[[ExerciseGroup]]?,
        andWeekdays weekdays:[Weekday:[ExerciseGroup]]?
    ) {
        self.name = name
        self.image = image
        self.startDate = start
        self.endDate = end
        self.owner = owner
        self.author = User(withFirstName: "Workout", lastName: "Tracker", userName: "workout-tracker", image: UIImage(named: "AppIcon")!, birthdate: Date("2020-03-01"), height: Height(withCmValue: 1.0), weight: Weight(withKgValue: 1.0), andGender: .undefined)
        self.days = days
        self.weekdays = weekdays
        self.routineQueue = []
        self.workoutDays = (days != nil ? days!.map() { WorkoutDay(withImage: UIImage(named: "Weights_image")!, andExerciseGroups: $0) } : []) + (weekdays != nil ? (weekdays?.map() { Key, Value in WorkoutDay(withImage: UIImage(named: "Weights_image")!, weekDay: Key, andExerciseGroups: Value) })! : [])
        self.description = ""
        self.equipmentDescription = "Ninguno"
        self.routineQueue = computeRoutineQueue()
        updateEquipmentDescription()
    }
    
    init (
        withName name: String,
        image: UIImage,
        startDate start:Date,
        endDate end: Date?,
        owner:User?,
        author:User,
        days:[[ExerciseGroup]]?,
        andWeekdays weekdays:[Weekday:[ExerciseGroup]]?
    ) {
        self.name = name
        self.image = image
        self.startDate = start
        self.endDate = end
        self.owner = owner
        self.author = author
        self.days = days
        self.weekdays = weekdays
        self.routineQueue = []
        self.description = ""
        self.equipmentDescription = "Ninguno"
        self.routineQueue = computeRoutineQueue()
        updateEquipmentDescription()
    }
    
    init(withManagedRoutine routine:ManagedRoutine) {
        self.name = routine.name ?? ""
        if routine.image != nil {
            self.image = UIImage(data: routine.image!)
        } else {
            self.image = nil
        }
        self.startDate = routine.startDate ?? Date()
        self.endDate = routine.endDate ?? Date()
        if routine.owner != nil {
            self.owner = User(withManagedUser: routine.owner!)
        } else {
            self.owner = nil
        }
        if routine.author != nil {
            self.author = User(withManagedUser: routine.author!)
        } else {
            self.author = DataService.instance.getWTUser()
        }
        self.days = []
        self.weekdays = [:]
        if routine.workoutDays != nil {
            self.weekdays = ManagedWorkoutDay.getWeekdayArray((routine.workoutDays!) as! Set<ManagedWorkoutDay>)
            self.days = ManagedWorkoutDay.getWorkoutDaysArray(routine.workoutDays! as! Set<ManagedWorkoutDay>)
        }
        self.workoutDays = []
        self.equipmentDescription = "Ninguno"
        self.description = ""
        if routine.routineQueue != nil {
            self.routineQueue = routine.routineQueue!.map() { Int(String($0)) ?? 0 }
        } else {
            self.routineQueue = []
            self.routineQueue = computeRoutineQueue()
        }
        updateEquipmentDescription()
        createWorkoutdaysArray()
    }
    
    //MARK: - Modifier methods
    
    func createWorkoutdaysArray() {
        if let unwrappedDays = self.days {
            for day in unwrappedDays {
                self.workoutDays?.append(WorkoutDay(withImage: UIImage(named: "Weights_image")!, andExerciseGroups: day))
            }
        }
        if let unwrappedWeekDays = self.weekdays {
            for weekday in unwrappedWeekDays {
                self.workoutDays?.append(WorkoutDay(withImage: UIImage(named: "Weights_image")!, weekDay: weekday.key, andExerciseGroups: weekday.value))
            }
        }
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
        self.updateEquipmentDescription()
    }
    
    /// This method returns the number of days that this routine was/will be active  from start date to end date.
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
    
    ///This method returns the next ExerciseGroup array (or Workoutday) that should be accomplished.
    ///If there's a weekday tagged routine that matches the current day that's the one that will return.
    ///If there's no weekday tagged routine, this method will return the following routine according to the routine queue.
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
    
    ///This method removes the upcoming Workoutday in the rountie queue.
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
    
    private func updateEquipmentDescription() {
        var equipmentDescriptionString = "Ninguno"
        var accumulator:Set<EquipmentType> = []
        for day in days ?? [] {
            for exerciseGroup in day {
                accumulator = accumulator.intersection(exerciseGroup.getExerciseGroupEquipmentTypesSet())
                if accumulator.count >= 4 {
                    self.equipmentDescription = "Varios tipos"
                    return
                }
            }
        }
        for weekday in weekdays ?? [:] {
            for exerciseGroup in weekday.value {
                accumulator = accumulator.intersection(exerciseGroup.getExerciseGroupEquipmentTypesSet())
                if accumulator.count >= 4 {
                    self.equipmentDescription = "Varios tipos"
                    return
                }
            }
        }
        accumulator.remove(.none)
        for equipmentType in accumulator {
            if equipmentDescriptionString == "Ninguno" { equipmentDescriptionString = "" }
            equipmentDescriptionString += "\(equipmentDescriptionString != "" ? " · " : "" )\(equipmentType)"
        }
        self.equipmentDescription = equipmentDescriptionString
    }
    
    ///Returns the name of the upcoming Workoutday in the rountie queue or the one that matches the current weekday.
    func getTodaysRoutineName() -> String {
        print(routineQueue)
        var result = ""
        for day in peekNextRoutine() {
            if result != "" { result += " · "}
            result += day.name
        }
        return result
    }
    
}

struct WorkoutDay {
    
    // MARK: - Attributes
    private(set) public var name:String
    private(set) public var image:UIImage
    private(set) public var weekDay:Weekday?
    private(set) public var exerciseGroups:[ExerciseGroup]?
    private var usesDefaultName:Bool
    
    // MARK: - Initializers
    init(
        withName name:String,
        image: UIImage,
        weekDay:Weekday?,
        andExerciseGroups exerciseGroups:[ExerciseGroup]?
    ) {
        self.name = name
        self.image = image
        self.weekDay = weekDay
        self.exerciseGroups = exerciseGroups
        self.usesDefaultName = false
    }
    
    init(
        withImage image:UIImage,
        weekDay: Weekday?,
        andExerciseGroups exerciseGroups:[ExerciseGroup]?
    ) {
        self.image = image
        self.weekDay = weekDay
        self.exerciseGroups = exerciseGroups
        self.usesDefaultName = true
        self.name = ""
        self.name = nameGenerator()
        print("new WorkoutWeekDayCreated: \(self.name)")
    }
    
    init(
        withImage image: UIImage,
        andExerciseGroups exerciseGroups:[ExerciseGroup]?
    ) {
        self.image = image
        self.exerciseGroups = exerciseGroups
        self.weekDay = nil
        self.usesDefaultName = true
        self.name = ""
        self.name = nameGenerator()
        print("new WorkoutDayCreated: \(self.name)")
    }
    
    init(with managedWorkoutDay:ManagedWorkoutDay) {
        self.image = managedWorkoutDay.image != nil ? UIImage(data: managedWorkoutDay.image!)! : DataService.instance.getDefaultImage()
        self.weekDay = managedWorkoutDay.weekDay != 0 ? Weekday.init(rawValue: Int(managedWorkoutDay.weekDay)) : nil
        self.name = managedWorkoutDay.name ?? ""
        self.usesDefaultName = false
        if managedWorkoutDay.exerciseGroups != nil {
            self.exerciseGroups = Array(managedWorkoutDay.exerciseGroups!.map() { ExerciseGroup(withManagedExerciseGroup: $0 as! ManagedExerciseGroup) })
        }
    }
    
    //MARK: - nameGenetator function
    /// This function generates a default name for this workoutDay
    private func nameGenerator() -> String {
        // Checks if workoutDay already has a name
        guard name == ""/*, usesDefaultName == false*/ else {
            return name
        }
        
        //Generates the newName based on the exerciseGroups names
        var newName = ""
        if let currentExerciseGroups = self.exerciseGroups {
            for exerciseGroup in currentExerciseGroups {
                newName += newName == "" ? "\(exerciseGroup.name)" : " · \(exerciseGroup.name)"
            }
        } else {
            return "workoutDay_\(Int.random(in:61000...150000))"
        }
        return newName
    }
    
    // MARK: - Modifier Methods
    
    mutating func addExerciseGroup(_ exerciseGroup:ExerciseGroup) {
        
        if exerciseGroups != nil {
            self.exerciseGroups!.append(exerciseGroup)
        } else {
            self.exerciseGroups = [exerciseGroup]
        }
    }
    
    mutating func changeWorkoutdayImage(with image:UIImage) {
        self.image = image
    }
    
    mutating func changeWorkoutdayName(to newName:String) {
        self.name = newName
        self.usesDefaultName = false
    }
    
    mutating private func updateWorkoutDayName() {
        if !self.usesDefaultName {
            return
        }
        self.name = nameGenerator()
    }
    
    
    
}


struct ExerciseGroup {
    
    //MARK: - Attributes
    private(set) public var name:String
    private(set) public var drills: [Drill]
    
    init(
        withName name:String,
        andDrills drills:[Drill]
    ) {
        self.name = name
        self.drills = drills
    }
    
    init(
        withManagedExerciseGroup exerciseGroup:ManagedExerciseGroup) {
        self.name = exerciseGroup.name ?? ""
        self.drills = []
        if exerciseGroup.drills != nil {
            for drill in exerciseGroup.drills! {
                self.drills.append(Drill(withManagedDrill: drill as! ManagedDrill))
            }
        }
    }
    
    mutating func add(drill:Drill, times:Int?) {
        self.drills.append(drill)
    }
    
    mutating func autoGenerateName() {
        guard drills.count > 1, self.name != "N/A"
            else { return }
        var result = ""
        var muscleGroups:Set<String> = []
        for drillAppearence in drills {
            let currentMuscleGroup = "\(drillAppearence.exercise.muscleGroup)"
            if !muscleGroups.contains(currentMuscleGroup) {
                if result != "" { result += ", "}
                result += currentMuscleGroup
                muscleGroups.insert(currentMuscleGroup)
            }
        }
        self.name = result
    }
    
    func getExerciseGroupEquipmentTypesSet() -> Set<EquipmentType> {
        var result:Set<EquipmentType> = []
        for drill in drills {
            let currentType = drill.exercise.equipment?.equipmentType ?? .none
            if !result.contains(currentType), currentType != .none {
                result.insert(currentType)
            }
        }
        return result
    }
}


struct Drill {

    //MARK: - Attributes
    private(set) public var reps: Int
    private(set) public var weight: Weight?
    private(set) public var exercise:Exercise
    private(set) public var numberOfDrills: Int?
    
    init(
        withExercise exercise:Exercise,
        reps: Int,
        andWeight weight:Double?
    ) {
        self.exercise = exercise
        self.reps = reps
        self.weight = Weight(withLbValue: weight ?? 0)
        self.numberOfDrills = 0
    }
    
    init(
        withExercise exercise:Exercise,
        reps: Int,
        numberOfDrills: Int?,
        andWeightObject weight:Weight?
    ) {
        self.exercise = exercise
        self.reps = reps
        self.weight = weight
        self.numberOfDrills = numberOfDrills
    }
    
    init(withManagedDrill drill:ManagedDrill) {
        self.exercise = Exercise(withManagedExercise: drill.exercise!)
        self.reps = Int(drill.reptetitions)
        self.weight = drill.weightUnit == 0 ? Weight(withKgValue: drill.weight) : Weight(withLbValue: drill.weight)
        self.numberOfDrills = Int(drill.numberOfDrills)
    }
    
    func getExerciseEquipmentType() -> EquipmentType {
        return exercise.equipment?.equipmentType ?? .none
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
