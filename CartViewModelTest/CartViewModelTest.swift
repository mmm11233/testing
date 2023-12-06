//
//  CartViewModelTest.swift
//  CartViewModelTest
//
//  Created by Mariam Joglidze on 03.12.23.
//

import XCTest
@testable import UnitTestingAssignment

final class CartViewModelTest: XCTestCase {
    
    var cartViewModel: CartViewModel!

       override func setUp() {
           super.setUp()
           cartViewModel = CartViewModel()
           cartViewModel.allproducts = ProductsResponse.dummyProducts
       }

       override func tearDown() {
           cartViewModel = nil
           super.tearDown()
       }

       func testFetchProducts() {
           cartViewModel.fetchProducts()
           XCTAssertNotNil(cartViewModel.allproducts)
       }

       func testAddProduct() {
           let productToAdd = ProductsResponse.dummyProducts.first
           cartViewModel.addProduct(product: productToAdd)
           XCTAssertTrue(cartViewModel.selectedProducts.contains(where: { $0.id == productToAdd?.id }))
       }

       func testAddRandomProduct() {
           cartViewModel.addRandomProduct()
           XCTAssertFalse(cartViewModel.selectedProducts.isEmpty)
       }

       func testRemoveProduct() {
           let productToRemove = ProductsResponse.dummyProducts.first
           cartViewModel.addProduct(product: productToRemove)
           cartViewModel.removeProduct(withID: productToRemove?.id ?? 0)
           XCTAssertFalse(cartViewModel.selectedProducts.contains(where: { $0.id == productToRemove?.id }))
       }

       func testClearCart() {
           cartViewModel.clearCart()
           XCTAssertTrue(cartViewModel.selectedProducts.isEmpty)
       }

       func testSelectedItemsQuantity() {
           cartViewModel.selectedProducts = ProductsResponse.dummyProducts
           let expectedQuantity = ProductsResponse.dummyProducts.reduce(0) { $0 + ($1.selectedQuantity ?? 0) }
           XCTAssertEqual(cartViewModel.selectedItemsQuantity, expectedQuantity)
       }

       func testTotalPrice() {
           cartViewModel.selectedProducts = ProductsResponse.dummyProducts
           let expectedTotalPrice = ProductsResponse.dummyProducts.reduce(0.0) { $0 + Double($1.selectedQuantity ?? 0) * ($1.price ?? 0) }
           XCTAssertEqual(cartViewModel.totalPrice, expectedTotalPrice)
       }
   

}
