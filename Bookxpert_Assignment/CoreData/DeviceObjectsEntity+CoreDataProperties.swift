//
//  DeviceObjectsEntity+CoreDataProperties.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 26/05/25.
//
//

import Foundation
import CoreData


extension DeviceObjectsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeviceObjectsEntity> {
        return NSFetchRequest<DeviceObjectsEntity>(entityName: "DeviceObjectsEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var data: ObjectsDataEntity?

}

extension DeviceObjectsEntity : Identifiable {

}
