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
    @IBOutlet weak var ratingLabel: UILabel!
    
    var movie: [String:Any]!
    //var movieID: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        posterView.isUserInteractionEnabled = true
        posterView.addGestureRecognizer(tapGestureRecognizer)
        updateUI()
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        // Action
        self.performSegue(withIdentifier: "goToVideo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Gather data
        let id = movie["id"]! as? Int ?? 0
        // Pass the selected movie to the details view controller
        let videoController = segue.destination as! VideoViewController
        videoController.movieId = id

    }
    
    
    func updateUI() {
        // Update labels
        titleLabel.text = movie["title"] as? String ?? ""
        titleLabel.sizeToFit()
        sypnosisLabel.text = movie["overview"] as? String ?? ""
        sypnosisLabel.sizeToFit()
        //ratingLabel.text = "\(movie["vote_average"] as? Int ?? 0)"
        
        // Get images [poster]
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as? String ?? ""
        let posterUrl = URL(string: baseUrl + posterPath)!
        posterView.af.setImage(withURL: posterUrl)
        
        // Get images [backdrop]
        let backdropPath = movie["backdrop_path"] as? String ?? ""
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + posterPath)!
        backDropView.af.setImage(withURL: backdropUrl)
        
        //getVideosKey(id: movie["id"] as? String ?? "")
    }
}
