//
//  MovieDetailsViewController.swift
//  Galaktion Nizharadze, Assignment #15
//
//  Created by Gaga Nizharadze on 12.07.22.
//

import UIKit

protocol MovieDetailsViewControllerDelegate {
    func changeIsFavourite(_ bool: Bool, title: String)
}

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imdbNumberLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var commonActorLabel: UILabel!
    @IBOutlet weak var totalButtonOutlet: UIButton!
    
    @IBOutlet weak var favButtonOutlet: UIButton!
    var isFavourite: Bool?
    var movieTitle: String!
    
    var delegate: MovieDetailsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalButtonOutlet.titleLabel?.text = "Total: $\(Int.random(in: 10...100))"

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func favouriteButton(_ sender: UIButton) {
        if let isFavourite = isFavourite {
            if isFavourite {
                sender.setImage(UIImage(systemName: "heart"), for: .normal)
                delegate?.changeIsFavourite(!isFavourite, title: movieTitle)
                self.isFavourite!.toggle()
            }
            else {
                sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                delegate?.changeIsFavourite(!isFavourite, title: movieTitle)
                self.isFavourite!.toggle()
            }
        }
    }
    
    func configureElements(model: Movie) {
        
        titleLabel.text = model.title
        imdbNumberLabel.text = "\(model.imdb)"
        starsLabel.text = model.imdb.configureStars()
        releaseDateLabel.text = model.releaseDate
        commonActorLabel.text = model.mainActor
        descriptionTextView.text = model.description
        mainImageView.image = model.image
        
        movieTitle = model.title
        isFavourite = model.isFavourite
        
        if model.isFavourite {
            favButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
}
