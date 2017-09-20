//
//  SecondViewController.swift
//  Document Manager
//
//  Created by Hitesh V-PI on 15/06/17.
//  Copyright © 2017 Pixabit Infotech. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITabBarDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var expiryTxt: UITextField!
    @IBOutlet var btnCollection: [UIButton]!
    @IBOutlet var tabBar: UITabBar!
    
    
    var expiry = ["No Expiry","1 Week","2 Week","3 Week","1 Month","3 Month","6 Month","1 Year","2 year","5 year","10 Year","20 Year"]
   var expiryPicker = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.topItem?.title = "Document"
         expiryPicker.delegate = self
         expiryPicker.dataSource = self
        expiryTxt.inputView = expiryPicker
        
        
        
        
        tabBar.delegate = self
        for but in btnCollection {
            if but.tag == 0{
                but.isSelected = true;
                break
            }
        }


       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: false)
        tabBar.selectedItem = tabBar.items![1] as UITabBarItem
    }
    

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            
            let First = self.storyboard?.instantiateViewController(withIdentifier: "First") as! FirstViewController
            self.navigationController?.pushViewController(First, animated: false)

            
            break
            
        case 1:
            
            
            break
            
        case 2:
            
            
            let Third = self.storyboard?.instantiateViewController(withIdentifier: "Third") as! ThirdViewController
            self.navigationController?.pushViewController(Third, animated: false)
            
            break
            
        case 3:
            
            
            let Fourth = self.storyboard?.instantiateViewController(withIdentifier: "Fourth") as! FourthViewController
            self.navigationController?.pushViewController(Fourth, animated: false)
            
        default:
            
            
            let Fifth = self.storyboard?.instantiateViewController(withIdentifier: "Fifth") as! FifthViewController
            self.navigationController?.pushViewController(Fifth, animated: false)
            
        }
    }
    
    @IBAction func checkboxAction(_ sender: UIButton) {
        for btn in self.btnCollection {
            if (sender == btn) {
                btn.isSelected = true
            } else {
                btn.isSelected = false
            }
        }
        
        
        
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
            return expiry.count
              }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
            return (expiry[row] )
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
       
            expiryTxt.text = (expiry[row] )
            
        }
    

    
}
