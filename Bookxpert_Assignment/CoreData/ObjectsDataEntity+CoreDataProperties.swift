//
//  ObjectsDataEntity+CoreDataProperties.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 26/05/25.
//
//

import Foundation
import CoreData


extension ObjectsDataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ObjectsDataEntity> {
        return NSFetchRequest<ObjectsDataEntity>(entityName: "ObjectsDataEntity")
    }

    @NSManaged public var capacity: String?
    @NSManaged public var color: String?
    @NSManaged public var object: DeviceObjectsEntity?

}

extension ObjectsDataEntity : Identifiable {

}
