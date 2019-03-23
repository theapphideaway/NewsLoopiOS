//
//  FirstViewController.swift
//  NewsLoop
//
//  Created by ian schoenrock on 3/22/19.
//  Copyright © 2019 ian schoenrock. All rights reserved.
//

import UIKit

class FeaturedViewController: UITableViewController {

    static let newsService = NewsService()
    var newsResponse = NewsResponse()
    
    var photos = Photos()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FeaturedViewController.newsService.getTestAPI{
            (articles, photos) in
            self.newsResponse = articles
            self.photos = photos
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
        print(photos.thumbnails.count)
        print(newsResponse.articles.count)
        cell.articleImage.image = photos.thumbnails[indexPath.row]
        cell.articleImage.layer.cornerRadius = 5;
        cell.articleImage.layer.masksToBounds = true;
        
        cell.articleSource.text = newsResponse.articles[indexPath.row].source.name
        cell.articleDate.text = newsResponse.articles[indexPath.row].publishedAt
        
        return cell
    }
}

