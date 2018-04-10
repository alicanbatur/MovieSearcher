//
//  UserDefaults+Extension.swift
//  MovieSearcher
//
//  Created by Ali Can Batur on 10/04/2018.
//  Copyright © 2018 acb. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    convenience init?(environment: Environment) {
        self.init(suiteName: environment.rawValue)
    }
    
}
