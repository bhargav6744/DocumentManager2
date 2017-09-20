//
//  ViewController.swift
//  Document Manager
//
//  Created by Hitesh V-PI on 14/06/17.
//  Copyright © 2017 Pixabit Infotech. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
 


class ViewController: UIViewController {
    
    

    @IBOutlet var Activity: UIActivityIndicatorView!
    @IBOutlet var txtField: [UITextField]!
    @IBOutlet var passwordTxt: UITextField!
    @IBOutlet var email: UITextField!
    var iconClick : Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
         //hide seprator
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        self.title = "login"
        //FirebaseApp.configure()
        iconClick = true
         passwordTxt.isSecureTextEntry = true
        
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if(isUserLoggedIn){
            
            let Button1 = self.storyboard?.instantiateViewController(withIdentifier: "First") as!  FirstViewController
            self.navigationController?.pushViewController(Button1, animated: false)
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
            }
    override func viewWillAppear(_ animated: Bool) {
       self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        
       self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
    
    @IBAction func login(_ sender: UIButton) {
       
        var validation = true
        for txtField in  txtField {
            if (txtField.text?.isEmpty)! {
                validation = false
            }
        }
        if validation == true {
            
            
            
                 self.Activity.startAnimating()
            
                print(self.email.text)
            
           
            
            
                let email = self.email.text
                let password = self.passwordTxt.text

            Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                    let alert = UIAlertController(title: "Wrong Email Or Password", message: "Please Check Your Passwrd", preferredStyle: UIAlertControllerStyle.alert)
                    
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
                    {
                        _ in
                        
                        }
                    )
                    self.present(alert, animated: true, completion: nil)

                    return

                }
                else{
                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                    UserDefaults.standard.synchronize();
                    if Auth.auth().currentUser!.isEmailVerified == true{
                    let Button = self.storyboard?.instantiateViewController(withIdentifier: "First") as! FirstViewController
                    self.navigationController?.pushViewController(Button, animated: true)
                    }
                    else{
                        let alert = UIAlertController(title: "Something Wrong", message: "Please create Account Or verify Email", preferredStyle: UIAlertControllerStyle.alert)
                        
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
                        {
                            _ in
                            
                            }
                        )
                        self.present(alert, animated: true, completion: nil)
                        
                        
                    }

                    
                }
            
            
            
                }
            
            
        }
        
            
            
         self.Activity.stopAnimating()
         //   self.dismiss(animated: true, completion: nil)
          //  return
        
            
    }

    
     
 
    @IBOutlet var visibleBtn: UIButton!
    @IBAction func visibleIcon(_ sender: UIButton) {
        
        
        
    
        
        if(iconClick == true) {
             passwordTxt.isSecureTextEntry = false
            iconClick = false
            visibleBtn.isSelected = true
            

        } else {
            passwordTxt.isSecureTextEntry = true
            iconClick = true
            visibleBtn.isSelected = false
        }
        
        
        
        
        
    }
    
    @IBAction func forgotPassword(_ sender: UIButton) {
        
        let forgot = self.storyboard?.instantiateViewController(withIdentifier: "Forgot") as! ForgotPasswordViewController
        self.navigationController?.pushViewController(forgot, animated: true)
        
        
        
        
    }

    @IBAction func Signup(_ sender: UIControl) {
        
        let signUp = self.storyboard?.instantiateViewController(withIdentifier: "signUp") as! signUpViewController
        self.navigationController?.pushViewController(signUp, animated: false)
        
        
        
    }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
}
class  txtField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
}



