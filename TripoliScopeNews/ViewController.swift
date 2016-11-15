//
//  ViewController.swift
//  TripoliScopeNews
//
//  Created by Ghas San on 11/15/16.
//  Copyright © 2016 Ghassan Jaam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!  //tableView UI Object
    var articles: [Article]? = []     //empty array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArticles()
    }
    
    func fetchArticles() {
        
        let urlRequest = URLRequest(url: URL(string: "http://put your link here")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            if error != nil {
                print(error)
                return
            }
            self.articles = [Article]()
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [[String: AnyObject]]
                
                for articleFromJson in json {
                    let article = Article()
                    
                    if let title = articleFromJson["namea"] as? String,
                        let date = articleFromJson["date"] as? String,
                        let time = articleFromJson["time"] as? String,
                        let url = articleFromJson["link"] as? String,
                        let imageUrl = articleFromJson["image"] as? String {
                        
                        article.title = title
                        article.date_publish = date
                        article.time_publish = time
                        article.url = url
                        article.imageUrl = imageUrl
                            
                        }
                    self.articles?.append(article)
                    
                }
                
                //reload data in tableView
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }catch let error {
                print(error)
            }
            
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! VCTableViewCell
        
        cell.NewsLbl.text = self.articles?[indexPath.item].title
        cell.publishDate.text = self.articles?[indexPath.item].date_publish
        cell.TimeLabel.text = self.articles?[indexPath.item].time_publish
        cell.imgView.downloadImage(from: (self.articles?[indexPath.item].imageUrl!)!)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0 //if the article array is not nil use articles.count if not exist use 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WEB") as! WebViewVC
        
        webVC.url = self.articles?[indexPath.item].url
        
        self.present(webVC, animated: true, completion: nil)
    }
    
}

extension UIImageView {
    func downloadImage(from url: String)  {
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}




