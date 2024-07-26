//
//  HomeView.swift
//  UrbanServicePlatform
//
//  Created by Saksham Shrey on 17/07/24.
//


import SwiftUI
import Firebase

struct HomeView: View {
    @EnvironmentObject var authManager: AuthManager
    @State var path: [String] = []
    
    var body: some View {
        TabView {
            NavigationStack(path: $path) {
                VStack {
                    
                    Spacer()
                    
                    if authManager.currentUserRole.contains("Consumer") {
                        Button(action: {
                            path.append("CreateService")
                        }, label: {
                            ServiceCard(title: "Create Service", icon: "plus.circle.fill")
                        })
                        
                    } else if authManager.currentUserRole.contains("Worker") {
                        
                        Button(action: {
                            path.append("AcceptedBidsServicesView")
                        }, label: {
                            ServiceCard(title: "Accepted Services", icon: "list.bullet")
                        })
                    } else {
                        Text("Log In or Register to Access")
                            .font(.custom("MarkerFelt-Wide", size: 24))
                    }
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("Home")
                .onAppear {
                    path.removeAll()
                }
                .onAppear {
                    if let currentUser = Auth.auth().currentUser {
                        Task {
                            await authManager.setCurrentUser(userId: currentUser.uid)
                        }
                        path.removeAll()
                    } else {
                        path.append("Auth")
                    }
                }
                .navigationDestination(for: String.self) { value in
                    switch value {
                    case "Auth":
                        AuthView(path: $path)
                    case "CurrentUserDetails":
                        CurrentUserDetails(path: $path)
                    case "CreateService":
                        ServiceCreationView(path: $path)
                    case "ServicesView":
                        ServicesView(services: [])
                            .navigationTitle("Services")
                    case "UserDetails":
                        UserDetails(path: $path)
                            .navigationBarBackButtonHidden()
                    case "AcceptedBidsServicesView":
                        AcceptedBidsServicesView(services: [])
                            .navigationTitle("Accepted Services")
                    default:
                        Text("Unknown Destination")
                    }
                }
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            NavigationView {
                ServicesView(services: [])
                    .navigationTitle("Services")
                    .navigationBarBackButtonHidden()
            }
            .tabItem {
                Label("Services", systemImage: "list.bullet")
            }
            
            NavigationView {
                CurrentUserDetails(path: $path)
                    .navigationTitle("Profile")
                    .navigationBarBackButtonHidden()
            }
            .tabItem {
                Label("Profile", systemImage: "person.fill")
            }
        }
    }
}

struct ServiceCard: View {
    var title: String
    var icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
            
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding()
        .background(Color.blue)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthManager())
}




//import SwiftUI
//import Firebase
//
//struct HomeView: View {
//    
//    @EnvironmentObject var authManager: AuthManager
//    
//    @State var path: [String] = []
//    
//    var body: some View {
//        NavigationStack(path: $path) {
//            VStack {
//                Text("Hello")
//                
//                Button(action: {
//                    path.append("Auth")
//                }, label: {
//                    Text("Auth !!")
//                })
//                
//                Button(action: {
//                    path.append("CurrentUserDetails")
//                }, label: {
//                    Text("Current User Details !!")
//                })
//                
//                Button(action: {
//                    do {
//                        try Auth.auth().signOut()
//                    } catch {
//                        print("Error in Sign Out")
//                    }
//                }, label: {
//                    Text("Sign Out")
//                })
//                
//                Button(action: {
//                    path.append("CreateService")
//                }, label: {
//                    Text("Create Service !!")
//                })
//                
//                Button(action: {
//                    path.append("ServicesView")
//                }, label: {
//                    Text("All Services !!")
//                })
//                
//                Button(action: {
//                    path.append("AcceptedBidsServicesView")
//                }, label: {
//                    Text("All Services !!")
//                })
//
//
//
//
//            }
//            .onAppear {
//                if let currentUser = Auth.auth().currentUser {
//                    Task {
//                        await authManager.setCurrentUser(userId: currentUser.uid)
//                    }
//                } else {
//                    path.append("Auth")
//                }
//            }
//            .navigationDestination(for: String.self) { value in
//                if value == "Auth" {
//                    AuthView(path: $path)
//                } else if value == "UserDetails" {
//                    UserDetails(path: $path)
//                } else if value == "CurrentUserDetails" {
//                    CurrentUserDetails(path: $path)
//                }  else if value == "CreateService" {
//                    ServiceCreationView(path: $path)
//                } else if value == "ServicesView" {
//                    ServicesView(services: [])
//                        .navigationTitle("Services")
//                } else if value == "AcceptedBidsServicesView" {
//                    AcceptedBidsServicesView(services: [])
//                        .navigationTitle("Accepted Services")
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    HomeView()
//        .environmentObject(AuthManager())
//}
