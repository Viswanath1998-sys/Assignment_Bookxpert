//
//  UserEntity+CoreDataProperties.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 26/05/25.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var profilePicURL: String?

}

extension UserEntity : Identifiable {

}
