//
//  HomeViewController.swift
//  instaBrowser
//
//  Created by user143365 on 8/10/18.
//  Copyright © 2018 Ioanna Deni. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    var posts :[PFObject] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    func refresh(){
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.includeKey("timestamp")
        query.includeKey("caption")
        
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                self.posts = posts
            } else {
                print("Error! : ", error?.localizedDescription)
            }
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.rowHeight = 220
        tableView.dataSource = self
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (self.posts.count)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! HomeTableViewCell
        let post = posts[indexPath.row]
        let caption = post["caption"] as? String
        let photoPFFile = post["media"] as? PFFile
        
        cell.imageViewLabel.file = photoPFFile
        cell.captionLabel.text = caption
        cell.imageViewLabel.loadInBackground()
        cell.captionLabel.text = post["caption"] as? String
        return cell
        
        
    }
    
    @IBAction func onLogout(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "details" {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                let post = posts[indexPath.row]
                let detailViewController = segue.destination as! DetailsViewController
                detailViewController.posts = post

            }
        }
    }

}
