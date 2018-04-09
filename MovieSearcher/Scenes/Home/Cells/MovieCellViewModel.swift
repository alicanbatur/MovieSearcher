//
//  MovieCellViewModel.swift
//  MovieSearcher
//
//  Created by Ali Can Batur on 09/04/2018.
//  Copyright © 2018 acb. All rights reserved.
//

import Foundation

class MovieCellViewModel {
    
    private var movie: Movie?
    
    init(_ movie: Movie) {
        self.movie = movie
    }
    
    var title: String {
        return movie?.title ?? ""
    }
    
    var overview: String {
        return movie?.overview ?? ""
    }
    
    var releaseDate: String {
        return movie?.releaseDate ?? ""
    }
}
