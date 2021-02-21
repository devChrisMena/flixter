//
//  VideoViewController.swift
//  flixter
//
//  Created by Christopher Mena on 2/21/21.
//

import UIKit
import WebKit
class VideoViewController: UIViewController, WKUIDelegate {
    
    var movieId: Int!
    var webView: WKWebView!
    var key: [[String:Any]]!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getAPIData()
    }
    
    func getAPIData() {
        let vID = movieId!
        API.getVideoKeys(id: vID) { (videos) in
            guard let videos = videos else {
                return
            }
            self.key = videos
            let video = self.key.first
            let videoKey = video?["key"] as! String
            let myURL = URL(string:"https://www.youtube.com/watch?v=\(videoKey)")
            let myRequest = URLRequest(url: myURL!)
            self.webView.load(myRequest)
            print(videoKey)
        }
    }
    
}
