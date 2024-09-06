//
//  CurrentUserDetails.swift
//  UrbanServicePlatform
//
//  Created by Saksham Shrey on 18/07/24.
//

import SwiftUI
import Firebase

struct CurrentUserDetails: View {
    
    @EnvironmentObject var authManager: AuthManager
    @Binding var path: [String]
        
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(.all)
                .opacity(0.8)
            
            VStack (alignment: .center, spacing: 20) {
                     
                HStack {
                    Spacer()
                    
                    Button(action: {
                        do {
                            try Auth.auth().signOut()
                            authManager.clearCurrentUserData()
                            path = ["LoginView"]
                            print("Log Out done")
                        } catch {
                            print("Error in Log Out: \(error.localizedDescription)")
                        }
                        
                    }, label: {
                        Text("Log Out")
                            .padding(12)
                            .font(.custom("MarkerFelt-Wide", size: 20))
                            .foregroundColor(Color.white)
                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.purple)
                            }
                    })
                }
                .offset(y: -100)
                
                if !authManager.currentUserDetails.isEmpty && authManager.currentUserEmail.count > 2 {
                    userDetailsView
                } else {
                    ProgressView()
                }
            }
            .padding(40)
        }
        .onAppear {
            Task {
                await authManager.setCurrentUser(userId: Auth.auth().currentUser?.uid ?? "")
            }
        }
    }
    
    private var userDetailsView: some View {
        VStack {
            userInfoRow(label: "Name", value: authManager.currentUserDetails["name"] as? String)
            userInfoRow(label: "Age", value: "\(authManager.currentUserDetails["age"] as? Int ?? 0)")
            userInfoRow(label: "Sex", value: authManager.currentUserDetails["sex"] as? String)
            userInfoRow(label: "Phone", value: "\(authManager.currentUserDetails["phone"] as? Int ?? 0)")
            userInfoRow(label: "Role", value: authManager.currentUserDetails["role"] as? String)
        }
    }
    
    private func userInfoRow(label: String, value: String?) -> some View {
        HStack {
            Text("\(label): ")
                .font(.custom("Georgia", size: 16).bold())
                .kerning(1.2)
            
            Text(value ?? "N/A")
                .padding(12)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.white.opacity(0.8))
                .font(.custom("Arial", size: 16).bold())
                .kerning(1.5)
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.black.opacity(0.02), lineWidth: 2)
                        .shadow(radius: 4)
                }
        }
    }
}

extension AuthManager {
    func clearCurrentUserData() {
        self.currentUserDetails.removeAll()
        self.currentUserRole.removeAll()
        self.currentUserID.removeAll()
        self.currentUserEmail.removeAll()
        self.currentUserPassword.removeAll()
    }
}

#Preview {
    CurrentUserDetails(path: .constant([]))
        .environmentObject(AuthManager())
}
