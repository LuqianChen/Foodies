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
                
                print(snapshot)
                
                print(dictionary)
                
                user.setValuesForKeys(dictionary)
                    
                print(user.name, user.email)
                    
                }
                        
            
          
            
        }, withCancel: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "UserCell")
        
           cell.textLabel?.text = "AAA"
        
        
           return cell
        
    }
    

  
}
