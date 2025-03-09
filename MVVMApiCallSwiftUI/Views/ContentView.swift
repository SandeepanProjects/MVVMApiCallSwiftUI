//
//  ContentView.swift
//  MVVMApiCallSwiftUI
//
//  Created by Apple on 09/03/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ItemViewModel(networkService: NetworkService())

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    GridView(items: viewModel.items)
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchItems()
                }
            }
            .navigationTitle("Items")
        }
    }
}

