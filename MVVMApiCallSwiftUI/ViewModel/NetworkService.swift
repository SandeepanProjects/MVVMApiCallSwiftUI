//
//  NetworkService.swift
//  MVVMApiCallSwiftUI
//
//  Created by Apple on 09/03/25.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData(from url: URL) async throws -> Data
}

class NetworkService: NetworkServiceProtocol {
    func fetchData(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

