//
//  ExtensionTests.swift
//  MovieSearcherTests
//
//  Created by Ali Can Batur on 10/04/2018.
//  Copyright © 2018 acb. All rights reserved.
//
import XCTest

@testable import MovieSearcher

class ExtensionTests: XCTestCase {
    
    func testEncode() {
        let expected = "http%3A%2F%2Fapi.themoviedb.org%2F3%2Fsearch%2Fmovie%3Fapi_key=2696829a81b1b5827d515ff121700838&page=2&query=batman"
        let string = "http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&page=2&query=batman"
        let encoded = string.urlEncode()
        XCTAssertEqual(encoded, expected)
    }
    
    func testTableCellNaming() {
        let movieCellName = MovieCell.reuseIdentifier()
        XCTAssertEqual(movieCellName, "MovieCell")
        
        let suggestionCellName = SuggestionCell.reuseIdentifier()
        XCTAssertEqual(suggestionCellName, "SuggestionCell")
    }

}
