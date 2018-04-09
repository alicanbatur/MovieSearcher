//
//  HomeTableViewModel.swift
//  MovieSearcher
//
//  Created by Ali Can Batur on 09/04/2018.
//  Copyright © 2018 acb. All rights reserved.
//

import Foundation

protocol Observable {
    associatedtype Event
    func on(_ observer: @escaping (Event) -> Void)
}

struct Page {
    var index: Int = 1
    
    mutating func bumpUpIndex() {
        self.index += 1
    }
    
    mutating func resetIndex() {
        self.index = 1
    }
}

class HomeTableViewModel {
    
    private let api: APIClient = APIClient()
    private var observer: ((_ event: Event) -> Void)?
    private var page: Page = Page()
    
    private var movies: [Movie]?
    
    var numberOfRows: Int {
        return movies?.count ?? 0
    }
    
    func cellViewModel(at indexPath: IndexPath) -> MovieCellViewModel? {
        guard let movies = movies else { return nil }
        if indexPath.row >= movies.count { return nil }
        let movie = movies[indexPath.row]
        return MovieCellViewModel(movie)
    }
    
    func searchMovies(with title: String) {
        api.send(Search(query: title, page: page.index)) { [weak self] response in
            switch response {
            case .success(let response):
                self?.movies = response.movies
                self?.observer?(.didFetchResults)
            case .failure(let error):
                print(error)
            }
        }
        page.bumpUpIndex()
    }
    
}

extension HomeTableViewModel : Observable {
    
    enum Event {
        case didFetchResults
    }
    
    func on(_ observer: @escaping (Event) -> Void) {
        self.observer = observer
    }
}

