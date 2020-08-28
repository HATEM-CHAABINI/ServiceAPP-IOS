//
//  trier.swift
//  webService
//
//  Created by Hatem Chaabini on 04/03/2020.
//  Copyright © 2020 Hatem Chaabini. All rights reserved.
//


import UIKit
import Alamofire
import AlamofireImage
class trier:UIViewController,UIPickerViewDelegate,UIPickerViewDataSource  {
       var idD:String?
       static var idO:String = ""
        let Usercon = UserDefaults.standard
                     
              var laville:String = ""
    var LesMetiers:NSArray = []
    var lemetier:String = ""
    @IBOutlet weak var pickerview: UIPickerView!
    @IBOutlet weak var villepicker: UIPickerView!
    
    
      func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
            
        }
      
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
             var countrows : Int = LesMetiers.count
                   if pickerView == villepicker {
                       countrows = self.viles.count
                   }

                   return countrows
               
               
               }
        

   
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
                  if pickerView == pickerview {
                             let tvShow = LesMetiers[row] as! Dictionary<String,Any>
                                   return tvShow["metier"] as? String
                  } else if pickerView == villepicker {

                            return viles[row]
                        }

                        return ""
          
                      }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
               if pickerView == villepicker {
                   self.laville = self.viles[row]
               } else if pickerView == pickerview {

                let tvShow = LesMetiers[row] as! Dictionary<String,Any>
                self.lemetier = (tvShow["metier"] as? String)!
                //self.LesMetiers[row] as! String
               }
           }
        let viles = ["Gouvernorat","Ariana","Béja","Ben Arous","Bizerte","Gabès","Gafsa","Jendouba","Kairouan","Kasserine","Kébili","Le Kef","Mahdia","La Manouba","Médenine","Monastir","Nabeul","Sfax","Sidi Bouzid","Siliana","Sousse","Tataouine","Tozeur","Tunis","Zaghouan"]
         
                         
        @IBOutlet weak var popupdate: UIView!
        override func viewDidLoad() {
            super.viewDidLoad()
            popupdate.layer.cornerRadius = 10
                  popupdate.clipsToBounds = true
            self.idD = Usercon.object(forKey: "id") as? String
            print("idddooooo")
            print(ChoixServiceViewController.self.idO)
            print("idddooooo")
            fetchMetier();

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
            print("yayayyayayayayay")
            print(self.laville)
            print(self.lemetier)
            let Usercon = UserDefaults.standard
            Usercon.setValue(self.laville , forKey: "laville")
            Usercon.setValue(self.lemetier, forKey: "lemetier")

                           var k : String
                           
                                   k = Usercon.object(forKey: "email") as! String
                             
                    Alamofire.request("http://localhost:3000/personnoc/"+k).responseJSON{
                        
                        response in
                        
                        
                        
                      print(response.result.value as Any)
                        
//                        self.tvShows = response.result.value as! NSArray
//                        
//                        self.tableview.reloadData()
                        
                    }
            
//
//            print(datePicker.date)
//            var dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:SS"
//
//            var strDate = dateFormatter.string(from: datePicker.date)
//            var dateChosen = strDate
//            print(strDate)
//            print(self.idD!)
//            print(ChoixServiceViewController.idO)
//
//         let params = [
//            "idD":self.idD!,"idO":ChoixServiceViewController.idO,"date":strDate] as [String : Any]
//          Alamofire.request("http://localhost:3000/addServ", method: .post, parameters: params).responseJSON  { response in
//              print(response.request) // original url request
//              print(response.response) // http url reponse
//              if let json = response.result.value {
//
//                  self.showToast(message: json as! String)
//
//              }
//              }
        }
        func fetchMetier(){
              
              Alamofire.request("http://localhost:3000/metier/", method: .get).responseJSON{
                  
                  response in
                  
                  
                  
                print(response.result.value)
                  
                  self.LesMetiers = response.result.value as! NSArray
                  
                self.pickerview.reloadAllComponents()
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
