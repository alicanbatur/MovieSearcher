//
//  SuggestionViewModel.swift
//  MovieSearcher
//
//  Created by Ali Can Batur on 10/04/2018.
//  Copyright © 2018 acb. All rights reserved.
//

import Foundation

struct SuggestionViewModel {
    private var suggestion: Suggestion?
    
    init(_ suggestion: Suggestion) {
        self.suggestion = suggestion
    }
    
    var title: String {
        return suggestion?.movieTitle ?? ""
    }
}
