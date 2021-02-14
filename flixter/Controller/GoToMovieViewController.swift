//
//  GoToMovieViewController.swift
//  flixter
//
//  Created by Christopher Mena on 2/12/21.
//

import UIKit
import AlamofireImage
class GoToMovieViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var sypnosisLabel: UILabel!
    @IBOutlet weak var imagePoster: UIImageView!
    var movie = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
    }
    
    
    func updateUI() {
        let title = movie["title"] as! String
        let sypnosis = movie["overview"] as! String
        let language = movie["original_language"] as! String
        let releaseDate = movie["release_date"] as! String
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        titleLabel.text = title
        releaseDateLabel.text = "Release: \(releaseDate)"
        languageLabel.text = "Language: \(language.capitalized)"
        sypnosisLabel.text = sypnosis
        imagePoster.af.setImage(withURL: posterUrl)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
