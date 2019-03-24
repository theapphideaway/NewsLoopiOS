//
//  CategoryDetailViewController.swift
//  NewsLoop
//
//  Created by ian schoenrock on 3/23/19.
//  Copyright © 2019 ian schoenrock. All rights reserved.
//

import UIKit

class CategoryDetailViewController: UITableViewController {

    var category = String()
    static let newsService = NewsService()
    var newsResponse = NewsResponse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FeaturedViewController.newsService.getCategories(category: category){
            (articles) in
            self.newsResponse = articles
            self.tableView.reloadData()
            self.title = self.category
        }
        print(category)
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
        
        self.performSegue(withIdentifier: "CategoryArticleSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CategoryArticleSegue"{
            let controller = (segue.destination) as! FeaturedWebController
            let indexPath = tableView.indexPathForSelectedRow
            controller.articleUrl = newsResponse.articles[indexPath!.row].url
        }
    }
}
