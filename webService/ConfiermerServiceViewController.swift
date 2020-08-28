//
//  ConfiermerServiceViewController.swift
//  webService
//
//  Created by Hatem Chaabini on 07/12/2019.
//  Copyright © 2019 Hatem Chaabini. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
class ConfiermerServiceViewController: BaseViewController  {

    @IBOutlet weak var Comme: UITextView!
    @IBOutlet weak var datedem: UILabel!
    @IBOutlet weak var s: UILabel!
    @IBOutlet weak var adresse: UILabel!
    @IBOutlet weak var tel: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var nom: UILabel!
    @IBOutlet weak var image: UIImageView!
    var Commes:String?
    var ids:String?
    var nomm:String?
    var token : String?
    var info : Dictionary<String,Any> = [:]

    var stringValue : String = ""
       var tvShows:Dictionary<String,Any> = [:]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSlideMenuButton()
               print("aaaaaaaaaaakkkkkkkkkkkkkkkkkkk")
        print(self.tvShows)

        print("aaaaaaaaaaakkkkkkkkkkkkkkkkkkk")

                   self.s.text = self.tvShows["metier"] as? String
                   self.nom.text = self.tvShows["name"] as? String
                   self.email.text = self.tvShows["email"] as? String
                   self.tel.text = self.tvShows["numtel"] as? String
                   self.adresse.text = self.tvShows["adresse"] as? String
                   self.datedem.text = self.tvShows["dateD"] as? String
                   var k : String
                                k = self.tvShows["image"] as! String
                                                self.image.af_setImage(withURL: URL(string: "http://localhost:3000/uploads/"+k)!)

        let paramst = ["n":self.email.text!] as [String : Any]
        Alamofire.request("http://localhost:3000/gettokenfromemailios/", method: .post, parameters: paramst).responseJSON  { response in
                   
                      if let json = response.result.value {
                                  print("toooooooojjjeeennnn")
                          print(json)
                          self.info = json as! Dictionary<String,Any>
                          print("hdhdhbcbcbcbcbcbcbcbc")
                        self.token = self.info["token"] as! String
                        print("hdhdhbcbcbcbcbcbcbcbc")

                          print("toooooooojjjeeennnn")
                        }

        }
        
                  
        // Do any additional setup after loading the view.
    }
    @IBAction func conf(_ sender: Any) {
//
        self.ids = "\(self.tvShows["idS"] as! Int)"
        self.Commes = self.Comme.text!
print(self.Commes!)

        let params = ["id":self.ids!,"com":self.Commes!] as [String : Any]
                                    Alamofire.request("http://localhost:3000/Confirmer/", method: .post, parameters: params).responseJSON  { response in
                           
                                    if let json = response.result.value {
                    let paramsn = ["title":"Service","body":"Votre Demande a ete accepter","totoken":self.token!] as [String : Any]
                                     Alamofire.request("http://localhost:3000/sendnotifios/", method: .post, parameters: paramsn).responseJSON  { response in
                                         if let json = response.result.value {
                                             self.showToast(message: json as! String)
                                            
                                        }}}}
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func refuse(_ sender: Any) {

                self.ids = "\(self.tvShows["idS"] as! Int)"
        self.Commes = self.Comme.text!

              print("gqgqgqgqgqgqgqgqgqgqgqg")

        print(self.ids!)
        print(self.Commes!)
        print("gqgqgqgqgqgqgqgqgqgqgqg")

        let params = ["id":self.ids!,"com":self.Commes!] as [String : Any]
                                        Alamofire.request("http://localhost:3000/Refuser/", method: .post, parameters: params).responseJSON  { response in
                                            print(response.request) // original url request
                                            print(response.response) // http url reponse
                                            if let json = response.result.value {
                                                let paramsn = ["title":"Service","body":"Votre Demande a ete refuser","totoken":self.token!] as [String : Any]
                                                                 Alamofire.request("http://localhost:3000/sendnotifios/", method: .post, parameters: paramsn).responseJSON  { response in
                                                                     if let json = response.result.value {
                                                                         self.showToast(message: json as! String)
                                                                        
                                                                    }}
                                                self.showToast(message: json as! String)
                                            }
                                            }
        
//                Alamofire.request("http://localhost:3000/Refuser/"+self.ids!+"/"+self.Comme.text!).responseJSON{
//
//                                    response in
//
//
//
//                                  print(response.result.value as Any)
//
//
//
//                                }
//                print(self.Comme.text!)
        dismiss(animated: true, completion: nil)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
