//
//  ThirdViewController.swift
//  Document Manager
//
//  Created by Hitesh V-PI on 14/06/17.
//  Copyright © 2017 Pixabit Infotech. All rights reserved.
//

import UIKit
import Alamofire

class ThirdViewController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var nameOfPerson: txtField!
    @IBOutlet var relation: txtField!
    @IBOutlet var birthdate: txtField!
    @IBOutlet var phone: txtField!
    @IBOutlet var email: txtField!
    @IBOutlet var addressTxt: UITextView!
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var peopleView: UIView!
    @IBOutlet var newView: UIView!
    @IBOutlet var tabBar: UITabBar!
    @IBOutlet var SecondView: UIScrollView!
    @IBOutlet var peopleTblview: UITableView!
     var hello = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "People"
        tabBar.delegate = self
        self.addressTxt.layer.borderWidth = 0.3
        let myColor : UIColor = UIColor.lightGray
        addressTxt.layer.borderColor = myColor.cgColor
        addressTxt.layer.cornerRadius = 3.0
        peopleTblview.tableFooterView = UIView()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: false)
        tabBar.selectedItem = tabBar.items![2] as UITabBarItem
    }
    

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            
            let First = self.storyboard?.instantiateViewController(withIdentifier: "First") as! FirstViewController
            self.navigationController?.pushViewController(First, animated: false)

            
            break
            
        case 1:
            
            let Second = self.storyboard?.instantiateViewController(withIdentifier: "Second") as! SecondViewController
            self.navigationController?.pushViewController(Second, animated: false)
            
            break
            
        case 2:
            
            
            break
            
        case 3:
            
            
            let Fourth = self.storyboard?.instantiateViewController(withIdentifier: "Fourth") as! FourthViewController
            self.navigationController?.pushViewController(Fourth, animated: false)
            
        default:
            
            
            let Fifth = self.storyboard?.instantiateViewController(withIdentifier: "Fifth") as! FifthViewController
            self.navigationController?.pushViewController(Fifth, animated: false)
            
        }
    }
    
    @IBAction func segment(_ sender: UISegmentedControl) {
        switch segment.selectedSegmentIndex
        {
        case 0:
            
            SecondView.isHidden = true
            peopleView.isHidden = false
            
        case 1:
            peopleView.isHidden = true
            SecondView.isHidden = false
        default:
            break
        }

        
        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSection: NSInteger = 0
        if hello.count > 0 {
            self.peopleTblview.backgroundView = nil
            numOfSection = 1
        }
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No data available"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
            
            
        }
        return numOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hello.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        
        //  cell.textLabel?.text = hello[indexPath.row]
        return cell
    }

    @IBAction func submitBtn(_ sender: UIButton) {
        
        let parameters:  Parameters = [
        
            "PersonId": "PER0000001",
            "RelationTypeId": "REL0000003",
            "FullName": nameOfPerson.text!,
            "BirthDate": birthdate.text!,
            "Phone1": phone.text!,
            
            "Email": email.text! ,
            "AddressLine1": addressTxt.text!
        
        
        ]
        
        Alamofire.request("http://192.168.0.120/DocumentManagement/PersonMaster/InsertPersonMaster", method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON
            {
            response in
            
            switch response.result {
            case .success:
                if let JSON = response.result.value{
                    
                    
                    print("JSON: \(JSON)")
                }
                
                
                
                print("Validation Successful")
            case .failure(let error):
                print(error)
                
            }
            
            
            
            
            
        }

        
        
        
    
    
    
    }
 
    

}
