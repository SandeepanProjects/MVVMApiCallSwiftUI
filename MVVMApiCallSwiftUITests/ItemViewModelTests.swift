//
//  ItemViewModelTests.swift
//  MVVMApiCallSwiftUITests
//
//  Created by Apple on 09/03/25.
//

import Foundation
import XCTest
@testable import MVVMApiCallSwiftUI

class ItemViewModelTests: XCTestCase {
    
    var viewModel: ItemViewModel!
    var mockNetworkService: MockNetworkService!
    
    @MainActor override func setUp() {
        super.setUp()
        
        // Initialize mock network service
        mockNetworkService = MockNetworkService()
        
        // Initialize the view model with the mock service
        viewModel = ItemViewModel(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        // Clean up
        viewModel = nil
        mockNetworkService = nil
        
        super.tearDown()
    }
    
    // Test successful data fetch
    func testFetchItemsSuccess() async {
        // Prepare mock data
        let json = """
        [
            {
                "id": 1,
                "userId": 1,
                "date": "2020-03-02T00:00:00.000Z",
                "products": [
                    {"productId": 1, "quantity": 4},
                    {"productId": 2, "quantity": 1}
                ],
                "__v": 0
            }
        ]
        """.data(using: .utf8)!
        
        mockNetworkService.mockData = json
        
        // Fetch items
        await viewModel.fetchItems()
        
        // Access the view model properties on the main thread
        await MainActor.run {
            // Check if items are populated correctly
            XCTAssertEqual(viewModel.items.count, 2)
            XCTAssertEqual(viewModel.items[0].productId, 1)
            XCTAssertEqual(viewModel.items[0].quantity, 4)
            XCTAssertEqual(viewModel.items[1].productId, 2)
            XCTAssertEqual(viewModel.items[1].quantity, 1)
            
            // Check that isLoading is false after fetching
            XCTAssertFalse(viewModel.isLoading)
        }
    }
    
    func testFetchItemsFailure() async {
        // Prepare mock error (simulating a network failure)
        let mockError = NSError(domain: "NetworkError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Server Error"])
        mockNetworkService.mockError = mockError
        
        // Fetch items (this should trigger a failure)
        await viewModel.fetchItems()
        
        // Access the view model properties on the main thread to verify the results
        await MainActor.run {
            // Check that the error message is set correctly
            XCTAssertEqual(viewModel.errorMessage, mockError.localizedDescription, "The error message should match the expected failure description.")
            
            // Check that isLoading is false after fetching completes (even on failure)
            XCTAssertFalse(viewModel.isLoading, "isLoading should be false after the fetch completes.")
            
            // Ensure no items are loaded due to the failure
            XCTAssertTrue(viewModel.items.isEmpty, "Items should be empty when a failure occurs.")
        }
    }
    
    func testFetchItemsNoData() async {
        // Set mock data to nil to simulate the condition where no data is available
        mockNetworkService.mockData = nil
        
        // Fetch items (this should simulate the case with no data)
        await viewModel.fetchItems()
        
        // Access the view model properties on the main thread to verify the results
        await MainActor.run {
            // Check if error message is set when no data is available
            XCTAssertEqual(viewModel.errorMessage, "No Data Available", "The error message should indicate that no data was available.")
            
            // Ensure that no items are loaded due to the absence of data
            XCTAssertTrue(viewModel.items.isEmpty, "Items should be empty when no data is available.")
            
            // Check that isLoading is false after fetching completes (even when there's no data)
            XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetching completes.")
        }
    }

}
