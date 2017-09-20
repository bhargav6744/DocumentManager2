//
//  ForgotPasswordViewController.swift
//  Document Manager
//
//  Created by Hitesh V-PI on 03/07/17.
//  Copyright © 2017 Pixabit Infotech. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet var subView: UIView!
    override func viewDidLoad() {
         self.title = "Forgot Password"
        
        
         self.subView.isHidden = true
        
        
        
        
        
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    @IBAction func OTPSubmit(_ sender: UIButton) {
        
        self.subView.isHidden = false
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        
        
    }
    
    @IBAction func closeBtn(_ sender: Any) {
          self.subView.isHidden = true
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
 
}
