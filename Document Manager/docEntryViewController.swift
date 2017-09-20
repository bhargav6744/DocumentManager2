//
//  docEntryViewController.swift
//  Document Manager
//
//  Created by Hitesh V-PI on 20/06/17.
//  Copyright © 2017 Pixabit Infotech. All rights reserved.
//

import UIKit
import Alamofire

class docEntryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    var datePicker = UIDatePicker()
    let Picker = UIImagePickerController()
    var image = NSMutableArray()

    @IBOutlet var documentName: txtField!
    @IBOutlet var documentType: txtField!
    @IBOutlet var documentOf: txtField!
    @IBOutlet var documentNumber: txtField!
    @IBOutlet var expiryDate: txtField!
    @IBOutlet var issueDate: txtField!
    @IBOutlet var imgView: UIView!
    @IBOutlet var submitBtnHight: NSLayoutConstraint!
    @IBOutlet var DocViewConstraint: NSLayoutConstraint!

    @IBOutlet var ScrollWidth: NSLayoutConstraint!
    
  //  var docType = ["Mortgage Documents","Loan Document","Passport","Driving License","Aadhaar Card","Election Card","Rationing Card","Bank Passbook","Rental Agreement","Water Bill","Electricity Bill","Gas Connection","School Leaving Certificate","Birth Certificates",]
    
    
    
    
    
    
    
    
    var ValidityMonth = ""
    
    var docType = NSArray()
    var docOf = NSArray()
    
    var docPicker = UIPickerView()
    
    
    override func viewDidLoad() {
       
        getdata()
        
        docPicker = UIPickerView()
        docPicker.delegate = self
        docPicker.dataSource = self
        docPicker.tag = 1
        self.documentType.inputView = docPicker
       
        docPicker = UIPickerView()
        docPicker.tag = 2
        self.docPicker.delegate = self
        self.docPicker.dataSource = self
        self.documentOf.inputView = docPicker
        
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.topItem?.title = "Doc Entry"
        ScrollWidth.constant = 0
        datePicker.tag = 0
        datePicker.addTarget(self, action: #selector(docEntryViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        datePicker.datePickerMode = .date
        issueDate.inputView = datePicker
        datePicker = UIDatePicker()
        datePicker.tag = 1
        datePicker.addTarget(self, action: #selector(docEntryViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        datePicker.datePickerMode = .date
        expiryDate.inputView = datePicker
       
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitBtn(_ sender: UIButton) {
        
        let parameters: Parameters = [
        
        
        "IssueDate":issueDate.text!,
        "ExpDate":expiryDate.text!,
        "DocNumber":documentNumber.text!
        
        
        
        
        
        
        
        
       ]
        
        Alamofire.request("http://192.168.0.120/DocumentManagement/AssetsMaster/InsertAssetsMaster", method: .post, parameters: parameters, encoding: URLEncoding.default).responseString{
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

    @IBAction func uploadImg(_ sender: UIButton) {
        
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
        self.DocViewConstraint.constant = 600
        self.submitBtnHight.constant = 20
        var j = Int()
        j = 10;
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
            self.submitBtnHight.constant = 130
            self.DocViewConstraint.constant = 700
        }
        self.ScrollWidth.constant = CGFloat(j);
        
    })
   
}
    
    //Date Picker
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        if sender.tag == 0{
        issueDate.text = dateFormatter.string(from: sender.date)
        issueCount()
        }
        else{
        expiryDate.text = dateFormatter.string(from: sender.date)
        exiryCount()
        }
    }
    

    
    // alaomafire
    
    
    func getdata(){
        Alamofire.request("http://192.168.0.120/DocumentManagement/AssetsType/GetDocumentData").responseJSON { response in
            if response.result.error == nil {
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    let json = JSON as! NSDictionary
                    self.docOf = json["relationmaster"] as! NSArray
                    self.docType = json["assetstypebyvalidity"] as! NSArray
                     print(self.docType)
                    

        
        
        
        
        
        
                }
    
    
            }
        }
    }
    
    
    
    // picerview
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
       if pickerView.tag == 1{
            return docType.count
        }
       else if pickerView.tag == 2 {
        
        
         return docOf.count
        }
    
        return 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        
        if pickerView.tag == 1{
            let DecTwo = docType[row] as! NSDictionary
            return DecTwo["AssetTypeName"] as? String
            
        }
       else if  pickerView.tag == 2 {
             let Dec = docOf[row] as! NSDictionary
              return Dec["RelationTypeName"] as? String
         }
        return ""
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
       
        if pickerView.tag == 1{
             let DecTwo = docType[row] as! NSDictionary
            
             documentType.text = DecTwo["AssetTypeName"] as? String
             ValidityMonth =  DecTwo["ValidityMonth"] as? String ?? ""
            
            if !expiryDate.text!.isEmpty{
               exiryCount()
            }
            
            else if !issueDate.text!.isEmpty{
                issueCount()
                
            }
            
            
        }
        else if pickerView.tag == 2  {
             let Dec = docOf[row] as! NSDictionary
           documentOf.text = Dec["RelationTypeName"] as? String
       }
        
        
    }
    
    func exiryCount(){
        let iss: Int = Int(ValidityMonth)!
        let dateString = expiryDate.text // change to your date format
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        let date = dateFormatter.date(from: dateString!)
        print(date!)
        
        let issue = Calendar.current.date(byAdding: .month, value: -iss, to: date!)
        print(issue)
        
        issueDate.text = dateFormatter.string(from: issue!)
        
        
        
    }
    func issueCount(){
        let iss: Int = Int(ValidityMonth)!
        let dateString = issueDate.text // change to your date format
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        let date = dateFormatter.date(from: dateString!)
        print(date!)
        
        let exp = Calendar.current.date(byAdding: .month, value: +iss, to: date!)
        print(exp)
        
        expiryDate.text = dateFormatter.string(from: exp!)

        
        
        
    }
    
    
    
    
    
    
    
}
