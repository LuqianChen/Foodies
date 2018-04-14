//
//  AddItemViewController.swift
//  Foodies_Thesis01
//
//  Created by admin on 4/12/18.
//  Copyright © 2018 luqianchen. All rights reserved.
//

import UIKit
import Firebase

class AddItemViewController: UIViewController {

    
    @IBOutlet weak var AddTextfield: UITextField!
    @IBOutlet weak var ItemTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
//        ItemTableView.register(UINib(nibName: "NewTableViewCell", bundle:nil), forCellReuseIdentifier: "NewCell")
        
        // Do any additional setup after loading the view.
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "NewCell", for: indexPath) as! NewCell
//
//        let messageArray = ["First","Second","Third"]
//        cell.UserItem.text = messageArray[indexPath.row]
//
//        return cell
//
//    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func LogoutPressed(_ sender: Any) {
        
        do{
        
         try Auth.auth().signOut()
            
        }
        catch{
            print("error")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
