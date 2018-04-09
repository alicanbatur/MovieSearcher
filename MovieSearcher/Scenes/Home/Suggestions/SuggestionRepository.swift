//
//  SuggestionRepository.swift
//  MovieSearcher
//
//  Created by Ali Can Batur on 10/04/2018.
//  Copyright © 2018 acb. All rights reserved.
//

import Foundation

protocol SuggestionRepository {
    func save(_ suggestion: Suggestion)
    func fetch(completionHandler: @escaping (_ suggestions: [Suggestion]?) -> Void)
}
