//
//  PDFKitView.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 27/05/25.
//
import UIKit
import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable{
    let url: URL
    
    func makeUIView(context: Context) -> PDFView{
        let pdfView = PDFView()
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        DispatchQueue.global(qos: .background).async{
            if let data = try? Data(contentsOf: url){
                let document = PDFDocument(data: data)
                DispatchQueue.main.async {
                    uiView.document = document
                }
            }
        }
    }
}
