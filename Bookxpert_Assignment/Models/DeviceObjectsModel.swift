//
//  DeviceObjectsModel.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 27/05/25.
//
import Foundation

struct DeviceObjects : Codable {
    var id : String?
    var name : String?
    var data : ObjectsData?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case data = "data"
    }
}


struct ObjectsData : Codable {
    var color : String?
    var capacity : String?

    enum CodingKeys: String, CodingKey {

        case color = "color"
        case capacity = "capacity"
    }
}

