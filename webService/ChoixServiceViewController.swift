//
//  ChoixServiceViewController.swift
//  webService
//
//  Created by Hatem Chaabini on 06/12/2019.
//  Copyright © 2019 Hatem Chaabini. All rights reserved.
//

import UIKit
import Alamofire
class ChoixServiceViewController: UIViewController {
    var idD:String?
   static var idO:String = ""
    let Usercon = UserDefaults.standard
                 
                 
                     
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var popupdate: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        popupdate.layer.cornerRadius = 10
              popupdate.clipsToBounds = true
        self.idD = Usercon.object(forKey: "id") as? String
        print("idddooooo")
        print(ChoixServiceViewController.self.idO)
        print("idddooooo")

        // Do any additional setup after loading the view.
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
    
    @IBAction func Valider(_ sender: Any) {
        print("huhuhuhuhuhuhuhu")

        print(datePicker.date)
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:SS"

        var strDate = dateFormatter.string(from: datePicker.date)
        var dateChosen = strDate
        print(strDate)
        print(self.idD!)
        print(ChoixServiceViewController.idO)

     let params = [
        "idD":self.idD!,"idO":ChoixServiceViewController.idO,"date":strDate] as [String : Any]
      Alamofire.request("http://localhost:3000/addServ", method: .post, parameters: params).responseJSON  { response in
          print(response.request) // original url request
          print(response.response) // http url reponse
          if let json = response.result.value {

              self.showToast(message: json as! String)

          }
          }
    }
    @IBAction func dism(_ sender: Any) {

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
