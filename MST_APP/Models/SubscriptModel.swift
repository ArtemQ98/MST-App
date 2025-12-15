//
//  SubscriptModel.swift
//  MST_APP
//
//  Created by Артём Курочкин on 15.12.2025.
//

import Foundation

struct SubscriptModel: Identifiable{
    let id = UUID()
    let subType: SubscriptType
    let price: Int
    let sale: Int
    
    var title: String{
        subType.rawValue.capitalized
    }
}
