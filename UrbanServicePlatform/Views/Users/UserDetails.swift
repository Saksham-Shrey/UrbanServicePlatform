//
//  UserDetails.swift
//  UrbanServicePlatform
//
//  Created by Saksham Shrey on 17/07/24.
//

import SwiftUI
import Firebase

struct UserDetails: View {
    
    @EnvironmentObject var authManager: AuthManager
    
    @Binding var path: [String]
    
    @State var email: String = ""
    @State var password: String = ""
    
    @State var name: String = ""
    @State var age: String = ""
    @State var sex: String = "M"
    @State var phone: String = ""
    @State var role: String = "Worker"
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(.all)
                .opacity(0.8)
            
            VStack (spacing: 20) {
                
                
                HStack {
                    Text("EMAIL: ")
                        .font(.custom("Georgia", size: 16).bold())
                        .kerning(1.2)
                    
                    TextField("Email Address", text: $email)
                        .padding(12)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .foregroundStyle(Color.white.opacity(0.8))
                        .font(.custom("Arial", size: 15))
                        .kerning(1.5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 2)
                        }
                }
                
                HStack {
                    Text("PASSWORD: ")
                        .font(.custom("Georgia", size: 16).bold())
                        .kerning(1.2)
                    
                    TextField("Password", text: $password)
                        .padding(12)
                        .keyboardType(.default)
                        .textInputAutocapitalization(.never)
                        .foregroundStyle(Color.white.opacity(0.8))
                        .font(.custom("Arial", size: 15))
                        .kerning(1.5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 2)
                        }
                }
                
                HStack {
                    Text("Name: ")
                        .font(.custom("Georgia", size: 16).bold())
                        .kerning(1.2)
                    
                    TextField("Full Name", text: $name)
                        .padding(12)
                        .foregroundStyle(Color.white.opacity(0.8))
                        .font(.custom("Arial", size: 15))
                        .kerning(1.5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 2)
                        }
                }
                
                HStack {
                    Text("Age: ")
                        .font(.custom("Georgia", size: 16).bold())
                        .kerning(1.2)
                    
                    TextField("Age in Years", text: $age)
                        .padding(12)
                        .foregroundStyle(Color.white.opacity(0.8))
                        .font(.custom("Arial", size: 15))
                        .kerning(1.5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 2)
                        }
                }
                
                HStack {
                    Text("Sex: ")
                        .font(.custom("Georgia", size: 16).bold())
                        .kerning(1.2)
                    
                    Picker("Sex", selection: $sex) {
                        Text("M")
                            .tag("M")
                        Text("F")
                            .tag("F")
                        Text("Others")
                            .tag("Others")
                    }
                    .pickerStyle(.segmented)
                    .tint(Color.black)
                }
                
                HStack {
                    Text("Phone: ")
                        .font(.custom("Georgia", size: 16).bold())
                        .kerning(1.2)
                    
                    TextField("Phone Number", text: $phone)
                        .padding(12)
                        .foregroundStyle(Color.white.opacity(0.8))
                        .font(.custom("Arial", size: 15))
                        .kerning(1.5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 2)
                        }
                }
                
                HStack {
                    Text("Role: ")
                        .font(.custom("Georgia", size: 16).bold())
                        .kerning(1.2)
                    
                    Picker("Role", selection: $role) {
                        Text("Worker")
                            .tag("Worker")
                            .foregroundColor(.black)
                            
                        
                        Text("Consumer")
                            .tag("Consumer")
                            .foregroundColor(.black)
                            
                    }
                    .pickerStyle(.segmented)
                    .tint(Color.black)
                }
                
                Button(action: {
                    Task {
                        do {
                            
                            await authManager.register(email: email, password: password)
                            
                            await authManager.createAccount(name: name, age: age, sex: sex, phone: phone, role: role)

                           
                           authManager.currentUserEmail = email
                           authManager.currentUserPassword = password
                            // Reset the form fields
                            name = ""
                            age = ""
                            sex = ""
                            phone = ""
                            role = ""
                            
                            // Navigate back
                            path.removeAll()
                            
                        } catch {
                            // Handle errors here
                            print("Error creating account or setting current user: \(error.localizedDescription)")
                        }
                    }
                    
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color.purple)
                            .frame(maxWidth: 200, maxHeight: 50)
                        
                        Text("Create Account")
                            .font(.custom("MarkerFelt-Wide", size: 18))
                            .foregroundStyle(Color.white)
                    }

                })
                .padding(.vertical, 40)
                
            }
            .padding(40)
        }
    }
    
    
}

#Preview {
    UserDetails(path: .constant([]))
        .environmentObject(AuthManager())
}
