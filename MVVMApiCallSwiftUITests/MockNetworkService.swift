//
//  MockNetworkService.swift
//  MVVMApiCallSwiftUITests
//
//  Created by Apple on 09/03/25.
//

import Foundation
import XCTest
@testable import MVVMApiCallSwiftUI

// Mock Network Service for testing
class MockNetworkService: NetworkServiceProtocol {
    var mockData: Data?
    var mockError: Error?
    
    func fetchData(from url: URL) async throws -> Data {
        if let error = mockError {
            throw error
        }
        guard let data = mockData else {
            throw NSError(domain: "MockError", code: 404, userInfo: [NSLocalizedDescriptionKey: "No Data Available"])
        }
        return data
    }
}
