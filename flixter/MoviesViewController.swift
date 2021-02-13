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
    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        permormRequest()
        
    }
    
    func permormRequest() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                // TODO: Get the array of movies
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                // TODO: Store the movies in a property to use elsewhere
                self.movies = dataDictionary["results"] as! [[String:Any]]
                // TODO: Reload your table view data
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
}

extension MoviesViewController {
    // Override prepare function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMovie" {
            let movieVC = segue.destination as! GoToMovieViewController
            let selectedRowIndex = self.tableView.indexPathForSelectedRow
            // Get table view object
            let movieInfo = movies[selectedRowIndex!.row]
            movieVC.movie = movieInfo
        }
        
    }
    // Stubs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let sypnosis = movie["overview"] as! String
        
        cell.titleLabel.text = title
        cell.synopsisLabel.text = sypnosis
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        cell.posterImage.af.setImage(withURL: posterUrl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Send info
        self.performSegue(withIdentifier: "goToMovie", sender: self)
    }

}
