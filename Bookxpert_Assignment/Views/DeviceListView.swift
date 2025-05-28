//
//  DeviceListView.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 27/05/25.
//

import SwiftUI


struct DeviceListView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("enableNotification") var enableNotifications: Bool = true
    @StateObject var viewModel: DeviceListViewModel = DeviceListViewModel()
    
    var body: some View {
        VStack{
            Toggle(isOn: $enableNotifications) {
                Text("Enable Notifications")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            .toggleStyle(SwitchToggleStyle(tint: .blue))
            .padding(.horizontal)
            .padding(.top)
            
            // Section Title
            Text("Saved Devices")
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            // show not found text if devices empty
            if viewModel.devices.isEmpty{
                    VStack(spacing: 12) {
                        Image(systemName: "externaldrive.badge.xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.gray)
                        
                        Text("No Devices Found")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text("Please add a new device to see it listed here.")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 32)
                    }
                    .padding(.top, 40)
            }else{
                
                // All Devices list
                List{
                    ForEach(viewModel.devices, id: \.id){ device in
                        VStack(alignment: .leading, spacing: 8){
                            HStack{
                                Text(device.name ?? "Unnamed").font(.headline)
                                Spacer(minLength: 8)
                                Button{
                                    viewModel.selectedDevice = device
                                    viewModel.showEditSheet = true
                                }label:{
                                    Image(systemName: "pencil")
                                        .padding(8)
                                        .background(Color.blue.opacity(0.1))
                                        .clipShape(Circle())
                                }
                            }
                            
                            Text("Color: \(device.data?.color ?? "N/A")")
                            Text("Capacity: \(device.data?.capacity ?? "N/A")")
                        }.padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.systemBackground))
                                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                            )
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        
                    }.onDelete { indexSet in
                        if let index = indexSet.first{
                            // find device to delete
                            let deviceTodelete = viewModel.devices[index]
                            // delete device in local data source
                            viewModel.deleteDevice(for: deviceTodelete.id ?? "")
                            // send notification when deleted if notifications enabled
                            if enableNotifications{
                                NotificationManager.shared.sendDeletedNotification(for: deviceTodelete)
                            }
                        }
                    }
                }.listStyle(PlainListStyle())
            }
        }.navigationTitle("Devices List").navigationBarTitleDisplayMode(.inline).navigationBarBackButtonHidden(true)
            .applyTheme()
        // open Device info edit sheet
            .sheet(isPresented: $viewModel.showEditSheet){
                if let device = viewModel.selectedDevice{
                    EditDeviceSheet(device: device, viewModel: viewModel)
                }
            }
            .toolbar {
                // tooolBar to Go back
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                    }
                }
            }
    }
}

#Preview {
    DeviceListView()
}




