//
//  PDFViewerScreen.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 26/05/25.
//

import SwiftUI

struct PDFViewerScreen: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(.systemGray6), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
                VStack(alignment: .leading, spacing: 16) {
                    Text("Balance Sheet")
                        .font(.largeTitle.bold())
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                    // show pdf view from url
                    if let url = URL(string: "https://fssservices.bookxpert.co/GeneratedPDF/Companies/nadc/2024-2025/BalanceSheet.pdf"){
                        PDFKitView(url: url)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .cornerRadius(20)
                            .padding()
                            .background(.ultraThinMaterial)
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    }else{
                        Text("Invalid PDF URL").font(.caption)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
        }.navigationBarTitleDisplayMode(.inline).navigationBarBackButtonHidden(true)
            .applyTheme()
            .toolbar {
                // tooolBar button to Go back
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
    PDFViewerScreen()
}
