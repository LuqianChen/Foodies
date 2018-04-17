//
//  RegisterViewController.swift
//  Foodies_Thesis01
//
//  Created by admin on 4/12/18.
//  Copyright © 2018 luqianchen. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func registerPressed(_ sender: Any) {
        
        guard let email = emailTextfield.text, let password = passwordTextfield.text, let name = nameTextfield.text else {
            print("Form is not valid")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            guard let uid = user?.uid else{
                return
            }
            
            let ref = Database.database().reference(fromURL: "https://foodies01-5a329.firebaseio.com/")
            let usersReference = ref.child("users").child(uid)
            let values = ["name" : name, "email" : email]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err)
                    return
                }
                
                print("Save user Success")
                self.performSegue(withIdentifier: "goToAdd", sender: self)
                
            })
            
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
