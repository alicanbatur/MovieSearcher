//
//  SuggestionRepository.swift
//  MovieSearcher
//
//  Created by Ali Can Batur on 10/04/2018.
//  Copyright © 2018 acb. All rights reserved.
//

import Foundation

// Protocol for suggestions.
// If we want to change our repository to any other db, just implement this.
protocol SuggestionRepository {
    func save(_ suggestion: Suggestion)
    func fetch(completionHandler: @escaping (_ suggestions: [Suggestion]?) -> Void)
}
