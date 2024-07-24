//
//  AuthView.swift
//  UrbanServicePlatform
//
//  Created by Saksham Shrey on 17/07/24.
//

import SwiftUI
import Firebase

struct AuthView: View {
    
    @EnvironmentObject var authManager: AuthManager
    
    @Binding var path: [String]
    
    @State private var email: String = "hacker@gmail.com"
    @State private var password: String = "hacker1234"
    @State private var isLogin: Bool = true
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(.all)

            VStack (spacing: 20) {
                
                VStack (spacing: 0) {
                    TextField("Enter Email", text: $email)
                        .foregroundStyle(Color.white.opacity(0.8))
                        .font(.custom("Arial", size: 18))
                        .kerning(1.5)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                    
                    Rectangle()
                        .opacity(0.4)
                        .foregroundStyle(Color.gray)
                        .frame(maxHeight: 2)
                }
                
                VStack (spacing: 0) {
                    TextField("Enter Password", text: $password)
                        .foregroundStyle(Color.white.opacity(0.8))
                        .font(.custom("Arial", size: 18))
                        .kerning(1.5)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                    
                    Rectangle()
                        .opacity(0.4)
                        .foregroundStyle(Color.gray)
                        .frame(maxHeight: 2)
                }
                
                HStack {
                    Button(action: {
                        
                        Task {
                                await authManager.login(email: email, password: password)
                                
                                
                                await authManager.setCurrentUser(userId: Auth.auth().currentUser?.uid ?? "")
                            
                            authManager.currentUserEmail = email
                            authManager.currentUserPassword = password
                            
                            path.removeAll()
                        }
                        
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(Color.purple)
                                .frame(maxWidth: 100, maxHeight: 40)
                            
                            Text("Login")
                                .font(.custom("MarkerFelt-Wide", size: 18))
                                .foregroundStyle(Color.white)
                        }
                    })
                    .padding(.vertical, 40)
                    
                    Spacer()
                    

                    Button(action: {
                        
                             path.append("UserDetails")
                        
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(Color.purple)
                                .frame(maxWidth: 100, maxHeight: 40)
                            
                            Text("Register")
                                .font(.custom("MarkerFelt-Wide", size: 18))
                                .foregroundStyle(Color.white)
                        }
                    })
                    .padding(.vertical, 40)
                }
                
            }
            .padding(40)
        }
    }
}


#Preview {
    AuthView(path: .constant([]))
        .environmentObject(AuthManager())
}
