//
//  ViewController.swift
//  webService
//
//  Created by Hatem Chaabini on 10/11/2019.
//  Copyright © 2019 Hatem Chaabini. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Firebase

class ViewController: UIViewController {
    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    var info : Dictionary<String,Any> = [:]
    var b = false

    override func viewDidLoad() {
    
        super.viewDidLoad()

        name.attributedPlaceholder = NSAttributedString(string:"Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        password.attributedPlaceholder = NSAttributedString(string:"Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
    }
    @IBAction func ed(_ sender: Any) {
     //   print(self.info["name"] as! String)
       // print(self.info["email"] as! String)

    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    func send (){
        performSegue(withIdentifier: "idh", sender: self)
    }
    
    func showToast(message : String) {

          let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
          toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
          toastLabel.textColor = UIColor.white
          toastLabel.textAlignment = .center;
          toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
          toastLabel.text = message
          toastLabel.alpha = 1.0
          toastLabel.layer.cornerRadius = 10;
          toastLabel.clipsToBounds  =  true
          self.view.addSubview(toastLabel)
          UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
              toastLabel.alpha = 0.0
          }, completion: {(isCompleted) in
              toastLabel.removeFromSuperview()
          })
      }
    @IBAction func send(_ sender: Any) {
        
        
        // header to be sent in the post request if required
       
        // parameters that are needed to be posted in the backend
        var nom:String
        var mdp:String
        nom = name.text!
        mdp = password.text!
        let params = ["email":nom,"password":mdp] as [String : Any]
        Alamofire.request("http://localhost:3000/login/", method: .post, parameters: params).responseJSON  { response in
            print(response.request) // original url request
            print(response.response) // http url reponse
            if let json = response.result.value {
                if (!("JSON: \(json)" == "JSON: User not exists!!!" || "JSON: \(json)" == "JSON: Wrong Password")){
                    print("JSON: \(json)") // serialized json response after post
               self.info = json as! Dictionary<String,Any>
                    Auth.auth().signIn(withEmail: nom, password: mdp, completion: { (user, error) in
                           
                           if error != nil {
                               print(error ?? "")
                               return
                           }
                           print("Firebase Loginnn ..................")
                           //success fully logged in our user
                           
                         
                       })
                    self.send()
                    let Usercon = UserDefaults.standard
                    Usercon.setValue("\(self.info["id"] as! Int)", forKey: "id")
                    Usercon.setValue(self.info["name"] as! String, forKey: "Nom")
                    Usercon.setValue(self.info["numtel"] as! String, forKey: "numtel")
                    Usercon.setValue(self.info["prix"] as! NSNumber, forKey: "prix")
                    Usercon.setValue(self.info["metier"] as! String, forKey: "metier")
                    Usercon.setValue(self.info["image"] as! String, forKey: "image")
                    Usercon.setValue(self.info["username"] as! String, forKey: "username")
                    Usercon.setValue(self.info["adresse"] as! String, forKey: "adresse")
                    Usercon.setValue(self.info["ville"] as! String, forKey: "ville")
                    Usercon.setValue(self.info["firebaseid"] as! String, forKey: "firebaseid")
                                     Usercon.setValue(self.info["codepostale"] as! String, forKey: "codepostale")
                    Usercon.setValue("vide", forKey: "laville")
                    Usercon.setValue("vide", forKey: "lemetier")
                    Usercon.setValue(self.info["email"] as! String, forKey: "email")
                    
print("toooooookkkkkkkkeenennn")
                    print((Usercon.object(forKey: "usertoken") as? String)!)
                    print("toooooookkkkkkkkeenennn")
                    let params = ["idD":(Usercon.object(forKey: "id") as? String)!,"token":(Usercon.object(forKey: "usertoken") as? String)!] as [String : Any]
                                              Alamofire.request("http://localhost:3000/updatetoken/", method: .post, parameters: params).responseJSON  { response in
                                                 
                                                  if let json = response.result.value {
                                                      
                                                      self.showToast(message: json as! String)

                                                  }
                                                  }
                    
                    
                }else{
                    self.showToast(message: json as! String)
                }
                }
        //print("gggggggggggggggggg")
            }
        
            
       //

    }}

    /*
     
     
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tvShow")
        
        let contentView = cell?.viewWithTag(0)
        
        let tvShowImage = contentView?.viewWithTag(1) as! UIImageView
        
        let tvShowName = contentView?.viewWithTag(2) as! UILabel
        
        let tvShow = tvShows[indexPath.row] as! Dictionary<String,Any>
        
        tvShowName.text = tvShow["name"] as! String
        
        let dictImages = tvShow["image"] as! Dictionary<String,String>
        
        let imgOriginal = dictImages["original"]
        
        tvShowImage.af_setImage(withURL: URL(string: imgOriginal!)!)
        
        return cell!
    }
    
    func fetchTvShows(){
        
        Alamofire.request("http://api.tvmaze.com/shows").responseJSON{
            
            response in
            
            
            
            print(response.result.value)
            
            self.tvShows = response.result.value as! NSArray
            
            self.tableView.reloadData()
            
        }
        
    }*/




