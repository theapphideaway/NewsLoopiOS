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
    
    let featuredParameters = ["country": "us", "apiKey": "\(AppConstants.apiKey)"]
    
    func getTestAPI(completed:@escaping (_ newsResponse: NewsResponse, _ photos: Photos )->Void){
        
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
                   
                    
                    for i in 0..<myResponse.articles.count{
                        
                        let imageUrl = myResponse.articles[i].urlToImage!

                        let escapedUrl = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        
                        guard let photoUrl = URL(string: escapedUrl!) else{
                            continue
                        }

                        print(photoUrl)
                        let data = try? Data(contentsOf: photoUrl)

                        if let imageData = data {
                            guard let image = UIImage(data: imageData) else{
                                break
                            }

                            self.photos.thumbnails.append(image)
                            print(self.photos.thumbnails.count)
                            print(myResponse.articles.count)
                        }
                    }

                    print(self.photos)
                    
                    completed(myResponse, self.photos)
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
