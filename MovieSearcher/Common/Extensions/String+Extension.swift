//
//  String+Extension.swift
//  MovieSearcher
//
//  Created by Ali Can Batur on 09/04/2018.
//  Copyright © 2018 acb. All rights reserved.
//

import Foundation

extension String {
    
    func urlEncode() -> String {
        guard let encoded = self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return "" }
        return encoded
    }
    
}
