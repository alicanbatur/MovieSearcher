//
//  MovieModelTests.swift
//  MovieSearcherTests
//
//  Created by Ali Can Batur on 10/04/2018.
//  Copyright © 2018 acb. All rights reserved.
//

import XCTest

@testable import MovieSearcher

class ModelTests: XCTestCase {
    
    func testMovieInitilization() {
        let json = """
                {
                    "id": 1,
                    "overview": "overview",
                    "poster_path": "poster_path",
                    "release_date": "1970-01-01",
                    "title": "title"
                }
                """
        let movie = try! JSONDecoder().decode(Movie.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(movie.id, 1)
        XCTAssertEqual(movie.overview, "overview")
        XCTAssertEqual(movie.posterPath, "poster_path")
        XCTAssertEqual(movie.releaseDate, "1970-01-01")
        XCTAssertEqual(movie.title, "title")
    }
    
    func testSuggestionInitialization() {
        let title = "batman"
        let suggestion = Suggestion(movieTitle: title)
        XCTAssertEqual(suggestion.movieTitle, title)
    }
    
}
