//
//  DeviceListViewModel.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 27/05/25.
//

import Foundation
import SwiftUI


class DeviceListViewModel: ObservableObject{
    @Published var devices: [DeviceObjects] = []
    @Published var selectedDevice: DeviceObjects? = nil
    @Published var showEditSheet = false
    
    let deviceDataManager = DeviceDataManager.shared
    
    func loadDevices(){
        devices = deviceDataManager.fetchDevices()
    }
    
    func deleteDevice(for id: String){
        deviceDataManager.deleteDevice(by: id)
        loadDevices()
    }
    
    func updateModifiedDevice(id: String, newName: String?, newColor: String?, newCapacity: String?){
        
        // allow to update if found any changes
        if let device = selectedDevice, device.name != newName || device.data?.color != newColor || device.data?.capacity != newCapacity{
            deviceDataManager.updateDevice(id: id, newName: newName, newColor: newColor, newCapacity: newCapacity)
            loadDevices()
        }
    }
}
