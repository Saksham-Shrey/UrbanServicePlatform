//
//  UrbanServicePlatformApp.swift
//  UrbanServicePlatform
//
//  Created by Saksham Shrey on 17/07/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct UrbanServicePlatformApp: App {
    
    @StateObject var authManager = AuthManager()
    @State var isSplashScreenShowing = true

    init() {
        FirebaseApp.configure()
        
        let settings = Firestore.firestore().settings
        settings.isPersistenceEnabled = false
        Firestore.firestore().settings = settings
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if !isSplashScreenShowing {
                    HomeView()
                        .environmentObject(authManager)
                } else {
                    Image(.wallpaper)
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                    
                    Text("Urban\nService\nPlatform")
                        .padding(20)
                        .multilineTextAlignment(.center)
                        .font(.custom("MarkerFelt-Wide", size: 40))
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.black)
                                .foregroundStyle(Color.white)
                        }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isSplashScreenShowing.toggle()
                }
            }
        }
    }
}
