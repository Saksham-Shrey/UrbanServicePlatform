//
//  AcceptedBidsServices.swift
//  UrbanServicePlatform
//
//  Created by Saksham Shrey on 23/07/24.
//

import SwiftUI
import Firebase

struct AcceptedBidsServicesView: View {
    @EnvironmentObject var authManager: AuthManager
    
    @State var services: [ServiceModel]
    
    var body: some View {
        NavigationView(content: {
            VStack {
                List {
                    ForEach(services) { service in
                        if authManager.currentUserRole.contains("Worker") && service.serviceAcceptedBidderID == authManager.currentUserID {
                            EachServiceView(serviceModelObj: service)
                                .background(
                                    NavigationLink(
                                        destination: BiddingView(serviceID: service.id ?? "", bidderID: Auth.auth().currentUser?.uid ?? ""),
                                        label: { EmptyView()
                                                .allowsHitTesting(false)
                                        }
                                    ).opacity(0)
                                )
                        }
                    }
                    .listRowInsets(.init(top: 1, leading: 0, bottom: 1, trailing: 0))
                }
            }
            .onAppear {
                Task {
                    services = await authManager.fetchServices()
                }
            }
        })
    }
}

#Preview {
    AcceptedBidsServicesView (services: [
        ServiceModel(
            id: UUID().uuidString,
            serviceTitle: "House Cleaning",
            serviceLocation: "123 Main St, Springfield",
            servicePayType: "Hourly",
            serviceHourlyPay: "15",
            serviceLumpSumPay: "",
            serviceConsumerID: "consumer1",
            serviceAllBidders: ["bidder1": "200"],
            serviceAcceptedBidderID: "",
            serviceDuration: "2 hours",
            serviceDate: "2024-07-05",
            serviceStartingHour: "09:00",
            serviceDescription: "General house cleaning including vacuuming, dusting, and mopping."
        ),
        ServiceModel(
            id: UUID().uuidString,
            serviceTitle: "Gardening",
            serviceLocation: "456 Elm St, Springfield",
            servicePayType: "Hourly",
            serviceHourlyPay: "20",
            serviceLumpSumPay: "",
            serviceConsumerID: "consumer2",
            serviceAllBidders: ["bidder3": "200"],
            serviceAcceptedBidderID: "",
            serviceDuration: "3 hours",
            serviceDate: "2024-07-06",
            serviceStartingHour: "08:00",
            serviceDescription: "Mowing the lawn, trimming hedges, and weeding flower beds."
        ),
        ServiceModel(
            id: UUID().uuidString,
            serviceTitle: "Tutoring - Math",
            serviceLocation: "789 Oak St, Springfield",
            servicePayType: "Lump Sum",
            serviceHourlyPay: "",
            serviceLumpSumPay: "50",
            serviceConsumerID: "consumer3",
            serviceAllBidders: ["bidder4": "200"],
            serviceAcceptedBidderID: "",
            serviceDuration: "1 hour",
            serviceDate: "2024-07-07",
            serviceStartingHour: "10:00",
            serviceDescription: "One-on-one math tutoring for high school students."
        ),
        ServiceModel(
            id: UUID().uuidString,
            serviceTitle: "Pet Sitting",
            serviceLocation: "321 Maple St, Springfield",
            servicePayType: "Hourly",
            serviceHourlyPay: "10",
            serviceLumpSumPay: "",
            serviceConsumerID: "consumer4",
            serviceAllBidders: ["bidder1": "2000"],
            serviceAcceptedBidderID: "bidder6",
            serviceDuration: "4 hours",
            serviceDate: "2024-07-08",
            serviceStartingHour: "12:00",
            serviceDescription: "Watching over two small dogs, feeding, and walking them."
        ),
        ServiceModel(
            id: UUID().uuidString,
            serviceTitle: "Moving Assistance",
            serviceLocation: "654 Pine St, Springfield",
            servicePayType: "Lump Sum",
            serviceHourlyPay: "",
            serviceLumpSumPay: "100",
            serviceConsumerID: "consumer5",
            serviceAllBidders: ["bidder5": "200"],
            serviceAcceptedBidderID: "bidder5",
            serviceDuration: "5 hours",
            serviceDate: "2024-07-09",
            serviceStartingHour: "07:00",
            serviceDescription: "Help with moving furniture and boxes to a new apartment."
        )
    ])
    .environmentObject(AuthManager())
}
