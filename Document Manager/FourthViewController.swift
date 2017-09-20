//
//  FourthViewController.swift
//  Document Manager
//
//  Created by Hitesh V-PI on 14/06/17.
//  Copyright © 2017 Pixabit Infotech. All rights reserved.
//

import UIKit
import Alamofire

class FourthViewController: UIViewController, UITabBarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var activityIndecator: UIActivityIndicatorView!
    @IBOutlet var hightOfView: NSLayoutConstraint!
    @IBOutlet var sagment: UISegmentedControl!
    @IBOutlet var tabBar: UITabBar!
    @IBOutlet var newView: UIView!
    @IBOutlet var SecondView: UIScrollView!
    @IBOutlet var listingView: UIView!
    @IBOutlet var listingTblview: UITableView!
   
    @IBOutlet var nameOfPerson: txtField!
    @IBOutlet var lattitude: UITextField!
    @IBOutlet var longitude: UITextField!
    @IBOutlet var note: UITextView!
    var img = UIImage()
    let Picker = UIImagePickerController()
    var image = NSMutableArray()
    
    @IBOutlet var imgView: UIView!
    

    @IBOutlet var img1: UIImageView!
    
    @IBOutlet var scrollwidth: NSLayoutConstraint!
    @IBOutlet var imgToLocation: NSLayoutConstraint!
  
    var hello = NSArray()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView()
        self.navigationController?.navigationBar.topItem?.title = "Asset"
        self.lattitude.isEnabled = false
        self.longitude.isEnabled = false
        

        tabBar.delegate = self
        scrollwidth.constant = 0;
                
        self.note.layer.borderWidth = 0.3
        let Color : UIColor = UIColor.lightGray
        note.layer.borderColor = Color.cgColor
        note.layer.cornerRadius = 3.0
        
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
       
        longitude.text = UserDefaults.standard.object(forKey: "lon") as? String
        lattitude.text = UserDefaults.standard.object(forKey: "lat") as? String
        
        UserDefaults.standard.removeObject(forKey: "lat")
        UserDefaults.standard.removeObject(forKey: "lon")
        
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        tabBar.selectedItem = tabBar.items![3] as UITabBarItem
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            
            let Third = self.storyboard?.instantiateViewController(withIdentifier: "Third") as! ThirdViewController
            self.navigationController?.pushViewController(Third, animated: false)
            
            break
            
        case 3:
            
            
            break
            
        default:
            
            
            let Fifth = self.storyboard?.instantiateViewController(withIdentifier: "Fifth") as! FifthViewController
            self.navigationController?.pushViewController(Fifth, animated: false)
            
        }
    }
    
    @IBAction func imageBtn(_ sender: UIButton) {
        if image.count < 5 {
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
        }
        
        // Add the actions
        Picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

    else{
            let alert = UIAlertController(title: "More Then Five image are not allowed", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
            {
                _ in
                
                }
            )
            self.present(alert, animated: true, completion: nil)

    
    
        }
    }
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            Picker.sourceType = UIImagePickerControllerSourceType.camera
            self .present(Picker, animated: true, completion: nil)
        }else{
            let alert = UIAlertView()
            alert.title = "Warning"
            alert.message = "You don't have camera"
            alert.addButton(withTitle: "OK")
            alert.show()
        }
    }
    func openGallary(){
        Picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(Picker, animated: true, completion: nil)
    }
    //MARK:UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if let picture = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image.add(picture)
            
          
            self.imageAdd()
            
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)    }
    private func imagePickerControllerDidCancel(picker: UIImagePickerController){
        print("picker cancel.")
    }

    @IBAction func mapViewBtn(_ sender: UIButton) {
        
        let Map = self.storyboard?.instantiateViewController(withIdentifier: "Map") as! MapViewController
        self.navigationController?.pushViewController(Map, animated: false)
        

    }
    @IBAction func sagment(_ sender: Any) {
        switch sagment.selectedSegmentIndex
        {
        case 0:
            SecondView.isHidden = true
            listingView.isHidden = false
            tblView()
            
            
        case 1:
            
            listingView.isHidden = true
            SecondView.isHidden = false
        default:
            break
        }
        
        
        
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSection: NSInteger = 0
        if hello.count > 0{
         self.listingTblview.backgroundView = nil
         numOfSection = 1
        }
        else{
            
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! AssetListingTableViewCell
        
        let Dec = hello[indexPath.row] as! NSDictionary
       
        cell.lblFullName.text =  Dec["PersonName"] as? String
         return cell
    }

        
    func ButtonTapped(sender: UIButton){
        
        image.removeObject(at: sender.tag)
        for i in imgView.subviews{
            
            i.removeFromSuperview()
            
        }
        
        self.imageAdd()
        
        
        
        
        
    }
    func imageAdd(){
        UIView.animate(withDuration: 0.5, animations: {
            _ in
            self.hightOfView.constant = 280
            var j = Int()
            j = 10;
            if self.image.count != 0{
                self.imgToLocation.constant = 120
            }
            else{
                self.imgToLocation.constant = 10
            }
            for i in 0..<self.image.count{
                
                let imageView = UIImageView(image: self.image[i] as? UIImage)
                self.imgView.addSubview(imageView)
                
                imageView.frame = CGRect(x: j, y: 10, width: 100, height: 100)
                
                
                
                let button = UIButton(frame: CGRect(x: j+93, y: Int(0.3), width: 15, height: 15))
                button.tag = i
                button.setImage(#imageLiteral(resourceName: "imageClose"), for: .normal)
                button.addTarget(self, action: #selector(self.ButtonTapped), for: .touchUpInside)
                self.imgView.addSubview(button)
                
                j+=110;
                self.hightOfView.constant = 350
                
            }
            self.scrollwidth.constant = CGFloat(j);
            
            
            
        })
        
    }

    @IBAction func submitBtn(_ sender: UIButton) {
        
        let parameters: Parameters = [
            
            "AssetTypeId":"AST0000009",
            "PersonName":nameOfPerson.text!,
            "Latitude":lattitude.text!,
            "Longitute":longitude.text!,
            "Narration":note.text!
        
        
        
        
        
        
        ]
        
        Alamofire.request("http://192.168.0.120/DocumentManagement/AssetsMaster/InsertAssetsMaster", method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON{
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
    func tblView(){
        self.activityIndecator.startAnimating()
        Alamofire.request("http://192.168.0.120/DocumentManagement/AssetsMaster/GetAllData").responseJSON { response in
            if response.result.error == nil {
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    let json = JSON as! NSDictionary
                    
                        self.hello = json["assetsmaster"] as! NSArray
                        self.listingTblview.reloadData()
                        self.activityIndecator.stopAnimating()
                    
                }
            }
        }
    }


}
        

        





