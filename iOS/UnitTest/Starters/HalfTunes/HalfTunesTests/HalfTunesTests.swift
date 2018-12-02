//
//  HalfTunesTests.swift
//  HalfTunesTests
//
//  Created by YYang on 2/12/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import XCTest
@testable import HalfTunes

class HalfTunesTests: XCTestCase {
    var sessionUnderTest: URLSession!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sessionUnderTest = nil
        super.tearDown()
    }

    func testValidCallToiTunesGetsHTTPStatusCode200() {
        //1. given
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")
        let promis = expectation(description: "Status code: 200")
        
        //2. when
        let task = sessionUnderTest.dataTask(with: url!) { (data, res, error) in
            //3. then
            guard error == nil  else{
                XCTFail("Error: \(error!.localizedDescription)")
                return
            }
            
            guard let response = res as? HTTPURLResponse else { return }
            if response.statusCode == 200{
                promis.fulfill()
            }else{
                 XCTFail("Status code: \(response.statusCode)")
            }

        }
        
        task.resume()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
    // Asynchronous test: faster fail
    func testCallToiTunesCompletes() {
        // given
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")
        // 1
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            // 2
            promise.fulfill()
        }
        dataTask.resume()
        // 3
        waitForExpectations(timeout: 5, handler: nil)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    

    
    
  

}
