//
//  MoviesLoaderTests.swift
//  MovieQuizTests
//
//  Created by Mac on 20.06.2024.
//

import XCTest
@testable import MovieQuiz

class MoivesLoaderTests: XCTestCase {
    
    
    func testSuccessLoading() throws {
        
        let stubNetworkClient = StubNetworkClient(emulateError: true)
        let loader = MoviesLoader(networkClient: stubNetworkClient)
        
        let expectation = expectation(description: "Loading expectation")
        
        loader.loadMovies { result in
            
            switch result {
            case .success(let movies):
                XCTAssertEqual(movies.items.count, 2)
                expectation.fulfill()
            case .failure(_):
                XCTFail("Unexpected failure")
                
            }
            
        }
          waitForExpectations(timeout: 1)

    }
        func testFailureLoading() throws {
            
            let stubNetworkClient = StubNetworkClient(emulateError: true)
            let loader = MoviesLoader(networkClient: stubNetworkClient)
            
            let expectation = expectation(description: "Loading expectation")
            
            loader.loadMovies { result in
                
                switch result {
                case .failure(let error):
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                case .success(_):
                    XCTFail("Unexpected success")
                }
            }

            waitForExpectations(timeout: 1)

        }
        
    
    
}
