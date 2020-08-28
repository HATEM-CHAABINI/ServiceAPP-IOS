//
//  DemoCell.swift
//  FoldingCell
//
//  Created by Alex K. on 25/12/15.
//  Copyright © 2015 Alex K. All rights reserved.
//

import FoldingCell
import UIKit
import AlamofireImage
import Alamofire
class DemoCell: FoldingCell{

    @IBOutlet weak var note1: UIImageView!
    @IBOutlet weak var note2: UIImageView!
    @IBOutlet var closeNumberLabel: UILabel!
    @IBOutlet var openNumberLabel: UILabel!
    var ido : String = ""
    @IBOutlet weak var imageperson: UIImageView!
    @IBOutlet weak var metierclose: UILabel!
    @IBOutlet weak var nomclose: UILabel!
    @IBOutlet weak var prix: UILabel!
    @IBOutlet weak var Nom: UILabel!
    
    @IBOutlet weak var not: UIImageView!
    
    
    var number: Int = 0 {
        didSet {
            closeNumberLabel.text = String(number)
            openNumberLabel.text = String(number)
        }
    }
    var nom : String = ""{
        didSet{
            Nom.text = nom
        }
    }
    var nomcl : String = ""{
        didSet{
            nomclose.text = nomcl
        }
    }
    var metier : String = ""{
        didSet{
            metierclose.text = metier
        }
    }
    var prixx: Float = 0{
        didSet{
            prix.text = String(prixx)+" DT"
        }
    }
 
    

    var imagepr : String = ""{
        didSet{
            imageperson.af_setImage(withURL: URL(string: "http://localhost:3000/uploads/"+imagepr)!)}}
    
    var note : Int = 0{
        didSet{
            print("notttttttttttteeeeeee")
            print(note)
            print("notttttttttttteeeeeee")
            if(note == 0){
                note1.image = UIImage(named: "0e")}
            if(note == 1){
            note1.image = UIImage(named: "1e")}
            if(note == 2){
            note1.image = UIImage(named: "2e")}
            if(note == 3){
            note1.image = UIImage(named: "3e")}
            if(note == 4){
            note1.image = UIImage(named: "4e")}
            if(note == 5){
            note1.image = UIImage(named: "5e")}
        }
    }
    
    var note22 : Int = 0{
        didSet{
            print("notttttttttttteeeeeee")
            print(note22)
            print("notttttttttttteeeeeee")
            if(note22 == 0){
                note2.image = UIImage(named: "0e")}
            if(note22 == 1){
            note2.image = UIImage(named: "1e")}
            if(note22 == 2){
            note2.image = UIImage(named: "2e")}
            if(note22 == 3){
            note2.image = UIImage(named: "3e")}
            if(note22 == 4){
            note2.image = UIImage(named: "4e")}
            if(note22 == 5){
            note2.image = UIImage(named: "5e")}
        }
    }
    var note33 : Int = 0{
          didSet{
              print("notttttttttttteeeeeee")
              print(note33)
              print("notttttttttttteeeeeee")
              if(note33 == 0){
                  not.image = UIImage(named: "0e")}
              if(note33 == 1){
              not.image = UIImage(named: "1e")}
              if(note33 == 2){
              not.image = UIImage(named: "2e")}
              if(note33 == 3){
              not.image = UIImage(named: "3e")}
              if(note33 == 4){
              not.image = UIImage(named: "4e")}
              if(note33 == 5){
              not.image = UIImage(named: "5e")}
          }
      }
    //tvShowImage2.image = UIImage(named: "delete")

    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }

    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
}


// MARK: - Actions ⚡️

extension DemoCell {

    @IBAction func buttonHandler(_: AnyObject) {
     
        
        let Usercon = UserDefaults.standard
                      var k : String
                      
                              k = Usercon.object(forKey: "id") as! String
                        
    
        
        
        ChoixServiceViewController.idO = ido
        print(self.ido)
            print(k)
            print("tap")
    }
    
}
