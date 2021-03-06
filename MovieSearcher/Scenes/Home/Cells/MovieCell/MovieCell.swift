//
//  MovieCell.swift
//  MovieSearcher
//
//  Created by Ali Can Batur on 09/04/2018.
//  Copyright © 2018 acb. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieAvatarImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    
    // When the viewmodel is set, populates views.
    var viewModel: MovieCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            movieTitleLabel.text = viewModel.title
            movieDescriptionLabel.text = viewModel.overview
            movieDateLabel.text = viewModel.releaseDate
            
            movieAvatarImageView.kf.setImage(with: viewModel.imagePath)
        }
    }
    
}
