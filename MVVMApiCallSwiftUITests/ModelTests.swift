//
//  ModelTests.swift
//  MVVMApiCallSwiftUITests
//
//  Created by Apple on 09/03/25.
//

import XCTest
@testable import MVVMApiCallSwiftUI // Replace with your app module name

class ModelTests: XCTestCase {

    // Test for the Product model
    func testProductInitialization() {
        // Arrange
        let productId = 1
        let quantity = 10
        
        // Act
        let product = Product(productId: productId, quantity: quantity)
        
        // Assert
        XCTAssertEqual(product.productId, productId, "Product productId should match the initialized value")
        XCTAssertEqual(product.quantity, quantity, "Product quantity should match the initialized value")
        XCTAssertEqual(product.id, "\(productId)-\(quantity)", "Product id should be a concatenation of productId and quantity")
    }

    // Test for the Order model initialization
    func testOrderInitialization() {
        // Arrange
        let orderId = 1
        let userId = 101
        let date = "2022-05-01T00:00:00.000Z"
        let products = [
            Product(productId: 1, quantity: 5),
            Product(productId: 2, quantity: 3)
        ]
        let v = 0
        
        // Act
        let order = Order(id: orderId, userId: userId, date: date, products: products, __v: v)
        
        // Assert
        XCTAssertEqual(order.id, orderId, "Order id should match the initialized value")
        XCTAssertEqual(order.userId, userId, "Order userId should match the initialized value")
        XCTAssertEqual(order.date, date, "Order date should match the initialized value")
        XCTAssertEqual(order.products.count, products.count, "Order products should match the initialized count")
        
        // Check the products in the order
        XCTAssertEqual(order.products[0].productId, 1, "First product's productId should match the initialized value")
        XCTAssertEqual(order.products[0].quantity, 5, "First product's quantity should match the initialized value")
        XCTAssertEqual(order.products[1].productId, 2, "Second product's productId should match the initialized value")
        XCTAssertEqual(order.products[1].quantity, 3, "Second product's quantity should match the initialized value")
    }

    // Test that Product's computed id is unique for each combination of productId and quantity
    func testProductIdUniqueness() {
        // Arrange
        let product1 = Product(productId: 1, quantity: 5)
        let product2 = Product(productId: 1, quantity: 5)
        let product3 = Product(productId: 2, quantity: 3)
        
        // Act & Assert
        XCTAssertEqual(product1.id, product2.id, "Products with same productId and quantity should have the same unique id")
        XCTAssertNotEqual(product1.id, product3.id, "Products with different productId or quantity should have different unique ids")
    }

}
