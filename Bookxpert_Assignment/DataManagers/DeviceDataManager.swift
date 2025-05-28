//
//  DeviceDataManager.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 28/05/25.
//

import Foundation
import CoreData


class DeviceDataManager {
    static let shared = DeviceDataManager()
    private let context = CoreDataStack.shared.viewContext
    
    // MARK: - save devicesData
    func saveDevices(_ devices: [DeviceObjects]) {
        let existingIDs = fetchDevices().map { $0.id }

        for device in devices {
            guard let deviceID = device.id, !existingIDs.contains(deviceID) else {
                continue // Skip already saved devices
            }

            let entity = DeviceObjectsEntity(context: context)
            entity.id = deviceID
            entity.name = device.name

            if let deviceData = device.data {
                let dataEntity = ObjectsDataEntity(context: context)
                dataEntity.color = deviceData.color
                dataEntity.capacity = deviceData.capacity
                entity.data = dataEntity
            }
        }
        
        // save devices
        saveContext()
    }
    
    
    func fetchDevices() -> [DeviceObjects]{
        let request: NSFetchRequest<DeviceObjectsEntity> = DeviceObjectsEntity.fetchRequest()
        request.relationshipKeyPathsForPrefetching = ["data"] // get the relationShipKey
        
        do{
            let result = try context.fetch(request)
            return result.map { deviceEntity in
                let dataObj = ObjectsData(color: deviceEntity.data?.color, capacity: deviceEntity.data?.capacity)
                
                return DeviceObjects(id: deviceEntity.id, name: deviceEntity.name, data: dataObj)
            }
        }catch{
            print("Fetch Error: \(error.localizedDescription)")
            return []
        }
    }
    
    func updateDevice(id: String, newName: String?, newColor: String?, newCapacity: String?){
        let request: NSFetchRequest<DeviceObjectsEntity> = DeviceObjectsEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        do{
            if let device = try context.fetch(request).first{
                device.name = newName
                device.data?.color = newColor
                device.data?.capacity = newCapacity
                
                try context.save()
            }
            
        }catch{
            print("Error updating device: \(error)")
        }
        
    }
    
    func deleteDevice(by id: String){
        let request: NSFetchRequest<DeviceObjectsEntity> = DeviceObjectsEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        do{
            let result = try context.fetch(request)
            if let objectToDelete = result.first{
                context.delete(objectToDelete)
                // save after delete
                saveContext()
                print("Device with id \(id) deleted successfully.")
            }
        }catch{
            print("Deletion Error: \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - save context
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Core Data Save Error: \(error.localizedDescription)")
        }
    }
}
