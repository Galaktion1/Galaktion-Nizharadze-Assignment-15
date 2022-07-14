//
//  MoviesTableViewCell.swift
//  Galaktion Nizharadze, Assignment #15
//
//  Created by Gaga Nizharadze on 12.07.22.
//

import UIKit

protocol MoviesTableViewCellDelegate {
    func changePosition(_ isInWatchedSection: Bool, title: String)
}

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var mainCharacter: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var imdbNumberLabel: UILabel!
    @IBOutlet var starsLabel: UILabel!
    @IBOutlet var moveToWatchButtonOutlet: UIButton!
    
    private var isWatched: Bool!
    private var movieTitle: String!
    var delegate: MoviesTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func moveToWatchButton(_ sender: UIButton) {
        
        delegate?.changePosition(isWatched, title: movieTitle)
        
        if isWatched { 
            delegate?.changePosition(!isWatched, title: movieTitle)
            self.isWatched.toggle()
        }
        else {
            delegate?.changePosition(!isWatched, title: movieTitle)
            self.isWatched.toggle()
        }
    }
    
    
    
    func setUpUI(model: Movie) {
        movieImageView.image = model.image
        titleLabel.text = model.title
        mainCharacter.text = model.mainActor
        timeLabel.text = model.releaseDate
        imdbNumberLabel.text = "\(model.imdb)"
        starsLabel.text = model.imdb.configureStars()
        isWatched = model.seen
        movieTitle = model.title
    }
}



extension Double {
    func configureStars() -> String {
       String(repeating: "⭐️", count: Int(self / 2))
    }
}
