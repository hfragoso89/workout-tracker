//
//  ManagedUser.swift
//  workout-tracker
//
//  Created by Fragoso, Hector on 3/21/20.
//  Copyright © 2020 Fragoso, Hector. All rights reserved.
//

import UIKit
import CoreData

public class ManagedUser: NSManagedObject {

    class func findOrCreateUser(matching user: User, in context:NSManagedObjectContext) throws -> ManagedUser {
        let request:NSFetchRequest<ManagedUser> = ManagedUser.fetchRequest()
        request.predicate = NSPredicate(format: "userName == %@", user.userName)
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "More than one user matching user")
                return matches [0]
            }
        } catch {
            throw error
        }
        let createdUser = ManagedUser(context:context)
        return createdUser
    }
    
    class func findMyUser(in context:NSManagedObjectContext) throws -> ManagedUser? {
        let request:NSFetchRequest<ManagedUser> = ManagedUser.fetchRequest()
        request.predicate = NSPredicate(format: "me == YES")
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "More than one user matching user")
                return matches [0]
            }
        } catch {
            throw error
        }
        
        return nil
    }
    
    class func createManagedUser(with user:User, in context:NSManagedObjectContext) -> ManagedUser {
        let createdUser = ManagedUser(context:context)
        createdUser.me = false
        createdUser.userName = user.userName
        createdUser.firstName = user.firstName
        createdUser.lastName = user.lastName
        createdUser.dateOfBirth = user.birthdate
        createdUser.gender = user.gender == .male ? 0 : 1
        if let photo = user.image {
            createdUser.photo = photo.pngData()
        }
        createdUser.heightUnit = 0
        createdUser.height = user.height?.doubleValue(for: .cm, withPrecision: 1) ?? 0.0
        createdUser.weightUnit = 0
        createdUser.weight = user.weight?.doubleValue(for: .kg, withPrecision: 1) ?? 0.0
        return createdUser
    }
    
    class func isMyUser(_ user:ManagedUser) -> Bool {
        return user.me == true
    }
}
