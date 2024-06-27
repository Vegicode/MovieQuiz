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
        let loader = MoviesLoader()
        
        let expectation = expectation(description: "Loading expectation")
        
        loader.loadMovies { result in
            
            switch result {
            case .success(let movies):
                expectation.fulfill()
            case .failure(_):
                XCTFail("Unexpected failure")
                
            }
            
            self.waitForExpectations(timeout: 1)
        }
        
    }
        func testFailureLoading() throws {
            
            let stubNetworkClient = StubNetworkClient(emulateError: true)
            let loader = MoviesLoader()
            
            let expectation = expectation(description: "Loading expectation")
            
            loader.loadMovies { result in
                
                switch result {
                case .success(let movies):
                    expectation.fulfill()
                case .failure(_):
                    XCTFail("Unexpected failure")
                }
                self.waitForExpectations(timeout: 1)
            }
        }
        
    
    
}
