//
//  PopupVideo.swift
//  webService
//
//  Created by Hatem Chaabini on 11/01/2020.
//  Copyright © 2020 Hatem Chaabini. All rights reserved.
//

import UIKit
import Cosmos
import TinyConstraints
import Alamofire
class PopupVideo: UIViewController {
    
    @IBOutlet weak var popupview: UIView!
    var genre:String = ""

    
    @IBOutlet weak var lien: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        popupview.layer.cornerRadius = 10
        popupview.clipsToBounds = true
    }
    
    @IBAction func annuler(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    @IBAction func valider(_ sender: Any) {
        let Usercon = UserDefaults.standard
        var k : String
        
                k = Usercon.object(forKey: "id") as! String
      print("hihihijbbfcbcbcbcdbcbbbcbcbcbcbcbc")
        print(self.genre)
        print(k)
        print(lien.text!)
        let end = lien.text!.index(lien.text!.endIndex, offsetBy: -11)
let mySubstring = lien.text![end...]
        print("lieeeeeeennnnnnnnnnn")
        print(mySubstring)
        
        let pathee = "<iframe width=\"100%\" height=\"100%\" src=\"https://www.youtube.com/embed/"+mySubstring+"\" frameborder=\"0\" allowfullscreen></iframe>"
        print("hihihijbbfcbcbcbcdbcbbbcbcbcbcbcbc")
        let params = [
                      "idD":k,"path":pathee,"genre":self.genre] as [String : Any]
                Alamofire.request("http://localhost:3000/addvideo/", method: .post, parameters: params).responseJSON  { response in
                  
                    if let json = response.result.value {
                        
                        self.showToast(message: json as! String)

                    }
                    }
              dismiss(animated: true, completion: nil)

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
}

