//
//  SuggestionTests.swift
//  MovieSearcherTests
//
//  Created by Ali Can Batur on 10/04/2018.
//  Copyright © 2018 acb. All rights reserved.
//

import XCTest

@testable import MovieSearcher

class SuggestionTests: XCTestCase {
    
    var suggestionProvider: SuggestionProvider!
    var defaults: UserDefaults!
    
    override func setUp() {
        super.setUp()
        defaults = UserDefaults(environment: .test)
        suggestionProvider = SuggestionProvider(environment: .test)
    }
    
    func testStoringSuggestion() {
        let suggestion = Suggestion(movieTitle: "batman")
        suggestionProvider.save(suggestion)
        let expectation = self.expectation(description: "Expects batman suggestion")
        suggestionProvider.fetch { (suggestions) in
            XCTAssertEqual(suggestion.movieTitle, suggestions?.first?.movieTitle)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchingSuggestions() {
        testStoringSuggestion()
        let expectation = self.expectation(description: "Expects batman suggestion")
        suggestionProvider.fetch { (suggestions) in
            XCTAssertNotNil(suggestions)
            XCTAssertTrue(suggestions!.count > 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}
