//
//  Search.swift
//  MovieSearcher
//
//  Created by Ali Can Batur on 09/04/2018.
//  Copyright © 2018 acb. All rights reserved.
//

import Foundation

// Request class. If you want to add a new endpoint, you should create a new request class with APIRequest protocol.
public struct Search: APIRequest {
    public typealias Response = [Movie]
    
    public var resourceName: String { return "search/movie" }
    
    // Parameters
    public let query: String?
    public let page: Int
    
    public init(query: String?, page: Int) {
        self.query = query
        self.page = page
    }
    
    // Stub data for tests.
    static func stub() -> Search {
        return Search(query: "batman", page: Page(index: 1).index)
    }
}
