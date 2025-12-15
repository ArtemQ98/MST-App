//
//  MainView.swift
//  MST_APP
//
//  Created by Артём Курочкин on 15.12.2025.
//

import SwiftUI

struct MainView: View {
    
    @AppStorage("Username") var username: String?
    
    var body: some View {
        
        NavigationStack {
            VStack{
                Image("photorobot")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .foregroundStyle(.green)
                    .frame(height: 200)
                Text("Hello, \(username ?? "")")
                Spacer()
            }
            .padding(.top, 100)
            
        }
        .interactiveDismissDisabled(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MainView()
}
