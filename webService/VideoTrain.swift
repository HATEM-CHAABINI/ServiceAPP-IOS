//
//  VideoTrain.swift
//  webService
//
//  Created by Hatem Chaabini on 11/01/2020.
//  Copyright © 2020 Hatem Chaabini. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import Floaty
class VideoTrain: BaseViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDataSource,UITableViewDelegate {
     var LesMetiers:NSArray = []
   var genre:String = ""

   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1

    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return LesMetiers.count

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
             
                         let tvShow = LesMetiers[row] as! Dictionary<String,Any>
                               return tvShow["metier"] as? String
                  }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

            let tvShow = LesMetiers[row] as! Dictionary<String,Any>
        fetchTvShows(genre: (tvShow["metier"] as? String)!)
        self.genre = (tvShow["metier"] as? String)!
           }
       
    
    @IBOutlet weak var pickergenre: UIPickerView!
    @IBOutlet weak var tableview: UITableView!
    var tvShows:NSArray = []
     let floaty = Floaty()
    @IBOutlet weak var btnvideo: UIButton!
    
    @IBAction func addvideo(_ sender: Any) {
        if(genre != ""){
            
            self.performSegue(withIdentifier: "popupvideos", sender: Any?.self)}

        }
    
    
    
    override func viewDidLoad() {
             super.viewDidLoad()
             addSlideMenuButton()
        
        btnvideo.setImage(UIImage(named: "addicon"), for: .normal)
        fetchMetier()
        fetchTvShows(genre: "peintre")
             tableview.backgroundView = UIImageView(image: UIImage(named: "bac"))
    }
    override func didReceiveMemoryWarning() {
             super.didReceiveMemoryWarning()
             // Dispose of any resources that can be recreated.
         }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tvShows.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
                                 
                let cell = tableView.dequeueReusableCell(withIdentifier: "videocell")
                cell?.backgroundView = UIView()
                     let contentView = cell?.viewWithTag(0)
                     
                     let tvShowImage = contentView?.viewWithTag(1) as! UIWebView
                     

                     let tvShow = tvShows[indexPath.row] as! Dictionary<String,Any>
             
        let lien = tvShow["lien"] as? String
      
        let start = lien!.index(lien!.startIndex, offsetBy: 70)
        let end = lien!.index(lien!.endIndex, offsetBy: -43)
        let range = start..<end
        let urle = URL(string: "https://www.youtube.com/embed/\(lien![range])")
        tvShowImage.loadRequest(URLRequest(url: urle!))



        
                    return cell!    }
    
    func fetchTvShows(genre: String){
         
                var tvShows:NSArray = []


    Alamofire.request("http://localhost:3000/RechercheVideo/"+genre).responseJSON{
                  
                  response in
                  
                  if let json = response.result.value {
                                 if (("JSON: \(json)" == "JSON: Confirmer" )){
                                     print("JSON: \(json)") // serialized json response after post
                             
                  
                    self.tvShows = []
                                    self.tableview.reloadData()

                }else{
                    self.tvShows = response.result.value as! NSArray}
                  self.tableview.reloadData()
                  
              }
              
        }}
    func fetchMetier(){
             
             Alamofire.request("http://localhost:3000/metier/", method: .get).responseJSON{
                 
                 response in
                 
                 
                 
               print(response.result.value)
                 
                 self.LesMetiers = response.result.value as! NSArray
                self.pickergenre.reloadAllComponents()

                 
           }}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       let popup = segue.destination as! PopupVideo
        popup.genre = self.genre}
    
}
