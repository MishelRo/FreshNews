//
//  ViewControoler + Extension.swift
//  FreshNews
//
//  Created by User on 13.12.2020.
//

import Foundation
import UIKit

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return article.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentArticle = article[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "123") as! NewsViewCell
        let newcells = newcell.cellConigure(cell: cell, article: currentArticle)
        return newcells
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentArticleModel = article[indexPath.row]
        self.performSegue(withIdentifier: "Web", sender: nil)
        self.constants.urls = currentArticleModel.url
        self.constants.urlimg = currentArticleModel.urlToImage ?? ""
        self.constants.contents = currentArticleModel.title ?? ""
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Web" else {return}
        let WVC = segue.destination as! WebViewController
        DispatchQueue.main.async { [self] in
            WVC.sources.stringurl = constants.urls
            WVC.sources.imageUrl = constants.urlimg
            WVC.sources.content = constants.contents
        }
    }
}
