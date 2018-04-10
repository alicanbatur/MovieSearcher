//
//  NetworkingTests.swift
//  MovieSearcherTests
//
//  Created by Ali Can Batur on 10/04/2018.
//  Copyright © 2018 acb. All rights reserved.
//

import XCTest

@testable import MovieSearcher

class NetworkingTests: XCTestCase {
    
    var api: APIClient!
    var stubSearch: Search = Search.stub()
    
    override func setUp() {
        super.setUp()
        api = APIClient()
    }
    
    func testEndpoint() {
        let endpoint = api.endpoint(for: stubSearch)
        let expectedURL = URL(string: "http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&page=1&query=batman")
        XCTAssertEqual(endpoint, expectedURL)
    }
    
    func testRequest() {
        let expectation = self.expectation(description: "Expects movies")
        api.send(stubSearch) { (response) in
            switch response {
            case .success(let response):
                let movies = response.movies
                XCTAssertNotNil(movies)
                let first = movies?.first
                XCTAssertNotNil(first)
                XCTAssertTrue((first?.title?.lowercased().contains("batman"))!)
            case .failure( _):
                XCTFail("There should be some movies")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}

