//
//  ServiceModel.swift
//  UrbanServicePlatform
//
//  Created by Saksham Shrey on 22/07/24.
//

import Foundation
import Firebase

import Foundation
import Firebase

struct ServiceModel: Identifiable, Codable {
    
    var id: String?
    
    var serviceTitle: String
    var serviceLocation: String
    var servicePayType: String
    var serviceHourlyPay: String?
    var serviceLumpSumPay: String?
    var serviceConsumerID: String
    var serviceAllBidders: [String: String] // Dictionary to store bidders with bidderID as key and bid as value
    var serviceAcceptedBidderID: String?
    var serviceDuration: String
    var serviceDate: String
    var serviceStartingHour: String
    var serviceDescription: String

    init(
        id: String? = nil,
        serviceTitle: String = "",
        serviceLocation: String = "",
        servicePayType: String = "Hourly",
        serviceHourlyPay: String? = nil,
        serviceLumpSumPay: String? = nil,
        serviceConsumerID: String = "",
        serviceAllBidders: [String: String] = [:], // Initialize as empty dictionary
        serviceAcceptedBidderID: String? = nil,
        serviceDuration: String = "",
        serviceDate: String = "00-Jan-0000",
        serviceStartingHour: String = "",
        serviceDescription: String = ""
    ) {
        self.id = id
        self.serviceTitle = serviceTitle
        self.serviceLocation = serviceLocation
        self.servicePayType = servicePayType
        self.serviceHourlyPay = serviceHourlyPay
        self.serviceLumpSumPay = serviceLumpSumPay
        self.serviceConsumerID = serviceConsumerID
        self.serviceAllBidders = serviceAllBidders
        self.serviceAcceptedBidderID = serviceAcceptedBidderID
        self.serviceDuration = serviceDuration
        self.serviceDate = serviceDate
        self.serviceStartingHour = serviceStartingHour
        self.serviceDescription = serviceDescription
    }

    enum CodingKeys: String, CodingKey {
        case id
        case serviceTitle = "serviceTitle"
        case serviceLocation = "serviceLocation"
        case servicePayType = "servicePayType"
        case serviceHourlyPay = "serviceHourlyPay"
        case serviceLumpSumPay = "serviceLumpSumPay"
        case serviceConsumerID = "serviceConsumerID"
        case serviceAllBidders = "serviceAllBidders"
        case serviceAcceptedBidderID = "serviceAcceptedBidderID"
        case serviceDuration = "serviceDuration"
        case serviceDate = "serviceDate"
        case serviceStartingHour = "serviceStartingHour"
        case serviceDescription = "serviceDescription"
    }
}
