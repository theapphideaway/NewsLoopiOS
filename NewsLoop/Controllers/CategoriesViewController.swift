//
//  SecondViewController.swift
//  NewsLoop
//
//  Created by ian schoenrock on 3/22/19.
//  Copyright © 2019 ian schoenrock. All rights reserved.
//

import UIKit

class CategoriesViewController: UITableViewController {
    
    var categories = ["Business", "Entertainment", "Health", "Science", "Sports", "Technology"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "categoryCell")
        cell.textLabel?.text = categories[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CategoryDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CategoryDetailSegue"{
            let controller = (segue.destination) as! CategoryDetailViewController
            let indexPath = tableView.indexPathForSelectedRow
            controller.category = categories[(indexPath?.row)!]
        }
    }
}
