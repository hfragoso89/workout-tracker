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
    
    class func validateUserName(_ userName:String) -> Bool {
        //TODO: Create method that validates if username is unique
        return true
    }
    
    class func generateUserName() -> String {
        var validator = false
        var newUserName = ""
        while !validator {
            newUserName = "User_\(Int.random(in:61000...150000))"
            validator = validateUserName(newUserName)
        }
        return newUserName
    }
    
    private(set) public var userName:String
    private(set) public var firstName:String
    private(set) public var lastName:String
    private(set) public var image:UIImage?
    public var birthdate:Date
    private(set) public var gender:Gender
    private(set) public var weight:Weight?
    private(set) public var height:Height?
    
    init() {
        self.userName = User.generateUserName()
        self.firstName = ""
        self.lastName = ""
        self.image = nil
        self.birthdate = Date()
        self.gender = .undefined
        self.height = nil
        self.weight = nil
    }
    
    init(
        withFirstName firstName:String,
        lastName: String,
        userName: String?,
        image: UIImage?,
        birthdate: Date,
        height: Height,
        weight: Weight,
        andGender gender:Gender
         )
    {
        if let newUserName = userName, User.validateUserName(newUserName) {
            self.userName = newUserName
        } else {
            self.userName = User.generateUserName()
        }
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
    case male, female, undefined
}
 
