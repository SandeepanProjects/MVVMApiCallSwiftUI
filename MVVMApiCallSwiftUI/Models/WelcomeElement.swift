//
//  WelcomeElement.swift
//  MVVMApiCallSwiftUI
//
//  Created by Apple on 09/03/25.
//

import Foundation

// Product Model
struct Product: Codable, Identifiable {
    let productId: Int
    let quantity: Int
    
    // Unique identifier for each product
    var id: String {
        return "\(productId)-\(quantity)" // Combine productId and quantity to ensure uniqueness
    }
}

// Order Model
struct Order: Codable, Identifiable {
    let id: Int
    let userId: Int
    let date: String
    let products: [Product]
    let __v: Int
}
