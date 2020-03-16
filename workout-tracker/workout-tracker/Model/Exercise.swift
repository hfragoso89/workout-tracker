//
//  Exercise.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/7/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit

 Exercise {
    
    private(set) public var name:String
    private(set) public var description:String
    private(set) public var image:UIImage
    private(set) public var muscleGroup:MuscleGroup
    private(set) public var equipment: Equipment?
    private(set) public var dificulty: Dificulty?
    private(set) public var variations:[String]?
    
    init(
        withName name:String,
        description: String,
        image: UIImage,
        muscleGroup: MuscleGroup,
        equipment: Equipment?,
        dificulty: Dificulty?,
        variations: [String]?
    ) {
        self.name = name
        self.description = description
        self.image = image
        self.muscleGroup = muscleGroup
        self.equipment = equipment
        self.dificulty = dificulty ?? .notDefined
        self.variations = variations
    }
    
    mutating func changeImage(withImage image:UIImage) {
        self.image = image
    }
    
    func copyExcercise(withVariations variations:[String]) -> Exercise {
        return Exercise(withName: self.name, description: self.description, image: self.image, muscleGroup: self.muscleGroup, equipment: self.equipment, dificulty: self.dificulty, variations: variations)
    }
    
    
}

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
