//
//  AppThemeViewModel.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 28/05/25.
//

import SwiftUI

class AppThemeViewModel: ObservableObject {
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @AppStorage("appTintColor") var appTintColor: Appearance = .light
    
}
