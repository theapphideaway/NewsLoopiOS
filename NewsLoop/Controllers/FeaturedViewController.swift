//
//  FirstViewController.swift
//  NewsLoop
//
//  Created by ian schoenrock on 3/22/19.
//  Copyright © 2019 ian schoenrock. All rights reserved.
//

import UIKit
import Kingfisher

class FeaturedViewController: UITableViewController {

    static let newsService = NewsService()
    var newsResponse = NewsResponse()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FeaturedViewController.newsService.getCategories(category: "general"){
            (articles) in
            self.newsResponse = articles
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsResponse.articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        cell.articleTitle.text = newsResponse.articles[indexPath.row].title
        
        print(indexPath.row)
        print(newsResponse.articles.count)
        
        let url = newsResponse.articles[indexPath.row].urlToImage ?? AppConstants.defaultImage
        
        guard let escapedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return cell
        }
        
        let photoUrl = URL(string: escapedUrl)
        
        cell.articleImage.kf.setImage(with: photoUrl)
        
        cell.articleImage.layer.cornerRadius = 5;
        cell.articleImage.layer.masksToBounds = true;
        
        cell.articleSource.text = newsResponse.articles[indexPath.row].source.name
        cell.articleDate.text = newsResponse.articles[indexPath.row].publishedAt
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "FeaturedArticleSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FeaturedArticleSegue"{
            let controller = (segue.destination) as! FeaturedWebController
        let indexPath = tableView.indexPathForSelectedRow
        controller.articleUrl = newsResponse.articles[indexPath!.row].url
        }
    }
    
}

extension FeaturedViewController{
    func prepareStringForUrl(url: String) -> URL{
        let escapedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let preparedUrl = URL(string: escapedUrl!)
        return preparedUrl!
    }
}

