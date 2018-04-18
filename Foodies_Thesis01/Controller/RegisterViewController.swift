//
//  RegisterViewController.swift
//  Foodies_Thesis01
//
//  Created by admin on 4/12/18.
//  Copyright © 2018 luqianchen. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
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
            
            //UPLOAD IMAGE
            let storageRef = Storage.storage().reference().child("myImage.png")
            
            if let uploadData = UIImagePNGRepresentation(self.profileImage.image!) {
                
                storageRef.putData(uploadData, metadata: nil, completion:{(metadata,error) in
                   
                    if error != nil{
                        print(error)
                        return
                    }
                    
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString{
                        
                        let values = ["name" : name, "email" : email, "profileImageUrl": profileImageUrl]
                        self.registerUserIntoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
                    }
                    
                })
                
            }
            
        }
        
    }
    
    private func registerUserIntoDatabaseWithUID(uid:String, values: [String: AnyObject]){
        
        let ref = Database.database().reference(fromURL: "https://foodies01-5a329.firebaseio.com/")
        let usersReference = ref.child("users").child(uid)
//        let values = ["name" : name, "email" : email, "profileImageUrl": metadata.downloadUrl()]
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            if err != nil {
                print(err)
                return
            }
            
            print("Save user Success")
            self.performSegue(withIdentifier: "goToAdd", sender: self)
            
        })
        
    }
    
    
    @IBAction func uploadImage(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        imagePickerController.allowsEditing = false
        
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            print(info)
            profileImage.image = image
        } else {
            
            print("There was a problem getting image")
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    

}
