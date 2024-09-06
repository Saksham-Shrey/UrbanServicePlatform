//
//  TestView.swift
//  UrbanServicePlatform
//
//  Created by Saksham Shrey on 26/07/24.
//

import SwiftUI

struct TestView: View {
    var value = 100
    @State var rating = 0
    @State var review = ""
    
    var body: some View {
        HStack {
            NavigationLink {
                VStack {
                    Text("Pay ₹ \(value)")
                        .padding(12)
                        .background {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.orange, lineWidth: 2)
                        }
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Pay")
                                            .padding(12)
                                            .font(.custom("Georgia", size: 24))
                                            .foregroundStyle(.white)
                                            .background {
                                                RoundedRectangle(cornerRadius: 20)
                                                    .fill(Color.orange)
                                            }
                    })
                    
                    
                }
            } label: {
                Text("Pay")
                    .padding(12)
                    .font(.custom("Georgia", size: 24))
                    .foregroundStyle(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.orange)
                    }
            }
            
            NavigationLink {
            VStack {
                HStack {
                    Button {
                        rating = 1
                    } label: {
                        Image(systemName: "star")
                            .background {
                                rating >= 1 ? Color.yellow : Color.clear
                            }
                    }
                    
                    Button {
                        rating = 2
                    } label: {
                        Image(systemName: "star")
                            .background {
                                rating >= 2 ? Color.yellow : Color.clear
                            }
                    }
                    
                    
                    Button {
                        rating = 3
                    } label: {
                        Image(systemName: "star")
                            .background {
                                rating >= 3 ? Color.yellow : Color.clear
                            }
                    }
                    
                    
                    Button {
                        rating = 4
                    } label: {
                        Image(systemName: "star")
                            .background {
                                rating >= 4 ? Color.yellow : Color.clear
                            }
                    }
                    
                    
                    Button {
                        rating = 5
                    } label: {
                        Image(systemName: "star")
                            .background {
                                rating >= 5 ? Color.yellow : Color.clear
                            }
                    }
                }
                .padding(.all)
                
                
               TextField("", text: $review)
                    .padding(12)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 2)
                    }

                }
            .padding(.all)
            } label: {
                Text("Review")
                    .padding(12)
                    .font(.custom("Georgia", size: 24))
                    .foregroundStyle(.black)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.yellow)
                            .foregroundStyle(.white)
                    }
            }

        }
    }
}

#Preview {
    TestView()
}
