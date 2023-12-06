//
//  NetworkManagerTest.swift
//  NetworkManagerTest
//
//  Created by Mariam Joglidze on 04.12.23.
//

import XCTest
@testable import UnitTestingAssignment 

class NetworkManagerTests: XCTestCase {

    var networkManager: NetworkManager!

    override func setUpWithError() throws {
        networkManager = NetworkManager()
    }

    override func tearDownWithError() throws {
        networkManager = nil
    }

    func testFetchProducts() {
        let expectation = XCTestExpectation(description: "Fetch products from the network")

        networkManager.fetchProducts { result in
            switch result {
            case .success(let products):
                XCTAssertNotNil(products, "Products should not be nil on successful fetch")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to fetch products with error: \(error.localizedDescription)")
            }
        }

        wait(for: [expectation], timeout: 10.0)
    }
    
    func testProductsURLValidity() {
          let productsURLString = "https://dummyjson.com/products"
          let url = URL(string: productsURLString)

          XCTAssertNotNil(url, "URL for fetching products should not be nil")
      }

}

