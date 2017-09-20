//
//  SecondViewController.swift
//  Document Manager
//
//  Created by Hitesh V-PI on 14/06/17.
//  Copyright © 2017 Pixabit Infotech. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {

    var hello = ["hello 1","hello 2","hello 3","hello 4","hello 5"]
    var hi = ["hi 1","hi 2","hi 3","hi 4","hi 5"]
    
    @IBOutlet var tblView: UITableView!
    
    @IBOutlet var tabBar: UITabBar!
    @IBOutlet var segment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.delegate = self
        
        let button1 = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: self, action: #selector(addTapped)) // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.rightBarButtonItem  = button1
        
        
        tblView.tableFooterView = UIView()
        
        self.navigationController?.navigationBar.topItem?.title = "Home"
       
              
    }
    override func viewWillAppear(_ animated: Bool) {
         self.navigationItem.setHidesBackButton(true, animated: false)
         tabBar.selectedItem = tabBar.items![0] as UITabBarItem
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return hello.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        
      //  cell.textLabel?.text = hello[indexPath.row]
        return cell
    }

    @IBAction func action(_ sender: UISegmentedControl) {
        switch segment.selectedSegmentIndex
        {
        case 0:
            hello = ["hello 1","hello 2","hello 3","hello 4","hello 5"]
            tblView.reloadData()
        case 1:
            hello = ["hi 1","hi 2","hi 3","hi 4","hi 5"]
            tblView.reloadData()
        default:
            break
        }
    }
    
    func addTapped(){
        
        let doc = self.storyboard?.instantiateViewController(withIdentifier: "docEntry") as! docEntryViewController
        self.navigationController?.pushViewController(doc, animated: true)
    
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            
            break
            
        case 1:
            
            let Second = self.storyboard?.instantiateViewController(withIdentifier: "Second") as! SecondViewController
            self.navigationController?.pushViewController(Second, animated: false)
            
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

    

   

}
