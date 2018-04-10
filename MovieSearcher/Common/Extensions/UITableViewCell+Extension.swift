//
//  UITableViewCell+Extension.swift
//  MovieSearcher
//
//  Created by Ali Can Batur on 09/04/2018.
//  Copyright © 2018 acb. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    // Lets me to not to use hardcoded string at cellForRow
    class func reuseIdentifier() -> String {
        return String(describing: self)
    }
    
}
