//
//  ViewController.swift
//  flixter
//
//  Created by Christopher Mena on 2/12/21.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var moviesArray = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        getAPIData()
        
    }

    
}

extension MoviesViewController {
    // API CALL
    func getAPIData() {
        API.getMovies { (movies) in
            guard let movies = movies else {
                return
            }
            self.moviesArray = movies
            self.tableView.reloadData()
        }
    }
    
    // Override prepare function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Find the selected movie
        let indexPath = self.tableView.indexPathForSelectedRow
        let movie = moviesArray[indexPath!.row]
        
        // Pass the selected movie to the details view controller
        let detailViewController = segue.destination as! MovieDetailsViewController
        detailViewController.movie = movie
        
        // Finish transition
        self.tableView.deselectRow(at: indexPath!, animated: true)
    }
    // Stubs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        let movie = moviesArray[indexPath.row]
        let title = movie["title"] as? String ?? ""
        let sypnosis = movie["overview"] as? String ?? ""
        
        cell.titleLabel.text = title
        cell.synopsisLabel.text = sypnosis
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as? String ?? ""
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        cell.posterImage.af.setImage(withURL: posterUrl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Send info
        self.performSegue(withIdentifier: "goToMovie", sender: self)
    }

}
