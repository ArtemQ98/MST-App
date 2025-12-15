//
//  OnboardingView.swift
//  MST_APP
//
//  Created by Артём Курочкин on 15.12.2025.
//

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage("UserIsPremium") var userIsPremium: Bool = false
    @AppStorage("Username") var username: String?
    
    @State var textFieldUsername: String = ""
    @State var navigateToPaywall: Bool = false
    
    var body: some View {
        
        if username != nil {
            PaywallView()
        }
        else{
            NavigationStack {
                VStack{
                    Image(systemName: "figure.walk")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                    Text("Добро пожаловать в тестовое приложение MST!")
                        .multilineTextAlignment(.center)
                    TextField("Ваше имя...", text: $textFieldUsername)
                        .padding(.leading)
                        .frame(height: 55)
                        .background(Color.primary.opacity(0.1)).clipShape(RoundedRectangle(cornerRadius: 12))
                    Button(action: {
                        username = textFieldUsername
                        if !textFieldUsername.isEmpty {
                            navigateToPaywall.toggle()
                        }
                    }, label: {
                        Text("Продолжить")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(.blue).clipShape(RoundedRectangle(cornerRadius: 12))
                    })
                    .navigationDestination(isPresented: $navigateToPaywall, destination: {
                        PaywallView()
                    })
                }
                .padding()
            }
        }
       
        
    }
}

#Preview {
    OnboardingView()
}
