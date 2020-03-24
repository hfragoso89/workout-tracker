//
//  User.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/7/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit
import CoreData

class User {
    
    private(set) public var firstName:String
    private(set) public var lastName:String
    private(set) public var image:UIImage?
    private(set) public var birthdate:Date
    private(set) public var gender:Gender
        
    //TODO: Add a structure to support Weight and Heifhr objects
    private(set) public var weight:Weight
    private(set) public var height:Height
    
    init(
        withFirstName firstName:String,
        lastName: String,
        image: UIImage?,
        birthdate: Date,
        height: Height,
        weight: Weight,
        andGender gender:Gender
         )
    {
        self.firstName = firstName
        self.lastName = lastName
        self.image = image
        self.birthdate = birthdate
        self.gender = gender
        self.height = height
        self.weight = weight
    }
    
    func changePhoto(with image: UIImage) {
        self.image = image
    }
    
    func getAge() -> Int {
        return Int(Date().timeIntervalSince(self.birthdate) / 31536000)
    }
    
 }


enum Gender {
    case male, female
}
 
