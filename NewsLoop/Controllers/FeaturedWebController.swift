//
//  FeaturedWebController.swift
//  NewsLoop
//
//  Created by ian schoenrock on 3/23/19.
//  Copyright © 2019 ian schoenrock. All rights reserved.
//

import UIKit
import WebKit

class FeaturedWebController: UIViewController, WKUIDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    var articleUrl = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.uiDelegate = self
        
        var displayedUrl = URL(string: articleUrl)
        
        let myRequest = URLRequest(url: displayedUrl!)
        webView.load(myRequest)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
