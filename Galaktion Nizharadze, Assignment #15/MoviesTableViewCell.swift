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
    
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainCharacter: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imdbNumberLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var moveToWatchButtonOutlet: UIButton!
    
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
    
    func removeWatchButtonFromSuperview() {
        moveToWatchButtonOutlet.removeFromSuperview()
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
