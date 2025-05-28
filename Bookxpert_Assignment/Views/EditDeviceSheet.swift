//
//  EditDeviceSheet.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 28/05/25.
//

import SwiftUI

struct EditDeviceSheet: View {
    @Environment(\.dismiss) var dismiss
    @State var device: DeviceObjects
    @ObservedObject var viewModel: DeviceListViewModel

    @State private var newName: String = ""
    @State private var newColor: String = ""
    @State private var newCapacity: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Device Info")) {
                    TextField("Device Name", text: $newName)
                    TextField("Color", text: $newColor)
                    TextField("Capacity", text: $newCapacity)
                }
            }
            .navigationTitle("Edit Device")
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()
            }, trailing: Button("Save") {
                viewModel.updateModifiedDevice(id: device.id ?? "", newName: newName, newColor: newColor, newCapacity: newCapacity)
                dismiss()
            })
            .onAppear {
                newName = device.name ?? ""
                newColor = device.data?.color ?? ""
                newCapacity = device.data?.capacity ?? ""
            }
        }
    }
}

//#Preview {
//    EditDeviceSheet()
//}
