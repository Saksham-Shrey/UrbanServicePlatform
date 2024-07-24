//
//  ServiceCreationView.swift
//  UrbanServicePlatform
//
//  Created by Saksham Shrey on 22/07/24.
//

import SwiftUI

struct ServiceCreationView: View {
    @EnvironmentObject var authManager: AuthManager
    
    @Binding var path: [String]
    
    
    @State var newService = ServiceModel()
    
    @State var serviceTitle: String = ""
    @State var serviceLocation: String = ""
    @State var servicePayType: String = "Hourly"
    @State var serviceHourlyPay: String = ""
    @State var serviceLumpSumPay: String = ""
    @State var serviceConsumerID: String = ""
    @State var serviceAllBiddersIDs: [String] = []
    @State var serviceDuration: String = ""
    @State var tempServiceDate: Date = .now
    @State var serviceDate: String = "00-Jan-0000"
    @State var tempServiceTime: Date = .now
    @State var serviceStartingHour: String = "0000"
    @State var serviceDescription: String = ""
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(.all)
                .opacity(0.8)
            
            
            
            
            VStack (spacing: 20) {
                
                Text("Post Service")
                    .font(.custom("MarkerFelt-Wide", size: 24))
                    .kerning(1.2)
                    .padding(.bottom, 40)
                HStack {
                    Text("Title: ")
                        .font(.custom("Georgia", size: 16).bold())
                        .kerning(1.2)
                    
                    TextField("Service Title", text: $serviceTitle)
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
                    Text("Location: ")
                        .font(.custom("Georgia", size: 16).bold())
                        .kerning(1.2)
                    
                    TextField("Service Location", text: $serviceLocation)
                        .padding(12)
                        .foregroundStyle(Color.white.opacity(0.8))
                        .font(.custom("Arial", size: 15))
                        .kerning(1.5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 2)
                        }
                }
                
                HStack (alignment: .top) {
                    Text("Pay: ")
                        .font(.custom("Georgia", size: 16).bold())
                        .kerning(1.2)
                        .offset(y: 15)
                    
                    VStack {
                        HStack {
                            Text("₹")
                            
                            TextField("Enter Pay", text: servicePayType.contains("Hourly") ? $serviceHourlyPay : $serviceLumpSumPay)
                                .foregroundStyle(Color.white.opacity(0.8))
                                .font(.custom("Arial", size: 15))
                                .kerning(1.5)
                            
                            Text("\(servicePayType.contains("Hourly") ? "/ hr" : "/ only")")
                        }
                        .padding(12)
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 2)
                        }
                        
                        Picker("Type of Pay", selection: $servicePayType) {
                            Text("Hourly")
                                .tag("Hourly")
                            Text("Lump Sum")
                                .tag("LumpSum")
                        }
                        .pickerStyle(.segmented)
                        .tint(Color.black)
                    }
                }
                
                HStack {
                    Text("Duration: ")
                        .font(.custom("Georgia", size: 16).bold())
                        .kerning(1.2)
                    
                    HStack {
                        TextField("Duration", text: $serviceDuration)
                            .foregroundStyle(Color.white.opacity(0.8))
                            .font(.custom("Arial", size: 15))
                            .kerning(1.5)
                        
                        Text("hrs")
                            .font(.custom("Arial", size: 15))
                            .kerning(1.5)
                    }
                    .padding(12)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.black, lineWidth: 2)
                    }
                }
                
                
                HStack {
                    Text("Date: ")
                        .font(.custom("Georgia", size: 16).bold())
                        .kerning(1.2)
                    
                    HStack {
                        DatePicker("", selection: $tempServiceDate, displayedComponents: .date)
                            .datePickerStyle(.compact)
                    }
                    .onChange(of: tempServiceDate) { oldValue, newValue in
                        serviceDate = formattedDate(date: newValue)
                    }
                }
                
                
                HStack {
                    Text("Time: ")
                        .font(.custom("Georgia", size: 16).bold())
                        .kerning(1.2)
                    
                    HStack {
                        DatePicker("", selection: $tempServiceTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(.compact)
                        Text("\(formatTime(date: tempServiceTime))")
                        Text("\(serviceStartingHour)")
                    }
                    .onChange(of: tempServiceTime) { oldValue, newValue in
                        serviceStartingHour = formatTime(date: tempServiceTime)
                    }
                }
                
                HStack {
                    Text("Description: ")
                        .font(.custom("Georgia", size: 16).bold())
                        .kerning(1.2)
                    
                    HStack {
                        TextField("Describe the service", text: $serviceDescription)
                            .foregroundStyle(Color.white.opacity(0.8))
                            .font(.custom("Arial", size: 15))
                            .kerning(1.5)
                    }
                    .padding(12)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.black, lineWidth: 2)
                    }
                }
                
                Button(action: {

                    Task {
                        await authManager.postService(serviceTitle: serviceTitle, serviceLocation: serviceLocation, servicePayType: servicePayType, serviceHourlyPay: serviceHourlyPay, serviceLumpSumPay: serviceLumpSumPay, serviceDuration: serviceDuration, serviceDate: serviceDate, serviceStartingHour: formatTime(date: tempServiceTime), serviceDescription: serviceDescription)
                    }

                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(Color.purple)
                            .frame(maxWidth: 200, maxHeight: 50)

                        Text("Post")
                            .font(.custom("MarkerFelt-Wide", size: 18))
                            .foregroundStyle(Color.white)
                    }

                })

                
            }
            .padding(40)
            
        }
    }
    
    func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        return dateFormatter.string(from: date)
    }
    
    func formatTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HHmm"
        return dateFormatter.string(from: date)
    }
}


#Preview {
    ServiceCreationView(path: .constant([]))
        .environmentObject(AuthManager())
}
