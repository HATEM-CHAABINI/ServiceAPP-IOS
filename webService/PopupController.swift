//
//  PopupController.swift
//  webService
//
//  Created by Hatem Chaabini on 26/11/2019.
//  Copyright © 2019 Hatem Chaabini. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PopupController: UIViewController {

    @IBOutlet weak var popupview: UIView!
    var nom:String = ""
    var emaill:String = ""
    var mdp:String = ""
    var mdpp2:String = ""
    var adress:String = ""
    var numtell:String = ""
    var codep:String = ""
          var userna:String = ""
    var ville:String = ""
    var metier:String = ""
    var firebaseid:String = ""
    @IBOutlet weak var prix: UITextField!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupview.layer.cornerRadius = 10
        popupview.clipsToBounds = true
    }
    
    @IBAction func dis(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    @IBAction func Valider(_ sender: Any) {
        let Usercon = UserDefaults.standard

                               print((Usercon.object(forKey: "usertoken") as? String)!)

                              
              let params = ["token":(Usercon.object(forKey: "usertoken") as? String)!,
"email":emaill,"firebaseid":firebaseid,"name":nom,"password":mdp,"username":userna,"numtel":numtell,"adresse":adress,"metier":metier,"ville":ville,"codepostale":codep,"prix":prix.text!] as [String : Any]
          Alamofire.request("http://localhost:3000/register/", method: .post, parameters: params).responseJSON  { response in
              print(response.request) // original url request
              print(response.response) // http url reponse
              if let json = response.result.value {
                  
                  self.showToast(message: json as! String)

              }
              }
        dismiss(animated: true, completion: nil)

    }
    
    
}
