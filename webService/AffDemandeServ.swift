//
//  AffDemandeServ.swift
//  webService
//
//  Created by Hatem Chaabini on 07/12/2019.
//  Copyright © 2019 Hatem Chaabini. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class AffDemandeServ: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var segmentc: UISegmentedControl!
    var tvShows:NSArray = []

    @IBOutlet weak var tableView: UITableView!
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
        print(segmentc.selectedSegmentIndex)
        if (segmentc.selectedSegmentIndex == 0){
            fetchTvShows()
        }
        else{
            fetchNonConf()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (segmentc.selectedSegmentIndex == 0){
            performSegue(withIdentifier: "detaildem", sender: indexPath)}
        else{print("oojijijijijijijbhbvhdbchdbcdb")}
           
       }
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath =  tableView.indexPathForSelectedRow {
                   //let indexPath = sender as! IndexPath
                      
                      let indice = indexPath.row
                      
                     print("zzzzzzzzzzzzzzzzz")
               print(self.tvShows[indice])
               print("zzzzzzzzzzzzzzzzz")

                      let detailsView = segue.destination as! noterViewController
                      
                      
               detailsView.tvShows = self.tvShows[indice] as! Dictionary<String, Any>
               
               
               
               
                   }
        }
    
    
    
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            addSlideMenuButton()
              fetchTvShows()
            tableView.backgroundView = UIImageView(image: UIImage(named: "bac"))
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
               segmentc.setTitleTextAttributes(titleTextAttributes, for: .normal)
               segmentc.setTitleTextAttributes(titleTextAttributes, for: .selected)
print("ccccccccccccccccccccccccccccccccccccccccccc")
        print(segmentc.selectedSegmentIndex)
            print("ccccccccccccccccccccccccccccccccccccccccccc")
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
                           
                  Alamofire.request("http://localhost:3000/affServiceDemanderConfirmer/"+k).responseJSON{
                                
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
                                 
                        Alamofire.request("http://localhost:3000/affServiceDemanderNonConfirmer/"+k).responseJSON{
                                      
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
