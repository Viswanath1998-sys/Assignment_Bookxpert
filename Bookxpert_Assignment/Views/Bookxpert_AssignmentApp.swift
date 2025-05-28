//
//  Bookxpert_AssignmentApp.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 26/05/25.
//

import SwiftUI

@main
struct Bookxpert_AssignmentApp: App {
    let persistenceController = CoreDataStack.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var userAuth: UserAuthenticationViewModel = UserAuthenticationViewModel()
    @StateObject private var appthemeVM: AppThemeViewModel = AppThemeViewModel()
    
    init(){
        // request permission to eanable local notification
        NotificationManager.shared.requestNotificationPermission()
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootAppView()
            }
            .environment(\.managedObjectContext, persistenceController.viewContext)
            .environmentObject(userAuth)
            .environmentObject(appthemeVM)
            .applyTheme()
        }
    }
}


struct RootAppView: View {
    @EnvironmentObject var userAuth: UserAuthenticationViewModel

    var body: some View {
        Group {
            if userAuth.isLoggedIn {
                Homeview()
            } else {
                UserAuthenticationView()
            }
        }
    }
}
