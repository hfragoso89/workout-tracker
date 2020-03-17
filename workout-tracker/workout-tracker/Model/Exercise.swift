//
//  Exercise.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/7/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit
import CoreData

public class Exercise: NSManagedObject {
    
   /*
    @NSManaged public var name:String
    @NSManaged public var descriptionText:String
    @NSManaged public var image:UIImage
    @NSManaged public var muscleGroup:MuscleGroup
    @NSManaged public var equipment: Equipment?
    @NSManaged public var dificulty: Dificulty?
    @NSManaged public var variations:[String]?
    
    init(
        withName name:String,
        description: String,
        image: Data,
        muscleGroup: NSSet,
        equipment: Equipment?,
        dificulty: Dificulty?,
        variations: NSSet?,
        andContext context:NSManagedObjectContext
    ) {
        
        super.init(entity: NSEntityDescription(), insertInto: context)
        
        self.name = name
        self.descriptionText = description
        self.image = image
        self.muscleGroup = muscleGroup as NSSet
        self.equipment = equipment
        self.dificulty = dificulty
        self.variations = variations as NSSet?
    }
    */
    func changeImage(withImage image:Data) {
        self.image = image
    }
    
    //func copyExcercise(withVariations variations:Set<Variations>) -> Exercise {
    //    return Exercise(withName: self.name ?? "Unamed", description: self.description, image: self.image ?? UIImage(named: "Routine_btn_dark")!.pngData()!, muscleGroup: self.muscleGroup ?? [MuscleGroup()], equipment: self.equipment, dificulty: self.dificulty, variations: variations as NSSet)
    //}
    
    
}

/*
enum MuscleGroup {
    case pecs
    case traps
    case delts
    case biceps
    case triceps
    case forearms
    case lats
    case back
    case lowerBack
    case neck
    case oblique
    case lowerAbs
    case upperAbs
    case glutes
    case quads
    case hams
    case calves
    case undefined
}

enum Dificulty {
    // dificulty levels for the Exercises
    case beginer
    case intermediate
    case advanced
    case expert
    case notDefined
    case notApplicable
    
}
*/
