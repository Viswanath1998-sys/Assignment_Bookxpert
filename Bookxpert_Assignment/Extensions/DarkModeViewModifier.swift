//
//  DarkModeViewModifier.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 28/05/25.
//

import SwiftUI


struct DarkModeViewModifier: ViewModifier {
    @ObservedObject var appThemeViewModel: AppThemeViewModel = AppThemeViewModel()
    
    public func body(content: Content) -> some View {
        content
            .preferredColorScheme(appThemeViewModel.isDarkMode ? .dark : appThemeViewModel.isDarkMode == false ? .light : nil)
            .accentColor(Color(appThemeViewModel.appTintColor.tintColor))
    }
}

extension View{
    func applyTheme() -> some View{
        self.modifier(DarkModeViewModifier())
    }
}
