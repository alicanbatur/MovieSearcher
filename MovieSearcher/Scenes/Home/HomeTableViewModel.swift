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
    private var lastSearchedQuery: String?
    private var pageCountForQuery: Int?
    
    var numberOfRows: Int {
        return movies?.count ?? 0
    }
    
    func cellViewModel(at indexPath: IndexPath) -> MovieCellViewModel? {
        guard let movies = movies else { return nil }
        if indexPath.row >= movies.count { return nil }
        let movie = movies[indexPath.row]
        return MovieCellViewModel(movie)
    }
    
    func searchMovies(with title: String, isNewRequest: Bool) {
        if isNewRequest { page.resetIndex() }
        lastSearchedQuery = title
        if let pageCountForQuery = pageCountForQuery, page.index > pageCountForQuery { return }
        api.send(Search(query: title, page: page.index)) { [weak self] response in
            switch response {
            case .success(let response):
                if isNewRequest {
                    self?.movies = response.movies
                    self?.pageCountForQuery = response.totalPages
                    self?.observer?(.scrollToTop)
                } else {
                    guard let moviesToAppend = response.movies, var movies = self?.movies else { return }
                    movies.append(contentsOf: moviesToAppend)
                    self?.movies = movies
                }
                self?.observer?(.didFetchResults)
            case .failure(let error):
                if let error = error as? MovieError {
                    switch error {
                    case .server(let message):
                        self?.observer?(.didFail(message))
                        break
                    default:
                        self?.observer?(.didFail("There was an error occured while parsing the data."))
                        break
                    }
                } else {
                    self?.observer?(.didFail(error.localizedDescription))
                }
            }
        }
        page.bumpUpIndex()
    }
    
    func shouldPaginate(_ indexPath: IndexPath) {
        guard let movies = movies else { return }
        if indexPath.row == movies.count - 2 {
            if let lastSearchedQuery = lastSearchedQuery {
                searchMovies(with: lastSearchedQuery, isNewRequest: false)
            }
        }
    }
    
}

extension HomeTableViewModel : Observable {
    
    enum Event {
        case didFetchResults
        case didFail(String)
        case scrollToTop
    }
    
    func on(_ observer: @escaping (Event) -> Void) {
        self.observer = observer
    }
}

