//
//  Search.swift
//  MovieSearcher
//
//  Created by Ali Can Batur on 09/04/2018.
//  Copyright © 2018 acb. All rights reserved.
//

import Foundation

public struct Search: APIRequest {
    public typealias Response = [Movie]
    
    public var resourceName: String { return "search/movie" }
    
    // Parameters
    public let query: String?
    public let page: Int
    
    // Note that nil parameters will not be used
    public init(query: String?, page: Int) {
        self.query = query
        self.page = page
    }
    
    static func stub() -> Search {
        return Search(query: "batman", page: Page(index: 1).index)
    }
}
