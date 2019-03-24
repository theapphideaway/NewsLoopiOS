//
//  NewsService.swift
//  NewsLoop
//
//  Created by ian schoenrock on 3/22/19.
//  Copyright © 2019 ian schoenrock. All rights reserved.
//

import UIKit
import Alamofire

class NewsService{
    
    var photos = Photos()
    
     let defaultImage = "https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/160/apple/81/cloud_2601.png"
    
    
    
    func getFeaturedNews(completed:@escaping (_ newsResponse: NewsResponse, _ photos: Photos )->Void){
        
        let featuredParameters = ["country": "us", "apiKey": "\(AppConstants.apiKey)"]
        guard let testUrl = URL(string: "https://newsapi.org/v2/top-headlines") else {return}
        Alamofire.request(testUrl,
                          method: .get,
                          parameters: featuredParameters ).responseJSON {
            (response) in
            
            print(response)
            if response.result.isSuccess {

                guard let data = response.data else {return}

                do{
                    let myResponse = try JSONDecoder().decode(NewsResponse.self,from: data)

                    print(self.photos)
                    
                    completed(myResponse, self.photos)
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getCategories(category: String, completed:@escaping (_ newsResponse: NewsResponse)->Void){
        
        let categoryParameters = ["category": category, "country": "us",
                                  "apiKey": "\(AppConstants.apiKey)"]
        guard let testUrl = URL(string: "https://newsapi.org/v2/top-headlines") else {return}
        Alamofire.request(testUrl,
                          method: .get,
                          parameters: categoryParameters ).responseJSON {
                            (response) in
            print(response)
            if response.result.isSuccess {
                
                guard let data = response.data else {return}
                
                do{
                    let myResponse = try JSONDecoder().decode(NewsResponse.self,from: data)
                    completed(myResponse)
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}
