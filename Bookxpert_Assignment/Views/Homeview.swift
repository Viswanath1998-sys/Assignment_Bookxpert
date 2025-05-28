//
//  Homeview.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 27/05/25.
//

import SwiftUI
import UserNotifications

struct Homeview: View {
    @State private var isNavigateToPFDView = false
    @State private var isNavigateToDeviceList = false
    @State private var isNavigateToProfileView = false
    var body: some View {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(.systemBlue).opacity(0.3), Color.purple.opacity(0.4)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                VStack(spacing: 24){
                    Text("Welcome").font(.title2)
                    
                    DefaultButton(title: "view PDF", color: .blue) {
                        isNavigateToPFDView = true
                    }
                    
                    DefaultButton(title: "Go To DeviceList", color: .blue) {
                        isNavigateToDeviceList = true
                    }
                    
                    DefaultButton(title: "Go To Profile", color: .blue) {
                        isNavigateToProfileView = true
                    }
                    
                    // App Theme selection Toggle (Dark or light)
                    ThemeToggleView()
                    
                } .padding()

            }.navigationTitle("Home View") .navigationBarTitleDisplayMode(.inline).navigationBarBackButtonHidden(true)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .shadow(radius: 10)
                .applyTheme()
            .onAppear{
                // get and save Device objects data from api response
                ApiRepository.shared.callObjectsApi { deviceObjects in
                    DeviceDataManager.shared.saveDevices(deviceObjects)
                }
            }
            .navigationDestination(isPresented: $isNavigateToPFDView) {
                PDFViewerScreen()
            }
            .navigationDestination(isPresented: $isNavigateToDeviceList) {
                DeviceListView()
            }
            .navigationDestination(isPresented: $isNavigateToProfileView) {
                ProfileView()
            }
    }
}

#Preview {
    Homeview()
}


struct DefaultButton: View {
    let title: String
    let color: Color
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(color)
                .cornerRadius(15)
                .shadow(color: color.opacity(0.4), radius: 5, x: 0, y: 4)
        }
    }
}







