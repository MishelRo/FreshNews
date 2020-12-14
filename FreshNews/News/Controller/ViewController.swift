//
//  ViewController.swift
//  FreshNews
//
//  Created by User on 08.12.2020.
//

import UIKit
import SDWebImage

struct source {
    var urls = ""
    var stringurl = ""
    var imageUrl = ""
    var content = ""
    var urlimg = ""
    var contents = ""
}

class ViewController: UIViewController {
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    var jsonmanager = JsonNetworkManager()
    var datafetcher = DataFeatcherService()
    var constants = source()
   
    var resize = UIImage()
    var newcell = NewsViewCell()
    var key = keys()
    var article = [Article]()
    
    func frozenStart () {
        var timer = 0.0
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in
            if timer < 1 {timer += 1 } else {
                self.ActivityIndicator.stopAnimating()
                self.ActivityIndicator.isHidden = true
                self.tabBarController?.tabBar.isHidden = false
                self.TableView.isHidden = false }
            TableView.reloadData()
        }
    }
    
    func getarticles () {
        datafetcher.fetchArticle(header: key.header, url: key.url) {[self] (modelJson) in
            
            DispatchQueue.main.async {
               article =  modelJson!.articles
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getarticles ()
        ActivityIndicator.startAnimating()
        TableView.decelerationRate = UIScrollView.DecelerationRate.init(rawValue: 0)
        TableView.isHidden = true
        frozenStart ()
        title = "Fresh News"
        
    }
}


