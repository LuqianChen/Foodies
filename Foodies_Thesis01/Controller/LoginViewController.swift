//
//  LoginViewController.swift
//  Foodies_Thesis01
//
//  Created by admin on 4/12/18.
//  Copyright © 2018 luqianchen. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

   
    
    @IBOutlet weak var emailTextfeild: UITextField!
    
    @IBOutlet weak var passwordTextfeild: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func LoginPressed(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextfeild.text!, password: passwordTextfeild.text!) { (user, error) in
            
            if error != nil {
                print("error")
            }else{
                print("success")
                
                self.performSegue(withIdentifier: "goToAdd", sender: self)
                
            }
            
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
