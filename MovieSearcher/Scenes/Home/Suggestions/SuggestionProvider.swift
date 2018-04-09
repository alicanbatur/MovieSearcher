//
//  SuggestionProvider.swift
//  MovieSearcher
//
//  Created by Ali Can Batur on 10/04/2018.
//  Copyright © 2018 acb. All rights reserved.
//

import Foundation

class SuggestionProvider: SuggestionRepository {
    
    let kSuggestionsKey: String = "suggestions"
    
    func save(_ suggestion: Suggestion) {
        let defaults = UserDefaults.standard
        var suggestionsAsStringArray: [String] = defaults.object(forKey: kSuggestionsKey) as? [String] ?? [String]()
        if let title = suggestion.movieTitle {
            if !suggestionsAsStringArray.contains(title) {
                suggestionsAsStringArray.insert(title, at: 0)
                if suggestionsAsStringArray.count > 10 {
                    suggestionsAsStringArray.removeLast()
                }
            } else {
                if let index = suggestionsAsStringArray.index(of: title) {
                    suggestionsAsStringArray.remove(at: index)
                    suggestionsAsStringArray.insert(title, at: 0)
                }
            }
        }
        defaults.set(suggestionsAsStringArray, forKey: kSuggestionsKey)
    }
    
    func fetch(completionHandler: @escaping ([Suggestion]?) -> Void) {
        let defaults = UserDefaults.standard
        let suggestionsAsStringArray: [String] = defaults.object(forKey: kSuggestionsKey) as? [String] ?? [String]()
        let suggestions: [Suggestion] = suggestionsAsStringArray.map({ Suggestion(movieTitle: $0) })
        completionHandler(suggestions)
    }
    
}
