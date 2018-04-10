//
//  SuggestionCell.swift
//  MovieSearcher
//
//  Created by Ali Can Batur on 10/04/2018.
//  Copyright © 2018 acb. All rights reserved.
//

import UIKit

class SuggestionCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    // When the viewmodel is set, populates views.
    var viewModel: SuggestionViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.title
        }
    }

}
