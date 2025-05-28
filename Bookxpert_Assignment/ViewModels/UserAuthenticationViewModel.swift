//
//  UserAuthenticationViewModel.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 27/05/25.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import CoreData


class UserAuthenticationViewModel: ObservableObject{
    
    @Published var userName: String = ""
    @Published var profilePicUrl: String = ""
    @Published var email: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var isNavigateToHome: Bool = false
    @Published var errorMessage: String = ""
    
//    @Published var user: User?
    private let context = CoreDataStack.shared.viewContext
    
    init(){
        fetchUserFromCoreData()
        check()
    }
    
    func signIn() {
        guard let rootViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {
            self.errorMessage = "Unable to get rootViewController"
            return
        }
        
       /* guard let clientID = FirebaseApp.app()?.options.clientID else {
            self.errorMessage = "Missing Google Client ID from Firebase"
            return
        }

        let config = GIDConfiguration(clientID: clientID)*/
        
        Task{
            do{
                let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
                guard let idToken = result.user.idToken?.tokenString else { return }
                let accessToken = result.user.accessToken.tokenString
                
                let credentails = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
                
                let authResult = try await Auth.auth().signIn(with: credentails)
                DispatchQueue.main.async {
                    self.checkStatus()
                }
            }catch{
                DispatchQueue.main.async {
                    self.errorMessage = "Google Sign-In failed: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func check(){
        GIDSignIn.sharedInstance.restorePreviousSignIn{ [weak self] user, error in
            if let error = error{
                self?.errorMessage = "error: \(error.localizedDescription)"
            }
        }
    }
    
    func checkStatus(){
        if GIDSignIn.sharedInstance.currentUser != nil{
            guard let user = GIDSignIn.sharedInstance.currentUser else {return}
            if let givenName = user.profile?.givenName,let email = user.profile?.email,
               let profilePicURL = user.profile?.imageURL(withDimension: 100)?.absoluteString{
                self.userName = givenName
                self.profilePicUrl = profilePicURL
                self.email = email
                
                self.isLoggedIn = true
                self.isNavigateToHome = true
                
                // save to coredata
                saveUserToCoreData(user: user)
            }
            
        } else {
            self.isLoggedIn = false
            self.userName = "Not Logged In"
            self.profilePicUrl = ""
        }
    }
    
    func signOut(){
        GIDSignIn.sharedInstance.signOut()
        do{
            try Auth.auth().signOut()
        }catch{
            errorMessage =  "Google Sign-In failed: \(error.localizedDescription)"
        }
        checkStatus()
    }
    
    
    func saveUserToCoreData(user: GIDGoogleUser){
        let newUser = UserEntity(context: context)
        newUser.id = user.userID
        newUser.name = user.profile?.name
        newUser.email = user.profile?.email
        newUser.profilePicURL = user.profile?.imageURL(withDimension: 100)?.absoluteString
        
        do{
            try context.save()
            print("Google user saved to Core Data")
        }catch{
            print("Failed to save user: \(error.localizedDescription)")
        }
    }
    
    func fetchUserFromCoreData() {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        do{
            if let savedUser = try context.fetch(request).first{
                self.userName = savedUser.name ?? ""
                self.profilePicUrl = savedUser.profilePicURL ?? ""
                self.email = savedUser.email ?? ""
                self.isLoggedIn = true
            }
        }catch{
            print("Failed to fetch user: \(error.localizedDescription)")
        }
    }
}
