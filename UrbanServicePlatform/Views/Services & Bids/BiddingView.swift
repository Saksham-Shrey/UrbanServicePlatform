//
//  BiddingView.swift
//  UrbanServicePlatform
//
//  Created by Saksham Shrey on 23/07/24.
//

import SwiftUI
import Firebase

struct BiddingView: View {
    
    @EnvironmentObject var authManager: AuthManager
    var serviceID: String
    var bidderID: String
    var isServicePoster: Bool = false
    
    @State private var bid: String = ""
    @State private var bids: [String : String] = [:]
    @State private var isLoading: Bool = true
    @State private var acceptedBidderID: String = ""

    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .opacity(0.8)
                .ignoresSafeArea(.all)
            
            VStack(spacing: 20) {
                if isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        ForEach(bids.sorted(by: >), id: \.key) { key, value in
                            HStack {
                                HStack {
                                    Text("Bid: ")
                                        .font(.custom("Arial", size: 15).bold())
                                        .foregroundStyle(acceptedBidderID == key ? Color.green : Color.black)
                                    
                                    Spacer()
                                    
                                    Text("\(value)")
                                        .font(.custom("Arial", size: 15).bold())
                                        .foregroundStyle(acceptedBidderID == key ? Color.green : Color.black)
                                }
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(acceptedBidderID == key ? Color.green : Color.black, lineWidth: 1)
                                }
                                
                                if authManager.currentUserRole.contains("Consumer") && isServicePoster {
                                    Button(action: {
                                        Task {
                                            await authManager.setSelectedBidder(documentID: serviceID ,bidderID: key)
                                        }
                                    }, label: {
                                        Text("Accept")
                                            .padding(12)
                                            .font(.custom("MarkerFelt-Wide", size: 16))
                                            .foregroundStyle(Color.white)
                                            .background {
                                                RoundedRectangle(cornerRadius: 20)
                                                    .fill(Color.green)
                                            }
                                    })
                                }
                            }
                        }
                    }
                }
                
                if authManager.currentUserRole.contains("Worker") {
                    HStack {
                        Text("Your Bid: ")
                            .font(.custom("MarkerFelt-Wide", size: 20))
                        TextField("Enter bid amount", text: $bid)
                            .padding(12)
                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.black, lineWidth: 2)
                            }
                    }
                    
                    Button(action: {
                        Task {
                            await authManager.addBidderToService(documentID: serviceID, bidderID: bidderID, bid: bid)
                            await loadBids()
                        }
                    }, label: {
                        Text("Place a Bid")
                            .padding(12)
                            .font(.custom("MarkerFelt-Wide", size: 16))
                            .foregroundStyle(Color.white)
                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.purple)
                            }
                    })
                }
            }
            .padding(40)
            .onAppear {
                Task {
                    await loadBids()
                    fetchAcceptedBidderID()
                }
            }
        }
    }
    
    func loadBids() async {
        authManager.fetchBidsForService(serviceID: serviceID) { result in
            switch result {
            case .success(let bids):
                self.bids = bids
                self.isLoading = false
            case .failure(let error):
                print("Error fetching bids: \(error.localizedDescription)")
                self.isLoading = false
            }
        }
    }
    
    func fetchAcceptedBidderID() {
        authManager.fetchAcceptedBidder(serviceID: serviceID) { result in
            switch result {
            case .success(let acceptedBidderID):
                self.acceptedBidderID = acceptedBidderID
                print("Accepted Bidder ID: \(acceptedBidderID)")
            case .failure(let error):
                print("Error fetching accepted bidder: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    BiddingView(serviceID: "ke7onIzJWzL8V7iHR6bx", bidderID: "R050hzq8iBh6ryMqSofLCOuvNt12")
        .environmentObject(AuthManager())
}
