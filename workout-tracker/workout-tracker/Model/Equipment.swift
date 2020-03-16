//
//  Equipment.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/7/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit

class Equipment {
    private(set) public var name: String
    private(set) public var description: String
    private(set) public var image: UIImage?
    private(set) public var muscleGroups: [MuscleGroup]?
    
    init(
        withName name: String,
        description: String,
        image: UIImage?,
        andMuscleGroups muscleGroups:[MuscleGroup]?
    ) {
        self.name = name
        self.description = description
        self.image = image
        self.muscleGroups = muscleGroups
    }
}
