//
//  TableViewController.swift
//  Foodies_Thesis01
//
//  Created by admin on 4/17/18.
//  Copyright © 2018 luqianchen. All rights reserved.
//

import UIKit
import Firebase

class TableViewController: UITableViewController {
    
    var users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()

       fetchUser()
    }
    
    func fetchUser(){
        Database.database().reference().child("users").observe(.childAdded, with:{(snapshot)in
            
            if let dictionary = snapshot.value as? [String: AnyObject]{
                
                let user = User()

                user.setValuesForKeys(dictionary)
                
//                user.name = dictionary["name"] as! String
//                user.email = dictionary["email"] as! String
                
                self.users.append(user)
                
                DispatchQueue.global(qos: .background).async {
                    // Background Thread
                    DispatchQueue.main.async {
                        // Run UI Updates or call completion block
                        self.tableView.reloadData()
                    }
                }
               
                
                print(user.name, user.email)
                    
                }
                        
            
          
            
        }, withCancel: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "UserCell")
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        cell.imageView?.image = UIImage(named: "")
        
        if let profileImageUrl = user.profileImageUrl {
            let url = NSURL(string: profileImageUrl)
            URLSession.shared.dataTask(with: url! as URL, completionHandler:{(data, response, error) in
                if error != nil{
                    print(error)
                    return
                }
                
//                DispatchQueue.main.async {
//                    cell.imageView?.image = UIImage(data: data!)
//                }
                
                DispatchQueue.global(qos: .background).async {
                    // Background Thread
                    DispatchQueue.main.async {
                        cell.imageView?.image = UIImage(data: data!)
                    }
                }
             
                
            }).resume()
            
        }
        
           return cell
        
    }
 
}

