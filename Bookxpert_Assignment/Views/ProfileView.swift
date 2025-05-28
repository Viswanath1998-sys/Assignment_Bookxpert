//
//  ProfileView.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 27/05/25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var changeProfileImage = false
    @State private var openCameraRoll = false
    @State private var imageSelected = UIImage()
    @State private var showSourcePicker = false
    @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary
    @EnvironmentObject var authenticationVM: UserAuthenticationViewModel
    @State private var displayImage: UIImage? = nil
    var body: some View {
        VStack(alignment: .center){
            Text("Viswanath")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top, 40)
            
            ZStack(alignment: .bottomTrailing) {
                Button {
                    // Show the action sheet to select image
                    showSourcePicker = true
                } label: {
                    // dispaly selected image
                    if let image = displayImage {
                        Image(uiImage: image)
                            .profileImageMode()
                    } else {
                        Image("ic_profile_image").profileImageMode()
                    }
                }
                
                Image(systemName: "plus")
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .clipShape(Circle()).onTapGesture {
                        showSourcePicker = true
                    }
            }
            // Bottom sheet to select source Camera or Photos
            .actionSheet(isPresented: $showSourcePicker) {
                ActionSheet(
                    title: Text("Select Image Source"),
                    message: nil,
                    buttons: [
                        .default(Text("Camera")) {
                            openCameraRoll = true
                            imageSource = .camera
                        },
                        .default(Text("Photo Library")) {
                            openCameraRoll = true
                            imageSource = .photoLibrary
                        },
                        .cancel()
                    ])
            }
            // Launch ImagePicker based on selected source
            .sheet(isPresented: $openCameraRoll, onDismiss: {
                if imageSelected != UIImage() {
                    changeProfileImage = true
                }
            }) {
                ImagePicker(selectedImage: $imageSelected, sourceType: imageSource)
            }
            
            //            DefaultButton(title: "Sign Out", color: .blue) {
            //                authenticationVM.signOut()
            //            }
            
        }.navigationTitle("Profile View").navigationBarTitleDisplayMode(.inline).navigationBarBackButtonHidden(true)
            .applyTheme() // app theme (Dark or light)
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
            .onAppear{
                // get saved image to display
                displayImage = ImageFileManager.loadImageFromDocuments()
            }
            .onChange(of: imageSelected) { newImage in
                // save iamge after selecting from camera or photos
                _ = ImageFileManager.saveImageToDocuments(image: newImage)
                
                // assign selected image to dispaly
                displayImage = imageSelected
            }
        
    }
}

#Preview {
    ProfileView()
}
