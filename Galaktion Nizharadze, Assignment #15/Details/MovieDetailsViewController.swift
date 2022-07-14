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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imdbNumberLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var mainActorLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var totalButtonOutlet: UIButton!
    @IBOutlet weak var favButtonOutlet: UIButton!
    
    var isFavourite: Bool?
    var movieTitle: String!
    var moviesWithSameGenres = [Movie]()
    var currentMovieModel: Movie!
    var delegate: MovieDetailsViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalButtonOutlet.titleLabel?.text = "Total: $\(Int.random(in: 10...100))"
        scrollView.backgroundColor = UIColor(named: "color_backgroundColor")
        
        collectionView.delegate = self
        collectionView.dataSource = self
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
        
        currentMovieModel = model
        
        titleLabel.text = model.title
        imdbNumberLabel.text = "\(model.imdb)"
        starsLabel.text = model.imdb.configureStars()
        
        descriptionTextView.text = model.description
        mainImageView.image = model.image
        
        genreLabel.text = model.genre.rawValue
        releaseDateLabel.text = model.releaseDate
        mainActorLabel.text = model.mainActor
        
        
        movieTitle = model.title
        isFavourite = model.isFavourite
        
        if model.isFavourite {
            favButtonOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
}

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        moviesWithSameGenres.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SameGenreMovieCollectionViewCell.identifier, for: indexPath) as! SameGenreMovieCollectionViewCell
        
        let currentMovie = moviesWithSameGenres[indexPath.row]
        cell.configureUIElements(title: currentMovie.title, image: currentMovie.image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 200, height: 155)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        configureElements(model: moviesWithSameGenres[indexPath.row])
    }
}
