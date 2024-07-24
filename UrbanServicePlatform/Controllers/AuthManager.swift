//
//  AuthManager.swift
//  UrbanServicePlatform
//
//  Created by Saksham Shrey on 17/07/24.
//

import Foundation
import Firebase

public class AuthManager: ObservableObject {
    
    @Published var loginStatus = "Empty"
    @Published var currentUserDetails: [String : Any] = [:]
    @Published var currentUserRole: String = ""
    @Published var currentUserID: String = ""
    
    @Published var currentUserEmail: String = ""
    @Published var currentUserPassword: String = ""
    
    
    func login(email: String, password: String) async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            print("Sign In successful: \(result)")
            DispatchQueue.main.async {
                self.loginStatus = "Pass"
            }
        } catch {
            print("Error in Login: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.loginStatus = "Fail"
            }
        }
    }
    
    func register(email: String, password: String) async {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
            print("Registration successful")
        } catch {
            print("Error in registration: \(error.localizedDescription)")
        }
    }
    
    func createAccount(name: String, age: String, sex: String, phone: String, role: String) async {
        guard let user = Auth.auth().currentUser else {
            print("No user is logged in.")
            return
        }
        
        let userId = user.uid
        let db = Firestore.firestore()
        let userDetails: [String: Any] = [
            "name": name,
            "age": Int(age) ?? 0,
            "sex": sex,
            "phone": phone,
            "role": role
        ]
        
        
        try await db.collection("Users").document(userId).setData(userDetails) { error in
                  if let error = error {
                     print("Error adding User Details")
                  } else {
                      print("Document added with ID: \(userId)")
                  }
              }
    }
    
    func fetchUserDetails(userId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("Users").document(userId).getDocument { (document, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let document = document, document.exists, let data = document.data() {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document data is empty or document does not exist"])))
            }
        }
    }
    
    func setCurrentUser(userId: String) async {
        let db = Firestore.firestore()
        let docRef = db.collection("Users").document(userId)
        
        do {
            let document = try await docRef.getDocument()
            if document.exists {
                    self.currentUserDetails = document.data() ?? [:]
                                    print("User details set: \(self.currentUserDetails)")
                    self.currentUserRole = document.data()?["role"] as! String
                    self.currentUserID = userId
                print("Role set to: \(self.currentUserRole)")
            } else {
                print("Document does not exist")
            }
        } catch {
            print("Error fetching user details: \(error.localizedDescription)")
        }
    }
    
    func postService(serviceTitle: String, serviceLocation: String, servicePayType: String, serviceHourlyPay: String, serviceLumpSumPay: String, serviceAllBidders: [String: String] = [:], serviceAcceptedBidderID: String? = nil, serviceDuration: String, serviceDate: String, serviceStartingHour: String, serviceDescription: String) async {
        let db = Firestore.firestore()
        let serviceData: [String: Any] = [
            "serviceTitle": serviceTitle,
            "serviceLocation": serviceLocation,
            "servicePayType": servicePayType,
            "serviceHourlyPay": servicePayType == "Hourly" ? serviceHourlyPay : "",
            "serviceLumpSumPay": servicePayType == "LumpSum" ? serviceLumpSumPay : "",
            "serviceConsumerID": Auth.auth().currentUser?.uid ?? "",
            "serviceAllBidders": serviceAllBidders,
            "serviceAcceptedBidderID": serviceAcceptedBidderID ?? "",
            "serviceDuration": serviceDuration,
            "serviceDate": serviceDate,
            "serviceStartingHour": serviceStartingHour,
            "serviceDescription": serviceDescription
        ]
        
        do {
            let _ = try await db.collection("Services").addDocument(data: serviceData)
            print("Service posted successfully.")
        } catch {
            print("Error posting service: \(error.localizedDescription)")
        }
    }

    func fetchServices() async -> [ServiceModel] {
        let db = Firestore.firestore()
        
        do {
            let querySnapshot = try await db.collection("Services").getDocuments()
            
            let services: [ServiceModel] = querySnapshot.documents.compactMap { document in
                var service = ServiceModel(id: document.documentID)
                let data = document.data()
                
                service.serviceTitle = data["serviceTitle"] as? String ?? ""
                service.serviceLocation = data["serviceLocation"] as? String ?? ""
                service.servicePayType = data["servicePayType"] as? String ?? "Hourly"
                service.serviceHourlyPay = data["serviceHourlyPay"] as? String ?? ""
                service.serviceLumpSumPay = data["serviceLumpSumPay"] as? String ?? ""
                service.serviceConsumerID = data["serviceConsumerID"] as? String ?? ""
                service.serviceAllBidders = data["serviceAllBidders"] as? [String: String] ?? [:]
                service.serviceAcceptedBidderID = data["serviceAcceptedBidderID"] as? String ?? ""
                service.serviceDuration = data["serviceDuration"] as? String ?? ""
                service.serviceDate = data["serviceDate"] as? String ?? "00-Jan-0000"
                service.serviceStartingHour = data["serviceStartingHour"] as? String ?? ""
                service.serviceDescription = data["serviceDescription"] as? String ?? ""
                
                return service
            }
            
            return services
        } catch {
            print("Error getting documents: \(error.localizedDescription)")
            return []
        }
    }
    
    func addBidderToService(documentID: String, bidderID: String, bid: String) async {
        let db = Firestore.firestore()
        let serviceDocRef = db.collection("Services").document(documentID)
        
        do {
            let documentSnapshot = try await serviceDocRef.getDocument()
            if var serviceData = documentSnapshot.data() {
                var serviceAllBidders = serviceData["serviceAllBidders"] as? [String: String] ?? [:]
                serviceAllBidders[bidderID] = bid
                try await serviceDocRef.updateData(["serviceAllBidders": serviceAllBidders])
                print("Bidder added successfully.")
            } else {
                print("Document does not exist.")
            }
        } catch {
            print("Error updating document: \(error.localizedDescription)")
        }
    }
    
    func fetchBidsForService(serviceID: String, completion: @escaping (Result<[String: String], Error>) -> Void) {
        let db = Firestore.firestore()
        let serviceDocRef = db.collection("Services").document(serviceID)
        
        serviceDocRef.getDocument { (document, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let document = document, document.exists, let data = document.data() {
                let serviceAllBidders = data["serviceAllBidders"] as? [String: String] ?? [:]
                completion(.success(serviceAllBidders))
            } else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document data is empty or document does not exist"])))
            }
        }
    }
    
    func setSelectedBidder(documentID: String, bidderID: String) async {
        let db = Firestore.firestore()
        let serviceDocRef = db.collection("Services").document(documentID)
        
        do {
            let documentSnapshot = try await serviceDocRef.getDocument()
            if var serviceData = documentSnapshot.data() {
                var serviceAcceptedBidderID = serviceData["serviceAcceptedBidderID"] as? String ?? ""
                try await serviceDocRef.updateData(["serviceAcceptedBidderID": bidderID])
                print("Bidder Accepted successfully.")
            } else {
                print("Document does not exist.")
            }
        } catch {
            print("Error updating document: \(error.localizedDescription)")
        }
    }
    
    func fetchAcceptedBidder(serviceID: String, completion: @escaping (Result<String, Error>) -> Void) {
        let db = Firestore.firestore()
        let serviceDocRef = db.collection("Services").document(serviceID)
        
        serviceDocRef.getDocument { (document, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let document = document, document.exists, let data = document.data() {
                let serviceAcceptedBidderID = data["serviceAcceptedBidderID"] as? String ?? ""
                completion(.success(serviceAcceptedBidderID))
            } else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document data is empty or document does not exist"])))
            }
        }
    }

}
