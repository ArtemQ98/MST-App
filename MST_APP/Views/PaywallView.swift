//
//  PaywallView.swift
//  MST_APP
//
//  Created by Артём Курочкин on 15.12.2025.
//

import SwiftUI

enum SubscriptType: String{
    case month = "Ежемесячно"
    case year = "На год"
}

struct PaywallView: View {
    
    @AppStorage("UserIsPremium") var userIsPremium: Bool = false
    
    @State var typesOfSubscripts: [SubscriptModel] = [
        SubscriptModel(subType: .month, price: 5, sale: 0),
        SubscriptModel(subType: .year, price: 20, sale: 35)
    ]
    
    @State var selectedSubscript: UUID? = nil
    @State var navigateToMainView: Bool = false
    @State var showThankYouModal: Bool = false
    
    
    var body: some View {
        
        if userIsPremium {
            MainView()
        }
        else{
            NavigationStack {
                VStack{
                    Text("MST Premium")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("Используйте только лучшие приложения с подпиской MST!")
                        .multilineTextAlignment(.center)
                    List{
                        ForEach(typesOfSubscripts) { item in
                            let isSelected = item.id == selectedSubscript
                            HStack{
                                Image(systemName: isSelected ? "checkmark.circle.fill" : "checkmark.circle")
                                    .font(.headline)
                                    .foregroundStyle(.blue)
                                Text(item.title)
                                Spacer()
                                Text("\(item.price) $/\(item.subType == .month ? "месяц" : "год")")
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.smooth(duration: 0.3)){
                                    selectedSubscript = item.id
                                }
                                
                            }
                        }
                    }
                    .listStyle(.plain)
                    .frame(height: 110)
                    .scrollDisabled(true)
                    
                    Button(action: {
                        if selectedSubscript != nil{
                            showThankYouModal.toggle()
                        }
                    }, label: {
                        Text("Продолжить")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(.blue).clipShape(RoundedRectangle(cornerRadius: 12))
                    })
                    .navigationDestination(isPresented: $navigateToMainView, destination: {
                        MainView()
                    })
                    .sheet(isPresented: $showThankYouModal){
                        ThankYouModal(navigateToMainView: $navigateToMainView, showThankYouModal: $showThankYouModal)
                            .presentationDetents([.height(400)])
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    struct ThankYouModal: View {
        
        @Binding var navigateToMainView: Bool
        @Binding var showThankYouModal: Bool
        var body: some View {
            VStack{
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.green)
                    .frame(height: 100)
                    .padding(.bottom)
                    
                
                Text("Спасибо за подписку! ☺️")
                    .font(.title)
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    showThankYouModal.toggle()
                    navigateToMainView.toggle()
                }
            }
        }
    }
}

#Preview {
    PaywallView()
}
