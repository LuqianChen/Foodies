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

    override func viewDidLoad() {
        super.viewDidLoad()

       fetchUser()
    }
    
    func fetchUser(){
        Database.database().reference().child("users").observe(.childAdded, with:{(snapshot)in
            
            print(snapshot)
            
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
