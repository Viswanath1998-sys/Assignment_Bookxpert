//
//  ImageExtension.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 27/05/25.
//
import SwiftUI


extension Image{
    func profileImageMode() -> some View{
        self
            .resizable()
            .frame(width: 120, height: 120)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 6)
    }
}



