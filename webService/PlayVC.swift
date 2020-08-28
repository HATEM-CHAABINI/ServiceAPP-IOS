//
//  PlayVC.swift
//  AKSwiftSlideMenu
//
//  Created by MAC-186 on 4/8/16.
//  Copyright © 2016 Kode. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Firebase
class PlayVC: BaseViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    let viles = ["Gouvernorat","Ariana","Béja","Ben Arous","Bizerte","Gabès","Gafsa","Jendouba","Kairouan","Kasserine","Kébili","Le Kef","Mahdia","La Manouba","Médenine","Monastir","Nabeul","Sfax","Sidi Bouzid","Siliana","Sousse","Tataouine","Tozeur","Tunis","Zaghouan"]
      var laville:String = ""

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1

    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.viles.count
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viles[row]
                  }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
               self.laville = self.viles[row]
       }
    
    
    
    @IBOutlet weak var image: UIImageView!
   
    @IBOutlet weak var adresse: UITextField!
    @IBOutlet weak var codepostale: UITextField!
  
    
    @IBOutlet weak var numtel: UITextField!
    @IBOutlet weak var ancienmdp: UITextField!
    @IBOutlet weak var nvmdp1: UITextField!
    @IBOutlet weak var nvmdp2: UITextField!
    @IBOutlet weak var villepicker: UIPickerView!
    var NewImage: Int! = 0
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        addSlideMenuButton()
        
            numtel.attributedPlaceholder = NSAttributedString(string:"Numéro de telephone", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
      adresse.attributedPlaceholder = NSAttributedString(string:"Adresse", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
      codepostale.attributedPlaceholder = NSAttributedString(string:"Code Postale", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
      ancienmdp.attributedPlaceholder = NSAttributedString(string:"Votre Ancien MDP", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
      nvmdp1.attributedPlaceholder = NSAttributedString(string:"Votre Nouveau MDP", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
      nvmdp2.attributedPlaceholder = NSAttributedString(string:"Répéter Votre Nouveau MDP", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
       
      let Usercon = UserDefaults.standard
        
       
        self.numtel.text = Usercon.object(forKey: "numtel") as? String

                   //        Usercon.setValue(self.info["ville"] as! String, forKey: "ville")
        
        self.adresse.text = Usercon.object(forKey: "adresse") as? String
        self.codepostale.text = Usercon.object(forKey: "codepostale") as? String
        self.setDefaultValue(item: (Usercon.object(forKey: "ville") as? String)!, inComponent: 0)
        self.laville = (Usercon.object(forKey: "ville") as? String)!
        var k : String
         k = Usercon.object(forKey: "image") as! String
        print("iiiiimaaaaggggeeee ya kkhrraaaa: "+k)
       
        //dora@gmail.com
        
        // self.addProfilePicBtn.imageView!.af_setImage(withURL: URL(string: "http://localhost:3000/uploads/"+k)!)

//        self.addProfilePicBtn.setImage(image.af_setImage(withURL: URL(string: "http://localhost:3000/uploads/"+k)!), for: .no)

            self.image.af_setImage(withURL: URL(string: "http://localhost:3000/uploads/"+k)!)
        
          let seconds = 0.1
                 ///// esel amir aal  wait
                 
                 DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        
     //   self.addProfilePicBtn.image = im
            self.addProfilePicBtn.setImage(self.image.image, for: UIControl.State.normal)
        }
        // Do any additional setup after loading the view.
    }

    func setDefaultValue(item: String, inComponent: Int){
     if let indexPosition = viles.firstIndex(of: item){
       villepicker.selectRow(indexPosition, inComponent: inComponent, animated: true)
     }
    }
    
    @IBAction func Confirmer(_ sender: Any) {
        
        
        print("new imaageee: \(self.NewImage!)")
        
        let Usercon = UserDefaults.standard

        let id: String = (Usercon.object(forKey: "id") as? String)!

        if (ancienmdp.text! == "" && (nvmdp1.text! != "" || nvmdp2.text! != "")){
            self.showToast(message: "Veuillez introduire votre ancien mot de passe")

        }else if (ancienmdp.text! != "" && (nvmdp1.text! == "" || nvmdp2.text! == "")){
            self.showToast(message: "Veuillez introduire votre nouveau mot de passe et le confirmer")
        }
        else if (ancienmdp.text! != "" && nvmdp1.text! != "" && nvmdp2.text! != ""){
            Alamofire.request("http://localhost:3000/verifpassword/"+id+"/"+ancienmdp.text!).responseJSON{

                              response in
                       if let json = response.result.value {

                                                          self.showToast(message: json as! String)
                        if (self.nvmdp1.text == self.nvmdp2.text){
                        if(json as! String == "Ancien mot de passe correct"){
                            
                            Auth.auth().currentUser?.updatePassword(to: self.nvmdp1.text!) { (error) in
                              print("passssssssssssss")
                            }
                            let params = ["adresse":self.adresse.text!,"codepostale":self.codepostale.text!,"ville":self.laville,"id":id,"tel":self.numtel.text!,"password":self.nvmdp1.text!] as [String : Any]
                                                      Alamofire.request("http://localhost:3000/updateproflieavecmdp/", method: .post, parameters: params).responseJSON  { response in

                                                          if let json = response.result.value {
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

                                                              self.showToast(message: json as! String)
                                                            }
                                                          }
                                                          }                            }}
                        else{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

                                self.showToast(message: "Verifier les nouveaux mdp")}

                        }
                                                           }

                          }

        }

        else{




        let params = ["adresse":self.adresse.text!,"codepostale":self.codepostale.text!,"ville":self.laville,"id":id,"tel":self.numtel.text!] as [String : Any]
                                  Alamofire.request("http://localhost:3000/updateprofliesansmdp/", method: .post, parameters: params).responseJSON  { response in

                                      if let json = response.result.value {

                                          self.showToast(message: json as! String)

                                      }
                                      }
        }
        
    }
    var imagePicker = UIImagePickerController()
    @IBAction func addProfilePicBtnAction(_ sender: Any) {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
                self.openCamera()
            }))
            
            alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
                self.openGallery()
            }))
            
            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
//        @IBAction func backBtnAction(_ sender: Any) {
//            navigationController?.popViewController(animated: true)
//            dismiss(animated: true, completion: nil)
//        }
        
        //MARK: - Open the camera
        func openCamera(){
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.allowsEditing = true
                imagePicker.delegate = self
                self.present(imagePicker, animated: true, completion: nil)
            }
            else{
                let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        //MARK: - Open the gallery
        func openGallery(){
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        func dismissVC() {
            dismiss(animated: false, completion: nil)
        }
    @IBOutlet weak var addProfilePicBtn: UIButton!

}


extension PlayVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{

            self.addProfilePicBtn.setImage(editedImage, for: UIControl.State.normal)
            self.NewImage = 1
             let Usercon = UserDefaults.standard
            
                    let id: String = (Usercon.object(forKey: "id") as? String)!
            print("aaaaaaakoajojifvjifnvivingvoiniongonvgongnvgornvojrnvomznvonvndfonvdo")
            
            let imageData = editedImage.jpegData(compressionQuality: 1.0)
                  let parameters: Parameters = ["id":id
                                               ]

                 print(parameters)

                 Alamofire.upload(multipartFormData: { (multipartFormData) in
                     if let data = imageData{
                         multipartFormData.append(data, withName: "upload", fileName: "upload"+".png", mimeType: "image/png")
                     }
                     for (key, value) in parameters {
                         multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!,withName: key as String)

                     }
                 }, to: "http://localhost:3000/updateimage/")
                 { (result) in
                     switch result {
                     case .success(let upload, _, _):
                         upload.uploadProgress(closure: { (progress) in
                             //Print progress
                             print(progress)
                         })
                         upload.validate()
            
            
            
            
           // self.addProfilePicBtn.layer.cornerRadius = self.addProfilePicBtn.frame.width / 2
           // self.addProfilePicBtn.layer.masksToBounds = true
         //   profileImage = editedImage
                     case .failure(_):
                        print("fail");
                    }}}
                    
        //Dismiss the UIImagePicker after selection
        picker.dismiss(animated: true, completion: nil)
    }
}
