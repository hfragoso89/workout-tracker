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
    
}
