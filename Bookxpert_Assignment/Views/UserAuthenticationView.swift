//
//  UserAuthenticationView..swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 26/05/25.
//

import SwiftUI
import CoreData

struct UserAuthenticationView: View {
    @EnvironmentObject var viewModel: UserAuthenticationViewModel

    var body: some View {
          ZStack {
              // Background gradient
              LinearGradient(
                  gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.white]),
                  startPoint: .topLeading,
                  endPoint: .bottomTrailing
              ).ignoresSafeArea()

              VStack(spacing: 24) {
                  Spacer()

                  // Card container
                  VStack(spacing: 20) {
                      Text("Welcome")
                          .font(.largeTitle.bold())
                          .foregroundColor(.primary)

                      Text("Not Logged in")
                          .font(.title3)
                          .foregroundColor(.secondary)

                      Image("ic_logo").resizable().aspectRatio(contentMode: .fit)
                          .frame(width: 120, height: 120)
                          .clipShape(Circle())
                          .overlay(
                              Circle()
                                  .stroke(Color.blue.opacity(0.6), lineWidth: 3)
                          )
                          .shadow(radius: 10)

                      // Log in button
                      Button(action: {
                          viewModel.signIn()
                      }) {
                          Text("Log In")
                              .foregroundColor(.white)
                              .font(.headline)
                              .frame(maxWidth: .infinity)
                              .frame(height: 50)
                              .background(
                                  LinearGradient(
                                      gradient: Gradient(colors: [Color.blue, Color.purple]),
                                      startPoint: .leading,
                                      endPoint: .trailing
                                  )
                              ).cornerRadius(25)
                              .shadow(color: Color.blue.opacity(0.4), radius: 6, x: 0, y: 4)
                      }
                  }
                  .padding()
                  .background(.ultraThinMaterial)
                  .cornerRadius(20)
                  .shadow(radius: 10)
                  .padding(.horizontal)

                  Spacer()
              }
          }
          .navigationTitle("Login")
          .navigationBarTitleDisplayMode(.inline)
          .applyTheme()
        
          .navigationDestination(isPresented: $viewModel.isNavigateToHome) {
              Homeview()
          }
      }
}


#Preview {
    UserAuthenticationView().environment(\.managedObjectContext, CoreDataStack.shared.viewContext)
}

extension UserAuthenticationView{
    fileprivate func profilePic() -> some View{
        AsyncImage(url: URL(string: viewModel.profilePicUrl))
            .frame(width: 120, height: 120)
    }
}





