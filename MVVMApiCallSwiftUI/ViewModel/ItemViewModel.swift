//
//  ItemViewModel.swift
//  MVVMApiCallSwiftUI
//
//  Created by Apple on 09/03/25.
//

import Foundation
//import SwiftUI

@MainActor
class ItemViewModel: ObservableObject {
    @Published var items: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private let networkService: NetworkServiceProtocol
    private let url = URL(string: "https://fakestoreapi.com/carts")!
    
    // Inject the dependency via the initializer
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // Fetch data asynchronously
    func fetchItems() async {
        // Ensure updates to these properties are on the main thread
        isLoading = true
        errorMessage = nil
        
        do {
            let data = try await networkService.fetchData(from: url)
            let products = try JSONDecoder().decode([Order].self, from: data)
            
            // Make sure updates to @Published properties are dispatched on the main thread
            await MainActor.run {
                self.items = products.flatMap { $0.products }
                self.isLoading = false
            }
        } catch {
            // Make sure updates to @Published properties are dispatched on the main thread
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
