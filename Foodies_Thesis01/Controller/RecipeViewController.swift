//
//  RecipeViewController.swift
//  Foodies_Thesis01
//
//  Created by admin on 4/14/18.
//  Copyright © 2018 luqianchen. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Haneke

class RecipeViewController: UIViewController {
    
    var data : String = ""
    
    let Yummly = "https://api.yummly.com/v1/api/recipes?_app_id=b2e59dcf&_app_key=c7ed418d8def4dc092755e6df0966903&q="
    
    @IBOutlet weak var RecipeName: UILabel!
    @IBOutlet weak var RecipeImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        RecipeName.text = data
        let apiurl = Yummly + data
        getReceiptData(url: apiurl)
        // Do any additional setup after loading the view.
    }

    func getReceiptData(url: String){
        Alamofire.request(url).responseJSON { response in
            //print(response.result.value)
            if response.result.isSuccess{
                //  UIImage(data: Data)
                print("sucess")
                //self.lable.text = "\(response.result.value)"
                let recipeJSON = JSON(response.result.value!)
                print(recipeJSON["matches"][8]["recipeName"].stringValue)
                self.RecipeName.text = "\(recipeJSON["matches"][0]["recipeName"].stringValue)"
                //print(response.result)
                let imageURLString = recipeJSON["matches"][0]["smallImageUrls"][0].stringValue
                let imageURL = URL(string:imageURLString)!
                self.RecipeImage.hnk_setImage(from: imageURL)
            }
            else {
                print("error")
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
