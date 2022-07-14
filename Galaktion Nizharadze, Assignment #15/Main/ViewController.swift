//
//  ViewController.swift
//  Galaktion Nizharadze, Assignment #15
//
//  Created by Gaga Nizharadze on 12.07.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var picker = UIPickerView()
    var toolBar = UIToolbar()
    private let pickerViewComponents = ["WATCH/UNWATCH", "IS FAVOURITE/ISN'T FAVOURITE"]
    
    var genres: [String] = ["All", "Comedy", "Action", "Drama"]
    var sortByGenre = [Movie]()
    
    var movies: [Movie] = [
        Movie(title: "Fight Club", releaseDate: "11/11/1999", imdb: 8.8, mainActor: "Brad Pitt", seen: true, isFavourite: true, image: UIImage(named: "img_fightclub")!, genre: .action),
              
        Movie(title: "Udiplomo sasidzo", releaseDate: "03/04/1970", imdb: 10.0, mainActor: "Bichiko", seen: true, isFavourite: false, image: UIImage(named: "img_udiplomosasidzo")!, genre: .comedy),
        
        Movie(title: "X-men", releaseDate: "07/08/2011", imdb: 7.5, mainActor: "Logan", seen: false, isFavourite: true, image: UIImage(named: "img_x-men")!, genre: .action),
        
        Movie(title: "Interstelar", releaseDate: "05/12/2014", imdb: 8.6, mainActor: "Matthew McConaughey", seen: false, isFavourite: false, image: UIImage(named: "img_interstellar")!, genre: .action),
        
        Movie(title: "Avatar", releaseDate: "11/12/2009", imdb: 9.5, mainActor: "Aang", seen: true, isFavourite: true, image: UIImage(named: "img_avatar")!, genre: .drama),
        
        Movie(title: "Deadpool", releaseDate: "04/04/2017", imdb: 8.1, mainActor: "Ryan Reynolds", seen: false, isFavourite: false, image: UIImage(named: "img_deadpool")!, genre: .comedy),
        
        Movie(title: "Avengers", releaseDate: "23/07/2013", imdb: 5.1, mainActor: "Hulk", seen: true, isFavourite: false, image: UIImage(named: "img_avengers")!, genre: .drama),
        
        Movie(title: "Borbolia Kochi", releaseDate: "11/09/2019", imdb: 4.8, mainActor: "Peter Parker", seen: true, isFavourite: false, image: UIImage(named: "img_spiderman")!, genre: .action),
        
        Movie(title: "Benjamin Button", releaseDate: "13/01/2006", imdb: 9.8, mainActor: "Me ara", seen: true, isFavourite: true, image: UIImage(named: "img_benjaminButton")!, genre: .drama),
        
        Movie(title: "Troy", releaseDate: "15/11/2003", imdb: 8.7, mainActor: "Brad Pitt", seen: true, isFavourite: true, image: UIImage(named: "img_troy")!, genre: .action),
    ]
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortByGenre = movies
        
        configureTableAndCollectionViews()
        self.view.backgroundColor = UIColor(named: "color_backgroundColor")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func makeSelectedCellHighlighted(text: UILabel) {
        text.textColor = .yellow
    }
    
    
    private func configureTableAndCollectionViews() {
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.backgroundColor = UIColor(named: "color_backgroundColor")
        tableView.register(UINib(nibName: "MoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "MoviesTableViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    
    @IBAction func sortOptions(_ sender: UIButton) {
        
        picker = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 300))
        picker.backgroundColor = .white

        picker.delegate = self
        picker.dataSource = self

       
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
                
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    private func getWatchedFilms() -> [Movie] {
        
        let watched = sortByGenre.filter { $0.seen }
        
        return watched
    }
    
    private func getUnWatchedFilms() -> [Movie] {
        let unwatched = sortByGenre.filter { !$0.seen }
        
        return unwatched
    }
    
    private func getFavoriteFilms() -> [Movie] {
        let fav = sortByGenre.filter { $0.isFavourite }
        return fav
    }
    
    private func getUnfavoriteFilms() -> [Movie] {
        let unfav = sortByGenre.filter { !$0.isFavourite }
        return unfav
    }
    
    
    var pickerRow = 0
    
    
    private struct TableViewConstants {
        static let numberOfSections = 2
        static let heightForHeaderInSection: CGFloat = 50
        static let heightForRow: CGFloat = 406
    }
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        TableViewConstants.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: TableViewConstants.heightForHeaderInSection))
        headerView.backgroundColor =  UIColor(named: "color_backgroundColor")
        
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        if section == 0 {
            if pickerRow == 0{
                label.text = "Watched Films"
            }
            else {
                label.text = "Favorite Films"
            }
        }
        else {
            if pickerRow == 0 {
            label.text = "Unwatched Films"
            }
            else {
                label.text = "Unfavourite Films"
            }
        }
        
        label.font = .systemFont(ofSize: 26)
        label.textColor = .yellow
        
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return TableViewConstants.heightForHeaderInSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableViewConstants.heightForRow
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pickerRow == 0 {
            let watchedCount = getWatchedFilms().count
            
            if section == 0 {
                return watchedCount
            }
            else {
                return sortByGenre.count - watchedCount
            }
        }
        else {
            let favCount = getFavoriteFilms().count
            if section == 0 {
                return favCount
            }
            else {
                return sortByGenre.count - favCount
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let watchedFilms = getWatchedFilms()
        let unwatchedFilms = getUnWatchedFilms()
        
        let favFilms = getFavoriteFilms()
        let unfavFilms = getUnfavoriteFilms()
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell") as? MoviesTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        if indexPath.section == 0 {
            
            if pickerRow == 0 {
                
                cell.setUpUI(model: watchedFilms[indexPath.row])
                cell.moveToWatchButtonOutlet.titleLabel?.text = "Doesn't Watch"
                cell.moveToWatchButtonOutlet.isHidden = false
            }
            else {
                cell.setUpUI(model: favFilms[indexPath.row])
                cell.moveToWatchButtonOutlet.isHidden = true
            }
            return cell
        }
        
        else {
            
            if pickerRow == 0 {
                cell.setUpUI(model: unwatchedFilms[indexPath.row])
                cell.moveToWatchButtonOutlet.titleLabel?.text = "Watched"
            }
            else {
                cell.setUpUI(model: unfavFilms[indexPath.row])
            }
            return cell
        }
        
    }
    
    private func confUIForDetails(vc: MovieDetailsViewController, model: Movie) {
        vc.configureElements(model: model)
     
        
//        let removedSelectedMovie = movies.filter { $0 != model }
        vc.moviesWithSameGenres = movies.filter { $0.genre == model.genre }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "MovieDetails", bundle: Bundle.main)
        guard let vc = sb.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController else { return }
        
        vc.delegate = self
        
        _ = vc.view
        
        
        if indexPath.section == 0 {
            if pickerRow == 0 {
                confUIForDetails(vc: vc, model: getWatchedFilms()[indexPath.row])

            }
            else {
                confUIForDetails(vc: vc, model: getFavoriteFilms()[indexPath.row])
            }
            
        }
        else {
            pickerRow == 0 ?
            confUIForDetails(vc: vc, model: getUnWatchedFilms()[indexPath.row])
            :
            confUIForDetails(vc: vc, model: getUnfavoriteFilms()[indexPath.row])
        }
        
        
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}



extension ViewController: MovieDetailsViewControllerDelegate {
    func changeIsFavourite(_ bool: Bool, title: String) {
        
        for index in 0 ..< sortByGenre.count {
            if sortByGenre[index].title == title {
                sortByGenre[index].isFavourite = bool
                self.tableView.reloadData()
            }
        }
    }
}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerViewComponents.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewComponents[row]
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pickerRow = row
        tableView.reloadData()
    }
}


extension ViewController: MoviesTableViewCellDelegate {
    func changePosition(_ isInWatchedSection: Bool, title: String) {
        for index in 0 ..< sortByGenre.count {
            if sortByGenre[index].title == title {
                sortByGenre[index].seen = isInWatchedSection
                self.tableView.reloadData()
            }
        }
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width / 5, height: 30)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as? GenreCell
        
        cell?.genreLabel.text = genres[indexPath.row]
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0: // all
            
            sortByGenre = movies
            
            self.tableView.reloadData()
        case 1: // comedy
            sortByGenre = movies.filter { $0.genre == .comedy }
            self.tableView.reloadData()
        case 2: // action
            sortByGenre = movies.filter { $0.genre == .action }
            self.tableView.reloadData()
        case 3: // drama
            sortByGenre = movies.filter { $0.genre == .drama }
            self.tableView.reloadData()
        default:
            sortByGenre = movies
            self.tableView.reloadData()
        }
    }
    
}
