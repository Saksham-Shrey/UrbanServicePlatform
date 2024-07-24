# Urban Service Platform

![SwiftUI](https://img.shields.io/badge/SwiftUI-UI%20Framework-brightgreen)
![Firebase](https://img.shields.io/badge/Firebase-Backend%20Services-orange)

## Description

Urban Service Platform is a mobile application designed using SwiftUI and Firebase, aimed at optimizing the process of finding and hiring domestic help in urban environments. The app facilitates a streamlined interaction between service consumers and providers, ensuring efficiency and reliability.

## Features

- **User Authentication**: Secure sign-up and login using Firebase Authentication.
- **Separate Profiles**: Distinct profiles for workers and consumers, allowing personalized experiences and functionalities.
- **Service Postings**: Consumers can post services they need, including details and requirements.
- **Bidding System**: Workers can place bids on posted services, offering their rates and availability.
- **Bid Selection**: Consumers can review bids and select the one that best meets their needs.
- **Service Management for Workers**: Workers can view all posted services, including those they've bid on and those to which their bid has been accepted.
- **Service Management for Consumers**: Consumers can view and manage only the services they have posted.

## Screenshots

<img src="https://github.com/user-attachments/assets/a0cd99da-6938-4b00-9aaf-64a9cead6482" width="200">
<img src="https://github.com/user-attachments/assets/d95d85eb-5f08-47b2-ade4-b3a082da4ce5" width="200">
<img src="https://github.com/user-attachments/assets/f41f235a-b32f-479c-9dc8-89a9fb8cfdc0" width="200">
<img src="https://github.com/user-attachments/assets/9e0efa7b-838e-4859-838e-fc975940f432" width="200">
<img src="https://github.com/user-attachments/assets/10d43f00-5507-46cf-9fc9-dbfa054d6410" width="200">
<img src="https://github.com/user-attachments/assets/9ab0071d-943e-4611-958b-75b9262dadc2" width="200">
<img src="https://github.com/user-attachments/assets/80b4d180-b7cd-4872-bb55-5c36999018d2" width="200">
<img src="https://github.com/user-attachments/assets/3dd602fd-a861-4cd8-a7a4-debe2118999a" width="200">
<img src="https://github.com/user-attachments/assets/2169f0a7-7909-4bc3-82a6-5aac761245cc" width="200">
<img src="https://github.com/user-attachments/assets/62ce6347-2104-4804-9095-b4174d2fcb47" width="200">
<img src="https://github.com/user-attachments/assets/65d3eba7-fac9-4351-a734-a4e688bd8b63" width="200">
<img src="https://github.com/user-attachments/assets/790dcafc-68f6-49fb-9d6d-af05c5a389c2" width="200">
<img src="https://github.com/user-attachments/assets/80e499f3-d16e-4d51-bc4f-8133743f23a4" width="200">
<img src="https://github.com/user-attachments/assets/be76e03c-3fc6-47c2-a1bc-401f1b0f2f68" width="200">
<img src="https://github.com/user-attachments/assets/dac99516-43ef-4053-8598-05b50d59de9c" width="200">
<img src="https://github.com/user-attachments/assets/52a3b981-65c6-4265-b2b0-eb8e614a3020" width="200">
<img src="https://github.com/user-attachments/assets/dfcb732c-53d6-4617-90d3-7246a5fdfaa8" width="200">



## Installation

1. Clone the repository:

```
git clone https://github.com/saksham-shrey/UrbanServicePlatform.git
```

2. Open the project in Xcode:

```
cd UrbanServicePlatform
open UrbanServicePlatform.xcodeproj
```
or if using CocoaPods for Firebase SDK then, 
``` 
open UrbanServicePlatform.xcworkspace
```
3. Install CocoaPods dependencies (if using CocoaPods - I have used Swift Package Manager for the Firebase iOS SDK):

```
pod install
```

4. Configure Firebase:
   - Follow [Firebase Setup](https://firebase.google.com/docs/ios/setup) to set up your Firebase project and download the `GoogleService-Info.plist` file.
   - Add `GoogleService-Info.plist` to your Xcode project. (Or just use the .plist I have provided, just don't abuse it please.)

5. Build and run the project in Xcode.

## Dependencies

- **SwiftUI**: A modern UI framework for building user interfaces across all Apple platforms.
- **Firebase**: A comprehensive backend platform that includes authentication, real-time database, cloud storage, and more.

## Usage

1. Launch the app on your iOS device or simulator.
2. Sign up or log in using your credentials.
3. Consumers can post services and view their posted services.
4. Workers can browse posted services and place bids on those they are interested in.
5. Consumers can review and accept bids from workers.
6. Workers can track all posted services, including those they’ve bid on and those where their bid has been accepted.

## Architecture Features 

- **Real-Time Updates**: Optimize the app for real-time updates to avoid delays in service postings and bidding.
- **Network Connectivity**: Requires a stable internet connection for interacting with Firebase services.

## Credits

- [Firebase](https://firebase.google.com/): Backend services including Authentication, Firestore, and Cloud Storage.
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui): Official documentation for SwiftUI.
