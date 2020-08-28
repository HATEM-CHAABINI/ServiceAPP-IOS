//
//  affServiceDemandeVR.swift
//  webService
//
//  Created by Hatem Chaabini on 13/01/2020.
//  Copyright © 2020 Hatem Chaabini. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class affServiceDemandeVR:BaseViewController,UITableViewDataSource,UITableViewDelegate  {
    var tvShows:NSArray = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tvShow")
                   cell?.backgroundView = UIView()
                        let contentView = cell?.viewWithTag(0)
                        
                        let tvShowImage = contentView?.viewWithTag(1) as! UIImageView
        let tvShowImage2 = contentView?.viewWithTag(4) as! UIImageView

                        let tvShowName = contentView?.viewWithTag(2) as! UILabel
                   let tvShowmetier = contentView?.viewWithTag(3) as! UILabel
        let tvShowmetierDate = contentView?.viewWithTag(5) as! UILabel
        let tvShowmetierComme = contentView?.viewWithTag(6) as! UILabel

                        let tvShow = tvShows[indexPath.row] as! Dictionary<String,Any>
                
                   tvShowName.text = tvShow["name"] as? String
        
        let dateFormatter = DateFormatter()
              dateFormatter.locale = Locale(identifier: "en_US_POSIX")
              dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
              let string = tvShow["dateD"] as? String
              let date = dateFormatter.date(from: string!)!
              let calanderDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
        //= ("\(calanderDate.day!)"+"/"+"\(calanderDate.month!)"+"/"+"\(calanderDate.year!)")
        
                   tvShowmetier.text = tvShow["metier"] as? String
        tvShowmetierDate.text = ("\(calanderDate.day!)"+"/"+"\(calanderDate.month!)"+"/"+"\(calanderDate.year!)")
        tvShowmetierComme.text = tvShow["commentaire"] as? String
        if(tvShow["statut"] as? String == "Refuser"){
            tvShowImage2.image = UIImage(named: "delete")
        }
        else{
            tvShowImage2.image = UIImage(named: "valide")

        }

           //        let dictImages = tvShow["image"] as! Dictionary<String,String>
                        
                     //   let imgOriginal = dictImages["original"]
                        var k : String
                                k = tvShow["image"] as! String
                                                
                               //image.af_setImage(withURL: URL(string: "http://localhost:3000/uploads/"+k)!)

                         tvShowImage.af_setImage(withURL: URL(string: "http://localhost:3000/uploads/"+k)!)
                   
                       return cell!
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
               super.viewDidLoad()
               addSlideMenuButton()
                 fetchTvShows()
               tableView.backgroundView = UIImageView(image: UIImage(named: "bac"))
               let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                 
               // Do any additional setup after loading the view.
           }

           override func didReceiveMemoryWarning() {
               super.didReceiveMemoryWarning()
               // Dispose of any resources that can be recreated.
           }
    
    func fetchTvShows(){
                     let Usercon = UserDefaults.standard
                            var k : String
                            
                                    k = Usercon.object(forKey: "id") as! String
                              
                     Alamofire.request("http://localhost:3000/affServiceDemandeValideretrefuser/"+k).responseJSON{
                         
                         response in
                         
                         if let json = response.result.value {
                         
                                        if (("JSON: \(json)" == "JSON: No" )){
                                            print("JSON: \(json)") // serialized json response after post
                                    
                         
                           self.tvShows = []

                       }else{
                           self.tvShows = response.result.value as! NSArray}
                         self.tableView.reloadData()
                         
                     }
                     
               }}
}
