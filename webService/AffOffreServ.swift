//
//  AffOffreServ.swift
//  webService
//
//  Created by Hatem Chaabini on 07/12/2019.
//  Copyright © 2019 Hatem Chaabini. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class AffOffreServ:BaseViewController,UITableViewDataSource,UITableViewDelegate  {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmenc: UISegmentedControl!
    var tvShows:NSArray = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tvShows.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                             
            let cell = tableView.dequeueReusableCell(withIdentifier: "tvShow")
            cell?.backgroundView = UIView()
                 let contentView = cell?.viewWithTag(0)
                 
                 let tvShowImage = contentView?.viewWithTag(1) as! UIImageView
                 
                 let tvShowName = contentView?.viewWithTag(2) as! UILabel
            let tvShowmetier = contentView?.viewWithTag(3) as! UILabel

                 let tvShow = tvShows[indexPath.row] as! Dictionary<String,Any>
         
            tvShowName.text = tvShow["name"] as? String
            tvShowmetier.text = tvShow["metier"] as? String

    //        let dictImages = tvShow["image"] as! Dictionary<String,String>
                 
              //   let imgOriginal = dictImages["original"]
                 var k : String
                         k = tvShow["image"] as! String
                                         
                        //image.af_setImage(withURL: URL(string: "http://localhost:3000/uploads/"+k)!)

                  tvShowImage.af_setImage(withURL: URL(string: "http://localhost:3000/uploads/"+k)!)
            
                return cell!    }
        

    @IBAction func Segmentcha(_ sender: Any) {
        print(segmenc.selectedSegmentIndex)
        if (segmenc.selectedSegmentIndex == 0){
            fetchTvShows()
        }
        else{
            fetchNonConf()
        }
    }
    override func viewDidLoad() {
            super.viewDidLoad()
            addSlideMenuButton()
              fetchTvShows()
            tableView.backgroundView = UIImageView(image: UIImage(named: "bac"))
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
               segmenc.setTitleTextAttributes(titleTextAttributes, for: .normal)
               segmenc.setTitleTextAttributes(titleTextAttributes, for: .selected)

            // Do any additional setup after loading the view.
        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
               
           //    performSegue(withIdentifier: "toDetails", sender: indexPath)
               
           }
           override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let indexPath =  tableView.indexPathForSelectedRow {
                       //let indexPath = sender as! IndexPath
                          
                          let indice = indexPath.row
                          
                         print("zzzzzzzzzzzzzzzzz")
                   print(self.tvShows[indice])
                   print("zzzzzzzzzzzzzzzzz")

                          let detailsView = segue.destination as! ConfiermerServiceViewController
                          
                          
                   detailsView.tvShows = self.tvShows[indice] as! Dictionary<String, Any>
                   
                   
                   
                   
                       }
            }
        func fetchTvShows(){
                  let Usercon = UserDefaults.standard
                         var k : String
                         
                                 k = Usercon.object(forKey: "id") as! String
                           
                  Alamofire.request("http://localhost:3000/affServiceOffertConfirmer/"+k).responseJSON{
                      
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
    func fetchNonConf(){
                        let Usercon = UserDefaults.standard
                               var k : String
                               
                                       k = Usercon.object(forKey: "id") as! String
                                 
                        Alamofire.request("http://localhost:3000/affServiceOffertNonConfirmer/"+k).responseJSON{
                                      
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
        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.
        }
        */

    }
