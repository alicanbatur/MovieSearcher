//
//  Movie.swift
//  MovieSearcher
//
//  Created by Ali Can Batur on 09/04/2018.
//  Copyright © 2018 acb. All rights reserved.
//

import Foundation

public class Movie: Decodable {
    public var id: Int64?
    public var overview: String?
    public var posterPath: String?
    public var releaseDate: String?
    public var title: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int64?.self, forKey: .id)
        overview = try container.decode(String?.self, forKey: .overview)
        posterPath = try container.decode(String?.self, forKey: .posterPath)
        releaseDate = try container.decode(String?.self, forKey: .releaseDate)
        title = try container.decode(String.self, forKey: .title)
    }
}
