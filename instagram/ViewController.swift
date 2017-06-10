//
//  ViewController.swift
//  instagram
//
//  Created by admin on 08/06/17.
//  Copyright © 2017 bang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
    {
   
    var username = [String]()
    var urlarray = [String]()
    var imagearray = [UIImage]()
    var spinner = UIImageView()
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        Alamofire.request("http://api.petoye.com/feeds/1/followedfeeds").responseJSON
        {
            (response) in
            print(response.result.value)
            self.stopSpinning()
            let json = JSON(response.result.value)
            for item in json["feeds"].arrayValue
            {
            let name = item["user"]["username"].stringValue
            print(name)
            self.username.append(name)
                
            let url = item["imageurl"].stringValue
            print(url)
            self.urlarray.append(url)
            
            self.table.reloadData()
                
                if url.isEmpty == false
                {
                    let image = URL(string: url)
                    let task = URLSession.shared.dataTask(with: image!, completionHandler: { (data, response, error) in
                        
              
                        if error != nil
                        {
                            //There is an error.
                            self.imagearray.append(#imageLiteral(resourceName: "insta1"))
                        }
                        else
                        {
                            //There is no error.
                            let downloadedImage = UIImage(data: data!)
                            self.imagearray.append(downloadedImage!)
                        }
                            DispatchQueue.main.async
                        {
                            self.table.reloadData()
                        }
                    
                    })
                    task.resume()
                    
                }
                else
                {
                
                    self.imagearray.append(#imageLiteral(resourceName: "insta5"))
                    DispatchQueue.main.async
                        {
                            self.table.reloadData()
                    }
                    
                }
                
            }
        }
        
        print(username.count)
        print(imagearray.count)
        spinner.image = #imageLiteral(resourceName: "spinner-of-dots")
        spinner.frame = CGRect(x: 150, y: 300, width: 90, height: 90)
        self.view.addSubview(spinner)
        rotateImage()
    }
    
    func rotateImage()
    
    {
        
        
//        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: { 
//            
//            self.spinner.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
//        
//        }) { (finished) in
//            
//            self.rotateImage()
//        }
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0.0
        rotation.toValue = M_PI * 2
        rotation.duration = 1
        rotation.repeatCount = Float.infinity
        self.spinner.layer.add(rotation, forKey: nil)
    }

    func stopSpinning()
    {
        self.spinner.layer.removeAllAnimations()
        self.spinner.isHidden = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return imagearray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)as! instaTableViewCell
        
        cell.picture.image = #imageLiteral(resourceName: "insta1")
        cell.username.text = username[indexPath.row]
        cell.location.text = "India"
        cell.photo.image = imagearray[indexPath.row]
        
        return cell
    }










}

