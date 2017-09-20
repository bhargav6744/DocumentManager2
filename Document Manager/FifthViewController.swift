//
//  FifthViewController.swift
//  Document Manager
//
//  Created by Hitesh V-PI on 14/06/17.
//  Copyright © 2017 Pixabit Infotech. All rights reserved.
//

import UIKit

class FifthViewController: UIViewController, UITabBarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var hightOutlet: NSLayoutConstraint!
    @IBOutlet var ProfileView: UIView!
    @IBOutlet var addressTxt: UITextView!
    @IBOutlet var circleImg: UIImageView!
    @IBOutlet var tabBar: UITabBar!
    
    @IBOutlet var txtName: UITextField!
    
    @IBOutlet var cameraBtn: UIButton!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPhone: UITextField!
    @IBOutlet var txtBirthday: UITextField!
    @IBOutlet var textCollection: [UITextField]!
    @IBOutlet var updateBtn: UIButton!
    var img = UIImage()
    let Picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Profile"
        tabBar.delegate = self
        
        // text disable
        
        self.txtName.isEnabled = false
        self.txtBirthday.isEnabled = false
        self.txtPhone.isEnabled = false
        self.txtEmail.isEnabled = false
        self.addressTxt.isEditable = false
        self.cameraBtn.isHidden = true
        self.updateBtn.isHidden = true
        self.hightOutlet.constant = 350
        
        
        
        
        
        let button1 = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(Logout))
        self.navigationItem.leftBarButtonItem = button1

        let button2 = UIBarButtonItem(title: "EDIT", style: .plain, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = button2
       
        // image view
        self.circleImg.layer.cornerRadius = self.circleImg.frame.size.width / 2;
        self.circleImg.clipsToBounds = true
        self.circleImg.layer.borderWidth = 2
        let myColor : UIColor = UIColor.yellow
        circleImg.layer.borderColor = myColor.cgColor
        
        //text view 
        self.addressTxt.layer.borderWidth = 0.3
        let Color : UIColor = UIColor.lightGray
        addressTxt.layer.borderColor = Color.cgColor
        addressTxt.layer.cornerRadius = 3.0
        
       

        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        
        
        
        
        
        
        
        
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: false)
        tabBar.selectedItem = tabBar.items![4] as UITabBarItem
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
            
            
            let Fourth = self.storyboard?.instantiateViewController(withIdentifier: "Fourth") as! FourthViewController
            self.navigationController?.pushViewController(Fourth, animated: false)
            
        default:
            
            break
            
            
            
        }
    }
    
    @IBAction func imgButton(_ sender: UIButton) {
        
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
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            circleImg.image = image
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)    }
    private func imagePickerControllerDidCancel(picker: UIImagePickerController){
        print("picker cancel.")
    }

    
    
    func addTapped(){
        
        self.txtName.isEnabled = true
        self.txtBirthday.isEnabled = true
        self.txtPhone.isEnabled = true
        self.txtEmail.isEnabled = true
        self.addressTxt.isEditable = true
        
        self.cameraBtn.isHidden = false
        self.updateBtn.isHidden = false
        
        
        let button2 = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(Edit))
        self.navigationItem.rightBarButtonItem = button2
        self.hightOutlet.constant = 450
        

        
    }
    
    @IBAction func SaveChange(_ sender: UIButton) {
        self.txtName.isEnabled = false
        self.txtBirthday.isEnabled = false
        self.txtPhone.isEnabled = false
        self.txtEmail.isEnabled = false
        self.addressTxt.isEditable = false
        self.cameraBtn.isHidden = true
        self.updateBtn.isHidden = true
        let button2 = UIBarButtonItem(title: "EDIT", style: .plain, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = button2
        self.hightOutlet.constant = 350
        
        
    }
    
    func Edit(){
        
        
        self.txtName.isEnabled = false
        self.txtBirthday.isEnabled = false
        self.txtPhone.isEnabled = false
        self.txtEmail.isEnabled = false
        self.addressTxt.isEditable = false
        self.cameraBtn.isHidden = true
        self.updateBtn.isHidden = true
 
        let button2 = UIBarButtonItem(title: "EDIT", style: .plain, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = button2
        self.hightOutlet.constant = 350
        
        
        
    }
    
    func Logout(){
        
        
        let alert:UIAlertController=UIAlertController(title: "Are You Sure Want to Logout", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let YesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.logedout()
            
        }
        let NoAction = UIAlertAction(title: "No", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            
        }
        
        
        
        
        
        
        // Add the actions
        Picker.delegate = self
        alert.addAction(YesAction)
        alert.addAction(NoAction)
       
        
        self.present(alert, animated: true, completion: nil)
    }
    func logedout(){
       // let logout = self.storyboard?.instantiateViewController(withIdentifier: "View") as! ViewController
       // self.navigationController?.pushViewController(logout, animated: false)
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn");
        UserDefaults.standard.synchronize();
        let Button1 = self.storyboard?.instantiateViewController(withIdentifier: "View") as!  ViewController
        self.navigationController?.pushViewController(Button1, animated: true)
        
        
        
    }
    
    
        
        
    
    }
   

