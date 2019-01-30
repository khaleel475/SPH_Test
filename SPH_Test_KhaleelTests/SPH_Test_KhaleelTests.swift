//
//  SPH_Test_KhaleelTests.swift
//  SPH_Test_KhaleelTests
//
//  Created by ShivaReddy on 30/01/19.
//  Copyright © 2019 Khaleel. All rights reserved.
//

import XCTest
@testable import SPH_Test_Khaleel

class SPH_Test_KhaleelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let session = URLSession.shared
        
        let todoEndpoint: String = "https://data.gov.sg/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        
        session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
        })
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
