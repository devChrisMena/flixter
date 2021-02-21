//
//  MovieGridViewController.swift
//  flixter
//
//  Created by Christopher Mena on 2/20/21.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    @IBOutlet weak var collectionView: UICollectionView!
    var moviesArray = [[String:Any]]()
    var indexPath = IndexPath()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        getLayout()
        getAPIData()
    }
    

}

extension MovieGridViewController {
    // Get movies from API
    func getAPIData() {
        API.getSimilarMovies { (movies) in
            guard let movies = movies else {
                return
            }
            self.moviesArray = movies
            self.collectionView.reloadData()
        }
    }
    
    //Configure colelctionview layut
    func getLayout() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
    }
    
    // Stubs
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        // Configure cell:
        // Get images [poster]
        let movie = moviesArray[indexPath.item]
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as? String ?? ""
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        cell.posterView.af.setImage(withURL: posterUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToMovie", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Find the selected movie
        //let cell = sender as! UICollectionViewCell
        let indexPath = self.collectionView.indexPathsForSelectedItems?.first
        let movie = moviesArray[indexPath!.item]
        
        // Pass the selected movie to the details view controller
        let detailViewController = segue.destination as! MovieDetailsViewController
        detailViewController.movie = movie
    }
    
}
