//
//  ThemeToggleView.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 28/05/25.
//

import SwiftUI


struct ThemeToggleView: View {
    @EnvironmentObject var themeVM: AppThemeViewModel

    var body: some View {
        Toggle(
            isOn: Binding(
                get: { themeVM.isDarkMode },
                set: { themeVM.isDarkMode = $0 }
            )
        ) {
            Text(themeVM.isDarkMode ? "Disable Dark Mode" : "Enable Dark Mode")
        }
        .padding()
    }
}


#Preview {
    ThemeToggleView()
}





enum Appearance: String, CaseIterable, Identifiable {
//    case system = "System"
    case light
    case dark
    
    var id: String { self.rawValue }
    
    var tintColor: Color {
        switch self {
        case .light:
            return .white
        case .dark:
            return .primary
        }
    }
}
