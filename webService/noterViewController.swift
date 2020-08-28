//
//  noterViewController.swift
//  webService
//
//  Created by Hatem Chaabini on 07/12/2019.
//  Copyright © 2019 Hatem Chaabini. All rights reserved.
//

import UIKit
import Cosmos
import TinyConstraints
import Alamofire
class noterViewController: UIViewController {
    var tvShows:Dictionary<String,Any> = [:]

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nom: UILabel!
    @IBOutlet weak var metier: UILabel!
    @IBOutlet weak var Commentaire: UITextView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var cosmosView1: CosmosView!
    @IBOutlet weak var cosmosView2: CosmosView!
    @IBOutlet weak var cosmosView3: CosmosView!
    //    lazy var cosmosView: CosmosView = {
//           var view = CosmosView(frame: CGRect(x: 150, y: 680, width: 200, height: 50))
//        view.text = " note1"
//        view.settings.textColor = .white
//        
//     
//        return view
//        
//       }()
    
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let string = self.tvShows["dateD"] as? String
        let date = dateFormatter.date(from: string!)!
        let calanderDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
    
         self.metier.text = self.tvShows["metier"] as? String
         self.nom.text = self.tvShows["name"] as? String
         self.date.text = ("\(calanderDate.day!)"+"/"+"\(calanderDate.month!)"+"/"+"\(calanderDate.year!)")
         
         var k : String
                      k = self.tvShows["image"] as! String
                                      

               self.image.af_setImage(withURL: URL(string: "http://localhost:3000/uploads/"+k)!)
        
//    self.view.addSubview(self.cosmosView)
        self.cosmosView1.rating = 5
        self.cosmosView2.rating = 5
        self.cosmosView3.rating = 5

        // Do any additional setup after loading the view.
    }
    
    @IBAction func vali(_ sender: Any) {
        let idS = self.tvShows["idS"] as? Int
        let com = self.Commentaire.text
        let note1 = self.cosmosView1.rating
        let note2 = self.cosmosView2.rating
        let note3 = self.cosmosView3.rating
        print(idS!)
        print(com!)
        print(note1)
        print(note2)
        print(note3)

        let params = ["id":idS!,"com":com!,"note":note1,"note2":note2,"note3":note3] as [String : Any]
                                   Alamofire.request("http://localhost:3000/NoterServiceios/", method: .post, parameters: params).responseJSON  { response in
                                       print(response.request) // original url request
                                       print(response.response) // http url reponse
                                       if let json = response.result.value {

                                           self.showToast(message: json as! String)

                                       }
                                       }
        
        
    //  Alamofire.request("http://localhost:3000/NoterService/"+idS!+"/"+com!+"/"+note).responseJSON{
// Alamofire.request("http://localhost:3000/NoterService/"+"\(idS!)"+"/"+com!+"/"+"\(note)").responseJSON{
//                               response in
//
//
//
//                             print(response.result.value as Any)
//
//
//
//                           }

//        self.showToast(message: "\(self.cosmosView.rating)")
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
