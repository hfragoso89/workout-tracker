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
    
    var userName:String
    var firstName:String
    var lastName:String
    private(set) public var image:UIImage?
    var birthdate:Date
    var gender:Gender
    var weight:Weight?
    var height:Height?
    
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
    
    init(withManagedUser user: ManagedUser) {
        if let newUserName = user.userName, User.validateUserName(newUserName) {
            self.userName = newUserName
        } else {
            self.userName = User.generateUserName()
        }
        self.firstName = user.firstName ?? ""
        self.lastName = user.lastName ?? ""
        if user.photo != nil {
            self.image = UIImage(data:user.photo!)
        } else {
            self.image = nil
        }
        self.birthdate = user.dateOfBirth ?? Date()
        if user.gender != nil {
            self.gender = user.gender == 0 ? .male : .female
        } else {
            self.gender = .undefined
        }
        if user.height != nil, user.heightUnit != nil {
            self.height = user.heightUnit == 0 ? Height(withCmValue: user.height) : user.heightUnit == 1 ? Height(withInchValue: user.height) : Height(withFtValue: user.height)
        }
        self.weight = Weight(withKgValue: user.weight)
    }
    
    func changePhoto(with image: UIImage) {
        self.image = image
    }
    
    func changeUserName(with newUserName:String) -> Bool {
        if User.validateUserName(newUserName){
            self.userName = newUserName
            return true
        }
        return false
    }
    
    func getAge() -> Int {
        return Int(Date().timeIntervalSince(self.birthdate) / 31536000)
    }
    
 }


enum Gender {
    case male, female, undefined
}
 
