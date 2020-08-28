//
//  DetailsServ.swift
//  webService
//
//  Created by Hatem Chaabini on 03/12/2019.
//  Copyright © 2019 Hatem Chaabini. All rights reserved.
//

import UIKit
import Alamofire
import Cosmos
import TinyConstraints
import Firebase
class DetailsServ: BaseViewController ,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableview: UITableView!
    var LesComm:NSArray = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LesComm.count

    }
    @IBAction func chat(_ sender: Any) {
        print("bbbbxxxbxbbxbxbxbxbxbxbxbbxbxbxb")
        print(self.tvShows["firebaseid"])
        print("bbbbxxxbxbbxbxbxbxbxbxbxbbxbxbxb")

        
        let ref = Database.database().reference().child("Users").child(self.tvShows["firebaseid"] as! String)
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
              };
        
    
//        let user :User
//        user.id = "lpLcoxns4vXvpqeWBrCji6CELYy1"
// let MessagesControllerc = MessagesController()
//        MessagesControllerc.showChatControllerForUser(user)
        
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "commentaires")
                cell?.backgroundView = UIView()
                     let contentView = cell?.viewWithTag(0)
                     
                     let commImage = contentView?.viewWithTag(1) as! UIImageView
                     
                 let comme = contentView?.viewWithTag(2) as! UITextView
               let comName = contentView?.viewWithTag(3) as! UILabel

                     let comm = LesComm[indexPath.row] as! Dictionary<String,Any>
             
            comme.text = comm["commentaire"] as? String
comName.text = comm["name"] as? String
//                tvShowmetier.text = tvShow["metier"] as? String

        //        let dictImages = tvShow["image"] as! Dictionary<String,String>
                     
                  //   let imgOriginal = dictImages["original"]
                     var k : String
                             k = comm["image"] as! String
                                             
                            //image.af_setImage(withURL: URL(string: "http://localhost:3000/uploads/"+k)!)

                      commImage.af_setImage(withURL: URL(string: "http://localhost:3000/uploads/"+k)!)
                
                    return cell!      }
    
    lazy var cosmosView: CosmosView = {
        var view = CosmosView(frame: CGRect(x: 150, y: 680, width: 200, height: 50))
        view.settings.updateOnTouch = false
        return view
    }()
    @IBOutlet weak var s: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nom: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var tel: UILabel!
    @IBOutlet weak var adresse: UILabel!
    var nomm:String?
    var i : Int?
    var stringValue : String?
    var tvShows:Dictionary<String,Any> = [:]
    func fetchcomme(){
    //           let Usercon = UserDefaults.standard
    //                  var k : String
    //                          k = Usercon.object(forKey: "id") as! String
                        
               Alamofire.request("http://localhost:3000/getcomm/"+stringValue!).responseJSON{
                   
                   response in
                   
                   if let json = response.result.value {
                                        
                                                       if (("JSON: \(json)" == "JSON: Vide" )){
                                                           print("JSON: \(json)") // serialized json response after post                                        
                                          self.LesComm = []

                                      }else{
                                           print(response.result.value as Any)
                                                           
                                                           self.LesComm = response.result.value as! NSArray
                                                           
                                                          }
                                        self.tableview.reloadData()
                                        
                                    }
                   
//                 print(response.result.value as Any)
//
//                self.LesComm = response.result.value as! NSArray
//
//                   self.tableview.reloadData()
                   
               }
               
           }
    override func viewDidLoad() {

    
        self.stringValue = "\(tvShows["id"] as! Int)"
//        i = tvShows["id"] as! String
//print(i)
        Alamofire.request("http://localhost:3000/Retournoteoff/"+stringValue!).responseJSON{

                    response in
            self.i = response.result.value! as? Int
            print(self.i!)

                }
        let seconds = 0.03
        ///// esel amir aal  wait
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            super.viewDidLoad()
            self.addSlideMenuButton()
                 
            print("zezezezezezezeezez")
            print(self.i!)
            print("zezezezezezezeezez")
            self.s.text = self.tvShows["metier"] as? String
            self.nom.text = self.tvShows["name"] as? String
            self.email.text = self.tvShows["email"] as? String
            self.tel.text = self.tvShows["numtel"] as? String
            self.adresse.text = self.tvShows["adresse"] as? String
            var k : String
                         k = self.tvShows["image"] as! String
                                         

                  self.image.af_setImage(withURL: URL(string: "http://localhost:3000/uploads/"+k)!)
            self.cosmosView.rating = Double(self.i!)
            self.view.addSubview(self.cosmosView)        }
             fetchcomme()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
        
           // Dispose of any resources that can be recreated.
       }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let popup = segue.destination as! ChoixServiceViewController
        ChoixServiceViewController.idO = self.stringValue!
    
    }
    @IBAction func Ajoutserv(_ sender: Any) {
        self.performSegue(withIdentifier: "ChoixDate", sender: Any?.self)}

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
