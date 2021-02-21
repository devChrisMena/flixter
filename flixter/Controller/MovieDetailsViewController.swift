//
//  GoToMovieViewController.swift
//  flixter
//
//  Created by Christopher Mena on 2/12/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backDropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sypnosisLabel: UILabel!
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       updateUI()
    }
    
    func updateUI() {
        // Update labels
        titleLabel.text = movie["title"] as? String ?? ""
        titleLabel.sizeToFit()
        sypnosisLabel.text = movie["overview"] as? String ?? ""
        sypnosisLabel.sizeToFit()
        
        // Get images [poster]
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as? String ?? ""
        let posterUrl = URL(string: baseUrl + posterPath)!
        posterView.af.setImage(withURL: posterUrl)
        
        // Get images [backdrop]
        let backdropPath = movie["backdrop_path"] as? String ?? ""
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + posterPath)!
        backDropView.af.setImage(withURL: backdropUrl)
    }

}
