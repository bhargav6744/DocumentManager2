//
//  OTPViewController.swift
//  Document Manager
//
//  Created by Hitesh V-PI on 22/06/17.
//  Copyright © 2017 Pixabit Infotech. All rights reserved.
//

import UIKit
import FirebaseAuth
class OTPViewController: UIViewController {
    var mobilenumber = String()
    @IBOutlet var OTP: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let otpimage = UIImageView(frame: CGRect(x: 0, y: 0, width: 17, height: 17))
        otpimage.image = UIImage(named: "OTP")
        OTP.leftViewMode = .unlessEditing
        OTP.leftView = otpimage
        */

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func OTPSubmit(_ sender: UIButton) {
        
         let defaults = UserDefaults.standard
        let credential: PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: defaults.string(forKey: "authVID")!, verificationCode: OTP.text!)
        
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil{
                 print("error:\(String(describing: error?.localizedDescription))")
                
            }
            else{
                
                print("phone number: \(String(describing: user?.phoneNumber))")
                let userInfo = user?.providerData[0]
                print("provider ID: \(String(describing: userInfo?.providerID))")
                let submit = self.storyboard?.instantiateViewController(withIdentifier: "First") as! FirstViewController
                self.navigationController?.pushViewController(submit, animated: true)
                
            }
        }
        
    }
    
    @IBAction func Resend(_ sender: UIButton) {
        
        PhoneAuthProvider.provider().verifyPhoneNumber(mobilenumber) {(verificationID, error) in
            if error != nil{
                print("error:\(String(describing: error?.localizedDescription))")
                
                
            }
            else{
                let defaults = UserDefaults.standard
                defaults.set(verificationID, forKey: "authVID")
                print(self.mobilenumber)
                
                
                
                
            }
            
        }

        
        
        
    }
    
    
    
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
