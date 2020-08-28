//
//  ViewController.swift
//  webService
//
//  Created by Hatem Chaabini on 10/11/2019.
//  Copyright © 2019 Hatem Chaabini. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Firebase
class Register: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imaageee: UIImageView!
    @IBOutlet weak var backbtn: UIButton!
    var userImage: UIImage?
    var firebaseid: String = ""
    var imagPickUp : UIImagePickerController!
     var imageV : UIImageView!
    func imageAndVideos()-> UIImagePickerController{
        if(imagPickUp == nil){
            imagPickUp = UIImagePickerController()
            imagPickUp.delegate = self
            imagPickUp.allowsEditing = false
        }
        return imagPickUp
    }
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
    

    @IBAction func reo(_ sender: Any) {
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
    fileprivate func registerUserIntoDatabaseWithUID(_ uid: String, values: [String: AnyObject]) {
            let ref = Database.database().reference()
            let usersReference = ref.child("Users").child(uid)
            
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if err != nil {
                    print(err!)
                    return
                }
            })
        }
    @IBAction func Creecompte(_ sender: Any) {
     
        if(self.name.text! != "" && self.password.text! != "" && self.Username.text! != "" && self.mdp2.text! != "" && self.adresse.text! != "" && self.numtel.text! != "" && self.codepostale.text! != "" && self.mail.text! != "" && imaageee.image?.size != nil){
            
     let image = userImage
          

          let imageData = image!.jpegData(compressionQuality: 1.0)
          let parameters: Parameters = ["name":"aaaa"
                                       ]

         print(parameters)

         Alamofire.upload(multipartFormData: { (multipartFormData) in
             if let data = imageData{
                 multipartFormData.append(data, withName: "upload", fileName: "upload"+".png", mimeType: "image/png")
             }
             for (key, value) in parameters {
                 multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!,withName: key as String)

             }
         }, to: "http://localhost:3000/upload/")
         { (result) in
             switch result {
             case .success(let upload, _, _):
                 upload.uploadProgress(closure: { (progress) in
                     //Print progress
                     print(progress)
                 })
                 upload.validate()

                 upload.responseJSON { response in
                     if response.response?.statusCode == 200
                     {
                 
                        self.nom = self.name.text!
                            self.mdp = self.password.text!
                            self.userna = self.Username.text!
                            self.mdpp2 = self.mdp2.text!
                            self.adress = self.adresse.text!
                            self.numtell = self.numtel.text!
                            self.codep = self.codepostale.text!
                            self.emaill = self.mail.text!
                            print("mmmmmmmmmmmmmmm")
                            print(self.lemetier)
                        Auth.auth().createUser(withEmail: self.emaill, password: self.mdpp2, completion: { (user, error) in
                                             
                                             if error != nil {
                                                 print(error!)
                                                self.showToast(message: "Email deja utilisé")
                                                 return
                                             }
                                             
                                             guard let uid = user?.user.uid else {
                                                 return
                                             }
                            self.firebaseid = (user?.user.uid)!
                            if(self.lemetier == "Aucune specialite" ){
                                                            let Usercon = UserDefaults.standard

                                                            print((Usercon.object(forKey: "usertoken") as? String)!)

                                                           
                                                               let params = ["firebaseid":(user?.user.uid)!,"token":(Usercon.object(forKey: "usertoken") as? String)!,
                                                               "email":self.emaill,"name":self.nom,"password":self.mdp,"username":self.userna,"numtel":self.numtell,"adresse":self.adress,"metier":self.lemetier,"ville":self.laville,"codepostale":self.codep,"prix":0] as [String : Any]
                                                           Alamofire.request("http://localhost:3000/register/", method: .post, parameters: params).responseJSON  { response in
                                                               print(response.request) // original url request
                                                               print(response.response) // http url reponse
                                                               if let json = response.result.value {
                                                                   
                                                                   self.showToast(message: json as! String)

                                                               }
                                                               }}
                                                           else{
                                                               self.performSegue(withIdentifier: "prix", sender: Any?.self)}                                             //successfully authenticated user
                                             let imageName = UUID().uuidString
                                             let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).jpg")
                                             
                            if let profileImage = self.userImage, let uploadData = profileImage.jpegData(compressionQuality: 0.1) {
                                             
                                                 storageRef.putData(uploadData, metadata: nil, completion: { (_, err) in
                                                     
                                                     if let error = error {
                                                         print(error)
                                                         return
                                                     }
                                                     
                                                     storageRef.downloadURL(completion: { (url, err) in
                                                         if let err = err {
                                                             print(err)
                                                             return
                                                         }
                                                         
                                                         guard let url = url else { return }
                                    let values = ["id":uid,"username": self.userna,"search": self.userna,"status":"online", "imageURL": url.absoluteString]
                                                        
                                                         self.registerUserIntoDatabaseWithUID(uid, values: values as [String : AnyObject])
                                                     })
                                                     
                                                 })
                                             }
                                         })
                        
                    }

                
             }
           
             case .failure(_):
              print("bbbbbb")
            }}
            
        }else{
            self.showToast(message: "Remplir tout les champs")
        }
   
        }
    func registerfire(ui:String){
        print("uuuuuuuuuuuuuihhcbcbcbcbcbcbc")
        print(ui)
        print("uuuuuuuuuuuuuihhcbcbcbcbcbcbc")

        if(self.lemetier == "Aucune specialite" ){
                                 let Usercon = UserDefaults.standard

                                 print((Usercon.object(forKey: "usertoken") as? String)!)

                                
                                    let params = ["firebaseid":ui,"token":(Usercon.object(forKey: "usertoken") as? String)!,
                                    "email":self.emaill,"name":self.nom,"password":self.mdp,"username":self.userna,"numtel":self.numtell,"adresse":self.adress,"metier":self.lemetier,"ville":self.laville,"codepostale":self.codep,"prix":0] as [String : Any]
                                Alamofire.request("http://localhost:3000/register/", method: .post, parameters: params).responseJSON  { response in
                                    print(response.request) // original url request
                                    print(response.response) // http url reponse
                                    if let json = response.result.value {
                                        
                                        self.showToast(message: json as! String)

                                    }
                                    }}
                                else{
                                    self.performSegue(withIdentifier: "prix", sender: Any?.self)}
                            
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           let popup = segue.destination as! PopupController
        popup.nom = self.nom
        popup.userna = self.userna
        popup.adress = self.adress
        popup.codep = self.codep
        popup.emaill = self.emaill
        popup.mdp = self.mdp
        popup.metier = self.lemetier
        popup.numtell = self.numtell
        popup.ville = self.laville
        popup.firebaseid = self.firebaseid
          
       }
    var laville:String = ""
    var lemetier:String = ""
    var LesMetiers:NSArray = []
    var nom:String = ""
       var emaill:String = ""
       var mdp:String = ""
       var mdpp2:String = ""
       var adress:String = ""
       var numtell:String = ""
       var codep:String = ""
       var userna:String = ""
    @IBOutlet weak var villepicker: UIPickerView!
    @IBOutlet weak var Username: UITextField!
    
    @IBOutlet weak var numtel: UITextField!
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var mdp2: UITextField!
    @IBOutlet weak var adresse: UITextField!
    @IBOutlet weak var codepostale: UITextField!
    
    @IBOutlet weak var pickerview: UIPickerView!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        name.attributedPlaceholder = NSAttributedString(string:"Nom et Prenom", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        password.attributedPlaceholder = NSAttributedString(string:"Mot de passe", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        Username.attributedPlaceholder = NSAttributedString(string:"Nom Utilisateur", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
           mail.attributedPlaceholder = NSAttributedString(string:"Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        numtel.attributedPlaceholder = NSAttributedString(string:"Numéro de telephone", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        mdp2.attributedPlaceholder = NSAttributedString(string:"Répéter Mot de passe", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        adresse.attributedPlaceholder = NSAttributedString(string:"Adresse", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        codepostale.attributedPlaceholder = NSAttributedString(string:"Code Postale", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
       imagPickUp = self.imageAndVideos()

       let button = UIButton(frame: CGRect(x: 152, y: 730, width: 200, height: 50))
       button.setTitle("Choisir Image", for: .normal)
       button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
       self.view.addSubview(button)


//       imageV = UIImageView(frame: CGRect(x: 100, y: 200, width: 200, height: 150))
//       imageV.layer.cornerRadius = 10
//       imageV.clipsToBounds = true
//       imageV.layer.borderWidth = 2.0
//       imageV.layer.borderColor = UIColor.red.cgColor
//       view.addSubview(imageV)
        
        /*Alamofire.request("http://localhost:3000/metier/", method: .get).responseJSON  { response in
                 print(response.request) // original url request
                 print(response.response) // http url reponse
            if let json = response.result.value {
                          print("JSON: \(json)") // serialized json response after post
                       }
             //    if let json = response.result.value {}
             }*/
        backbtn.setImage(UIImage(named: "bacbtn"), for: .normal)

        fetchMetier();
    }
    
    @objc func buttonClicked() {
        let ActionSheet = UIAlertController(title: nil, message: "Select Photo", preferredStyle: .actionSheet)

        let cameraPhoto = UIAlertAction(title: "Camera", style: .default, handler: {
            (alert: UIAlertAction) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){

                self.imagPickUp.mediaTypes = ["public.image"]
                self.imagPickUp.sourceType = UIImagePickerController.SourceType.camera;
                self.present(self.imagPickUp, animated: true, completion: nil)
            }
            else{
                UIAlertController(title: "iOSDevCenter", message: "No Camera available.", preferredStyle: .alert).show(self, sender: nil);
            }

        })

        let PhotoLibrary = UIAlertAction(title: "Photo Library", style: .default, handler: {
            (alert: UIAlertAction) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                self.imagPickUp.mediaTypes = ["public.image"]
                self.imagPickUp.sourceType = UIImagePickerController.SourceType.photoLibrary;
                self.present(self.imagPickUp, animated: true, completion: nil)
            }

        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction) -> Void in

        })

        ActionSheet.addAction(cameraPhoto)
        ActionSheet.addAction(PhotoLibrary)
        ActionSheet.addAction(cancelAction)


        if UIDevice.current.userInterfaceIdiom == .pad{
            let presentC : UIPopoverPresentationController  = ActionSheet.popoverPresentationController!
            presentC.sourceView = self.view
            presentC.sourceRect = self.view.bounds
            self.present(ActionSheet, animated: true, completion: nil)
        }
        else{
            self.present(ActionSheet, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imaageee.image = image
        self.userImage = image

        imagPickUp.dismiss(animated: true, completion: { () -> Void in
            // Dismiss
        })

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagPickUp.dismiss(animated: true, completion: { () -> Void in
            // Dismiss
        })
    }
    func fetchMetier(){
          
          Alamofire.request("http://localhost:3000/metier/", method: .get).responseJSON{
              
              response in
              
              
              
            print(response.result.value)
              
              self.LesMetiers = response.result.value as! NSArray
              
            self.pickerview.reloadAllComponents()
          }
}
    
    
    
    
    public func validateName(name: String) ->Bool {
       // Length be 18 characters max and 3 characters minimum, you can always modify.
       let nameRegex = "^\\w{3,18}$"
       let trimmedString = name.trimmingCharacters(in: .whitespaces)
       let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
       let isValidateName = validateName.evaluate(with: trimmedString)
       return isValidateName
    }
    public func validaPhoneNumber(phoneNumber: String) -> Bool {
       let phoneNumberRegex = "^[6-9]\\d{9}$"
       let trimmedString = phoneNumber.trimmingCharacters(in: .whitespaces)
       let validatePhone = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
       let isValidPhone = validatePhone.evaluate(with: trimmedString)
       return isValidPhone
    }
    public func validateEmailId(emailID: String) -> Bool {
       let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
       let trimmedString = emailID.trimmingCharacters(in: .whitespaces)
       let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
       let isValidateEmail = validateEmail.evaluate(with: trimmedString)
       return isValidateEmail
    }
    public func validatePassword(password: String) -> Bool {
       //Minimum 8 characters at least 1 Alphabet and 1 Number:
       let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
       let trimmedString = password.trimmingCharacters(in: .whitespaces)
       let validatePassord = NSPredicate(format:"SELF MATCHES %@", passRegEx)
       let isvalidatePass = validatePassord.evaluate(with: trimmedString)
       return isvalidatePass
    }
}

