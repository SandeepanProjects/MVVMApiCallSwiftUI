//
//  GridView.swift
//  MVVMApiCallSwiftUI
//
//  Created by Apple on 09/03/25.
//

import Foundation
import SwiftUI

struct GridView: View {
    let items: [Product]
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]  // Define the number of columns in the grid
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(items, id: \.id) { item in
                    VStack {
                        Text(String(item.productId))
                            .font(.headline)
                        Text(String(item.quantity))
                            .font(.subheadline)
                            .lineLimit(2)
                            .truncationMode(.tail)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
                }
            }
            .padding()
        }
    }
}

