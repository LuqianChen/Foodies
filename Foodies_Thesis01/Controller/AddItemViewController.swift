//
//  AddItemViewController.swift
//  Foodies_Thesis01
//
//  Created by admin on 4/12/18.
//  Copyright © 2018 luqianchen. All rights reserved.
//

import UIKit
import Firebase

class AddItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    var messageArray : [Message] = [Message]()

    @IBOutlet weak var cleanButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var AddTextfield: UITextField!
    @IBOutlet weak var ItemTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ItemTableView.delegate = self
        ItemTableView.dataSource = self
        
        AddTextfield.delegate = self
        
        ItemTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier:"customMessageCell")
        
        retrieveMessage()
        
//        ItemTableView.register(UINib(nibName: "NewTableViewCell", bundle:nil), forCellReuseIdentifier: "NewCell")
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = messageArray[indexPath.row].sender
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        heightConstraint.constant = 500
//        view.layoutIfNeeded()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendPressed(_ sender: Any) {
        
        AddTextfield.endEditing(true)
        
        AddTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        let messageDB = Database.database().reference().child("Message")
        let messageDictionary = ["Sender": Auth.auth().currentUser?.email, "MessageBody": AddTextfield.text!]
        
        messageDB.childByAutoId().setValue(messageDictionary){
            (error, reference) in
            if error != nil {
                print(error!)
            }else{
                print("Message saved successfully")
                
                self.AddTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                self.AddTextfield.text = ""
            }
        }
        
    }
    
    
    func retrieveMessage(){
        
        let messageDB = Database.database().reference().child("Message")
        
        
        
        messageDB.observe(.childAdded) { (snapshot) in
            
            
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            
            print(text, sender)
            
            let message = Message()
            message.messageBody = text
            message.sender = sender
            
            self.messageArray.append(message)
            
            self.ItemTableView.reloadData()
            
        }
        
    }
    
    
    
    
    @IBAction func cleanPressed(_ sender: Any) {
        
        let myDatabase = Database.database().reference()
        
        myDatabase.setValue("")
        self.ItemTableView.reloadData()
        
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
