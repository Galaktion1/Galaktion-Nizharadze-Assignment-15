//
//  SameGenreMovieCollectionViewCell.swift
//  Galaktion Nizharadze, Assignment #15
//
//  Created by Gaga Nizharadze on 14.07.22.
//

import UIKit

class SameGenreMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = String(describing: SameGenreMovieCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureUIElements(title: String, image: UIImage) {
        movieImageView.image = image
        titleLabel.text = title
    }
}
