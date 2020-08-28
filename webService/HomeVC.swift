//
//  HomeVC.swift
//  AKSwiftSlideMenu
//
//  Created by MAC-186 on 4/8/16.
//  Copyright © 2016 Kode. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import FoldingCell
import Firebase

class HomeVC: BaseViewController ,UITableViewDataSource,UITableViewDelegate{
    var tvShows:NSArray = []
    var info:NSArray = []
    var selected: String = "Anonymous"
    let Usercon = UserDefaults.standard
    //        Usercon.setValue(self.laville , forKey: "laville")
    //        Usercon.setValue(self.lemetier, forKey: "lemetier")

    
//     var k : String
    //
    //                                   k = Usercon.object(forKey: "email") as! String
    @IBOutlet weak var tableview: UITableView!
    enum Const {
           static let closeCellHeight: CGFloat = 179
           static let openCellHeight: CGFloat = 488
           static let rowsCount = 10
       }
       
       var cellHeights: [CGFloat] = []

       // MARK: Life Cycle
       override func viewDidLoad() {
           super.viewDidLoad()
           setup()
           fetchTvShows()
        addSlideMenuButton()


       }

    @IBAction func chat(_ sender: Any) {
        
           let ref = Database.database().reference().child("Users").child("w5k74C0HRKRozGlQM1etj6bZBaG3")
                 ref.observeSingleEvent(of: .value, with: { (snapshot) in
                     guard let dictionary = snapshot.value as? [String: AnyObject] else {
                         return
                     }
                     print("diiiiiiiicccccct")
                     print(dictionary)
                     print("diiiiiiiicccccct")
                     let user = User(dictionary: dictionary)
                       let MessagesControllerc = MessagesController()
                   self.present(MessagesControllerc, animated: true, completion: nil)
                    MessagesControllerc.showChatControllerForUser(user)
               
                              
                              }, withCancel: nil)
    }
    func fetchTvShows(){
             var laville : String
             laville = Usercon.object(forKey: "laville") as! String
        var lemetier : String
        lemetier = Usercon.object(forKey: "lemetier") as! String
        print("111111111111111")
        print(laville)
        print(lemetier)
        print("111111111111111")

                  var k : String
                  
                          k = Usercon.object(forKey: "email") as! String
        if (laville != "vide"){
            print("222222222222")
            print(laville)
            print(lemetier)
            print("222222222222")

//
            let params = ["n":k,"metier":lemetier,"ville":laville] as [String : Any]
                                             Alamofire.request("http://localhost:3000/triee/", method: .post, parameters: params).responseJSON  {
            response in
                          if let json = response.result.value {
                                                  
                                                                 if (("JSON: \(json)" == "JSON: No" )){
                                                                     print("JSON: \(json)") // serialized json response after post
                                                             
                                                  
                                                    self.tvShows = []

                                                }else{
                          
                          
                        print(response.result.value as Any)
                          
                          self.tvShows = response.result.value as! NSArray
                          
                          self.tableview.reloadData()
                          self.Usercon.setValue("vide", forKey: "laville")
                                                                  self.Usercon.setValue("vide", forKey: "lemetier")}
                          }}
//
//            Alamofire.request("http://localhost:3000/trie/"+k+"/"+lemetier+"/"+laville).responseJSON{
//
//                response in
//                if let json = response.result.value {
//
//                                                       if (("JSON: \(json)" == "JSON: No" )){
//                                                           print("JSON: \(json)") // serialized json response after post
//
//
//                                          self.tvShows = []
//
//                                      }else{
//
//
//              print(response.result.value as Any)
//
//                self.tvShows = response.result.value as! NSArray
//
//                self.tableview.reloadData()
//                self.Usercon.setValue("vide", forKey: "laville")
//                                                        self.Usercon.setValue("vide", forKey: "lemetier")}
//                }}
        }else{
           Alamofire.request("http://localhost:3000/personnoc/"+k).responseJSON{
               
               response in
               
               
               
             print(response.result.value as Any)
               
               self.tvShows = response.result.value as! NSArray
               
               self.tableview.reloadData()
               
            }}
           
       }
    
    private func setup() {
        cellHeights = Array(repeating: Const.closeCellHeight, count: Const.rowsCount)
        tableview.estimatedRowHeight = Const.closeCellHeight
        tableview.rowHeight = UITableView.automaticDimension
        tableview.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        if #available(iOS 10.0, *) {
            tableview.refreshControl = UIRefreshControl()
            tableview.refreshControl?.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
        }
    }
    
    // MARK: Actions
    @objc func refreshHandler() {
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: { [weak self] in
            if #available(iOS 10.0, *) {
                self?.tableview.refreshControl?.endRefreshing()
            }
            self?.tableview.reloadData()
        })
    }
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return tvShows.count
    }
    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as DemoCell = cell else {
            return
        }

        cell.backgroundColor = .clear

        if cellHeights[indexPath.row] == Const.closeCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
        let tvShow = tvShows[indexPath.row] as! Dictionary<String,Any>

        cell.number = indexPath.row
        cell.nom = (tvShow["name"] as? String)!
        cell.imagepr = tvShow["image"] as! String
        cell.nomcl = (tvShow["name"] as? String)!
        cell.metier = (tvShow["metier"] as? String)!
        cell.prixx = (tvShow["prix"] as? Float)!
        cell.ido = "\(tvShow["id"] as! Int)"
        Alamofire.request("http://localhost:3000/Retournoteoffios/"+"\(tvShow["id"] as! Int)").responseJSON{
// houni
            
            //
                     
            //
                            
                            
                           response in
       
                                 if let json = response.result.value {
                                 
                                         print("JSON: \(json)") // serialized json response after post
                                        self.info = response.result.value as! NSArray
                                    
                                    print("lesssss notyttessss")
                                    let tvShow = self.info[0] as! Dictionary<String,Any>

                                        

                                               print("lesssss notyttessss")
                                               cell.note = (tvShow["moy"]! as? Int)!
                cell.note22 = (tvShow["moy2"]! as? Int)!
                                    cell.note33 = (tvShow["moy3"]! as? Int)!

            }
         //   self.info = response.result.value as! Dictionary<String,Any>
           
                  

                       }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! FoldingCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        return cell
    }
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell

        if cell.isAnimating() {
            return
        }

        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == Const.closeCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = Const.openCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = Const.closeCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }

        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            
            // fix https://github.com/Ramotion/folding-cell/issues/169
            if cell.frame.maxY > tableView.frame.maxY {
                tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            }
        }, completion: nil)
    }
}
