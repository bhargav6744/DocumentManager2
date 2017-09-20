//
//  signUpViewController.swift
//  Document Manager
//
//  Created by Hitesh V-PI on 22/06/17.
//  Copyright © 2017 Pixabit Infotech. All rights reserved.
//

import UIKit
import FirebaseAuth

class signUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var Activity: UIActivityIndicatorView!
    @IBOutlet var CountryCode: UITextField!
    @IBOutlet var Name: UITextField!
    @IBOutlet var mobileNumber: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var email: UITextField!
    var sortedArray = NSArray()
    var iconClick : Bool!
    var Country : NSDictionary = ["Afghanistan":"+93",
                                  "Albania":"+355",
                                  "Algeria":"+213","American Samoa":"+1-684",
                                  "Andorra, Principality of":"+376",
                                  "Angola":"+244",
                                  "Anguilla":"+1-264",
                                  "Antarctica":"+672",
                                  "Antigua and Barbuda":"+1-268",
                                  "Argentina":"+54",
                                  "Armenia":"+374",
                                  "Aruba":"+297",
                                  "Australia":"+61",
                                  "Austria":"+43",
                                  "Azerbaijan or Azerbaidjan (Former Azerbaijan Soviet Socialist Republic)":"+994",
                                  
                                  "Bahamas, Commonwealth of The":"+1-242",
                                  "Bahrain, Kingdom of (Former Dilmun)":	"+973",
                                  "Bangladesh (Former East Pakistan)":"+880",
                                  "Barbados":"+1-246",
                                  "Belarus (Former Belorussian [Byelorussian] Soviet Socialist Republic)":"+375",
                                  "Belgium":"+32",
                                  "Belize (Former British Honduras)":"+501",
                                  "Benin (Former Dahomey)":"+229",
                                  "Bermuda":"+1-441",
                                  "Bhutan, Kingdom of":	"+975",
                                  "Bolivia":"+591",
                                  "Bosnia and Herzegovina":"+387",
                                  "Botswana (Former Bechuanaland)":"+267",
                                  "Brazil":"+55",
                                  "Brunei (Negara Brunei Darussalam)":"+673",
                                  "Bulgaria":"+359",
                                  "Burkina Faso (Former Upper Volta)":"+226",
                                  "Burundi (Former Urundi)":"+257",
                                  "Cambodia, Kingdom of (Former Khmer Republic, Kampuchea Republic)":"+855",
                                  "Cameroon (Former French Cameroon)":"+237",
                                  "Canada":"+1",
                                  "Cape Verde":"+238",
                                  "Cayman Islands":"+1-345",
                                  "Central African Republic":"+236",
                                  "Chad":"+235",
                                  "Chile":"+56",
                                  "China":"+86",
                                  "Christmas Island":"+53",
                                  "Cocos (Keeling) Islands":"+61",
                                  "Colombia":"+57",
                                  "Comoros, Union of the":"+269",
                                  "Congo, Democratic Republic of the (Former Zaire)":"+243",
                                  "Congo, Republic of the":"+242",
                                  "Cook Islands (Former Harvey Islands)":"+682",
                                  "Costa Rica":"+506",
                                  "Cote D'Ivoire (Former Ivory Coast)":"+225",
                                  "Croatia (Hrvatska)":"+385",
                                  "Cuba":"+53",
                                  "Cyprus":"+357",
                                  "Czech Republic":"+420",
                                  "Denmark":"+45",
                                  "Djibouti (Former French Territory of the Afars and Issas, French Somaliland)":"+253",
                                  "Dominica":"+1-767",
                                  "Dominican Republic":"+1-809",
                                  
                                  "East Timor (Former Portuguese Timor)":"+670",
                                  "Ecuador":"+593",
                                  "Egypt (Former United Arab Republic - with Syria)":"+20",
                                  "El Salvador":"+503",
                                  "Equatorial Guinea (Former Spanish Guinea)":"+240",
                                  "Eritrea (Former Eritrea Autonomous Region in Ethiopia)":"+291",
                                  "Estonia (Former Estonian Soviet Socialist Republic)":"+372",
                                  "Ethiopia (Former Abyssinia, Italian East Africa)":"+251",
                                  
                                  "Falkland Islands (Islas Malvinas)":"+500",
                                  "Faroe Islands":"+298",
                                  "Fiji":"+679",
                                  "Finland":"+358",
                                  "France":"+33",
                                  "French Guiana or French Guyana":"+594",
                                  "French Polynesia (Former French Colony of Oceania)":"+689",
                                  
                                  "Gabon (Gabonese Republic)":"+241",
                                  "Gambia, The":"+220",
                                  "Georgia (Former Georgian Soviet Socialist Republic)":"+995",
                                  "Germany":"+49",
                                  "Ghana (Former Gold Coast)":"+233",
                                  "Gibraltar":"+350",
                                  "Greece":"+30",
                                  "Greenland":"+299",
                                  "Grenada":"+1-473",
                                  "Guadeloupe":"+590",
                                  "Guam":"+1-671",
                                  "Guatemala":"+502",
                                  "Guinea (Former French Guinea)":"+224",
                                  "Guinea-Bissau (Former Portuguese Guinea)":"+245",
                                  "Guyana (Former British Guiana)":"+592",
                                  
                                  "Haiti":"+509",
                                  "Honduras": "+504",
                                  "Hong Kong":"+852",
                                  "Hungary":"+36",
                                  
                                  "Iceland":"+354",
                                  "India":"+91",
                                  "Indonesia (Former Netherlands East Indies; Dutch East Indies)":"+62",
                                  "Iran, Islamic Republic of":"+98",
                                  "Iraq":"+964",
                                  "Ireland":"+353",
                                  "Israel":"+972",
                                  "Italy":"+39",
                                  "Jamaica":"+1-876",
                                  "Japan":"+81",
                                  "Jordan (Former Transjordan)":"+962",
                                  
                                  "Kazakstan or Kazakhstan (Former Kazakh Soviet Socialist Republic)":"+7",
                                  "Kenya (Former British East Africa)":"+254",
                                  "Kiribati (Pronounced keer-ree-bahss) (Former Gilbert Islands)":"+686",
                                  "Korea, Democratic People's Republic of (North Korea)":"+850",
                                  "Korea, Republic of (South Korea)":"+82",
                                  "Kuwait":"+965",
                                  "Kyrgyzstan (Kyrgyz Republic) (Former Kirghiz Soviet Socialist Republic)":"+996",
                                  "Lao People's Democratic Republic (Laos)":"+856",
                                  "Latvia (Former Latvian Soviet Socialist Republic)":"+371",
                                  "Lebanon":"+961",
                                  "Lesotho (Former Basutoland)":"+266",
                                  "Liberia":"+231",
                                  "Libya (Libyan Arab Jamahiriya)":"+218",
                                  "Liechtenstein":"+423",
                                  "Lithuania (Former Lithuanian Soviet Socialist Republic)":"+370",
                                  "Luxembourg":"+352",
                                  
                                  "Macau":"+853",
                                  "Macedonia, The Former Yugoslav Republic of":"+389",
                                  "Madagascar (Former Malagasy Republic)":"+261",
                                  "Malawi (Former British Central African Protectorate, Nyasaland)":"+265",
                                  "Malaysia":"+60",
                                  "Maldives":"+960",
                                  "Mali (Former French Sudan and Sudanese Republic)":"+223",
                                  "Malta":"+356",
                                  "Marshall Islands (Former Marshall Islands District - Trust Territory of the Pacific Islands)":	"+692",
                                  "Martinique (French)":"+596",
                                  "Mauritania":"+222",
                                  "Mauritius":"+230",
                                  "Mayotte (Territorial Collectivity of Mayotte)":"+269",
                                  "Mexico":"+52",
                                  "Micronesia, Federated States of (Former Ponape, Truk, and Yap Districts - Trust Territory of the Pacific Islands)":"+691",
                                  "Moldova, Republic of":"+373",
                                  "Monaco, Principality of":"+377",
                                  "Mongolia (Former Outer Mongolia)":"+976",
                                  "Montserrat":"+1-664",
                                  "Morocco":"+212",
                                  "Mozambique (Former Portuguese East Africa)":"+258",
                                  "Myanmar, Union of (Former Burma)":"+95",
                                  
                                  "Namibia (Former German Southwest Africa, South-West Africa)":"+264",
                                  "Nauru (Former Pleasant Island)":"+674",
                                  "Nepal":"+977",
                                  "Netherlands":"+31",
                                  "Netherlands Antilles (Former Curacao and Dependencies)":"+599",
                                  "New Caledonia":"+687",
                                  "New Zealand (Aotearoa)":"+64",
                                  "Nicaragua":"+505",
                                  "Niger":"+227",
                                  "Nigeria":"+234",
                                  "Niue (Former Savage Island)":"+683",
                                  "Norfolk Island":"+672",
                                  "Northern Mariana Islands (Former Mariana Islands District - Trust Territory of the Pacific Islands)":"+1-670",
                                  "Norway":"+47",
                                  
                                  "Oman, Sultanate of (Former Muscat and Oman)":"+968",
                                  
                                  "Pakistan (Former West Pakistan)":	"+92",
                                  "Palau (Former Palau District - Trust Terriroty of the Pacific Islands)":	"+680",
                                  "Palestinian State (Proposed)":"+970",
                                  "Panama":"+507",
                                  "Papua New Guinea (Former Territory of Papua and New Guinea)":"+675",
                                  "Paraguay":"+595",
                                  "Peru":"+51",
                                  "Philippines":"+63",
                                  "Poland":"+48",
                                  "Portugal":"+351",
                                  "Puerto Rico":"+1-787",
                                  "Qatar, State of":"+974",
                                  
                                  "Reunion (French) (Former Bourbon Island)":"+262",
                                  "Romania":"+40",
                                  "Russian Federation":"+7",
                                  "Rwanda (Rwandese Republic) (Former Ruanda)":"+250",
                                  
                                  "Saint Helena":"+290",
                                  "Saint Kitts and Nevis (Former Federation of Saint Christopher and Nevis)":"+1-869",
                                  "Saint Lucia":"+1-758",
                                  "Saint Pierre and Miquelon":"+508",
                                  "Saint Vincent and the Grenadines":"+1-784",
                                  "Samoa (Former Western Samoa)":"+685",
                                  "San Marino":"+378",
                                  "Sao Tome and Principe":"+239",
                                  "Saudi Arabia":"+966",
                                  "Senegal":"+221",
                                  "Seychelles":"+248",
                                  "Sierra Leone":"+232",
                                  "Singapore":"+65",
                                  "Slovakia":"+421",
                                  "Slovenia":"+386",
                                  "Solomon Islands (Former British Solomon Islands)":"+677",
                                  "Somalia (Former Somali Republic, Somali Democratic Republic)":"+252",
                                  "South Africa (Former Union of South Africa)":"+27",
                                  "Spain":"+34",
                                  "Sri Lanka (Former Serendib, Ceylon)":"+94",
                                  "Sudan (Former Anglo-Egyptian Sudan)":"+249",
                                  "Suriname (Former Netherlands Guiana, Dutch Guiana)":"+597",
                                  "Swaziland, Kingdom of":"+268",
                                  "Sweden":"+46",
                                  "Switzerland":"+41",
                                  "Syria (Syrian Arab Republic) (Former United Arab Republic - with Egypt)":"+963",
                                  
                                  "Taiwan (Former Formosa)":"+886",
                                  "Tajikistan (Former Tajik Soviet Socialist Republic)":"+992",
                                  "Tanzania, United Republic of (Former United Republic of Tanganyika and Zanzibar)":"+255",
                                  "Thailand (Former Siam)":"+66",
                                  "Tokelau":"+690",
                                  "Tonga, Kingdom of (Former Friendly Islands)":"+676",
                                  "Trinidad and Tobago":"+1-868",
                                  "Tunisia":"+216",
                                  "Turkey":"+90",
                                  "Turkmenistan (Former Turkmen Soviet Socialist Republic)":"+993",
                                  "Turks and Caicos Islands":"+1-649",
                                  "Tuvalu (Former Ellice Islands)":"+688",
                                  
                                  "Uganda, Republic of":"+256",
                                  "Ukraine (Former Ukrainian National Republic, Ukrainian State, Ukrainian Soviet Socialist Republic)":"+380",
                                  "United Arab Emirates (UAE) (Former Trucial Oman, Trucial States)":"+971",
                                  "United Kingdom (Great Britain / UK)":"+44",
                                  "United States":"+1",
                                  "Uruguay, Oriental Republic of (Former Banda Oriental, Cisplatine Province)":"+598",
                                  "Uzbekistan (Former UZbek Soviet Socialist Republic)":"+998",
                                  
                                  "Vanuatu (Former New Hebrides)":"+678",
                                  "Vatican City State (Holy See)":"+418",
                                  "Venezuela":"+58",
                                  "Vietnam":"+84",
                                  "Virgin Islands, British":"+1-284",
                                  "Virgin Islands, United States (Former Danish West Indies)":"+1-340",
                                  
                                  "Wallis and Futuna Islands":"+681",
                                  "Yemen":"+967",
                                  "Zambia, Republic of (Former Northern Rhodesia)":"+260",
                                  "Zimbabwe, Republic of (Former Southern Rhodesia, Rhodesia)":"+263"]
    
    
    
    
    var CodePicker = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign Up"
        iconClick = true
        CodePicker.dataSource = self
        CodePicker.delegate = self
        CountryCode.inputView =  CodePicker
        
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        if (password.text?.isEmpty)! || (confirmPassword.text?.isEmpty)! && (email.text?.isEmpty)! && (Name.text?.isEmpty)!{
            
            let alert = UIAlertController(title: "Plese Enter all Detail", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
            {
                _ in
                
                }
            )
            self.present(alert, animated: true, completion: nil)
            
            
            
            
            
            
            
        }
        else if !isValidEmail(testStr: email.text!){
            let alert = UIAlertController(title: "Validate Your Email", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
            {
                _ in
                
                }
            )
            self.present(alert, animated: true, completion: nil)
            
        }
        else if password.text! != confirmPassword.text{
            let alert = UIAlertController(title: "Password Mismatch", message: "Confirm Password", preferredStyle: UIAlertControllerStyle.alert)
            
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
            {
                _ in
                
                }
            )
            self.present(alert, animated: true, completion: nil)
            
        
            
            
        }else{
            
        
        if Int(email.text!)==nil{
            self.Activity.startAnimating()
            self.view.isUserInteractionEnabled = false
            Auth.auth().createUser(withEmail: self.email.text!, password: self.password.text!) { (user, error) in
                self.Activity.stopAnimating()
                self.view.isUserInteractionEnabled = true
                
                if let error = error {
                    print(error.localizedDescription)
                    let alert = UIAlertController(title: "Account Alredy Exist", message: "Please Enter Valid Email id", preferredStyle: UIAlertControllerStyle.alert)
                    
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
                    {
                        _ in
                        
                    }
                    )
                    self.present(alert, animated: true, completion: nil)
                    
                    
                }
                else if let user = user {
                    print(user)
                    self.Activity.startAnimating()
                    self.view.isUserInteractionEnabled = false
                    
                    Auth.auth().currentUser!.sendEmailVerification(completion: { (error) in
                        self.Activity.stopAnimating()
                        self.view.isUserInteractionEnabled = true
                        
                    })
                    print("This email and user is created")
                    let alert = UIAlertController(title: "Account Created", message: "Please verify your email by confirming the sent link.", preferredStyle: UIAlertControllerStyle.alert)
                    
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
                        {
                        _ in
                        let ok = self.storyboard?.instantiateViewController(withIdentifier: "View") as! ViewController
                        self.navigationController?.pushViewController(ok, animated: false)
                        
                        
                        }
                    )
                    self.present(alert, animated: true, completion: nil)
                    
                    
                    
                }
            }
        }
        else{
            
            
            
            
            
                self.Activity.startAnimating()
            PhoneAuthProvider.provider().verifyPhoneNumber("+91"+email.text!) {(verificationID, error) in
                self.Activity.stopAnimating()
                if error != nil{
                    print("error:\(String(describing: error?.localizedDescription))")
                    print(self.mobileNumber.text!)
                    
                }
                else{
                    let defaults = UserDefaults.standard
                    defaults.set(verificationID, forKey: "authVID")
                    print(self.mobileNumber.text!)
                    
                    
                    let sign = self.storyboard?.instantiateViewController(withIdentifier: "OTP") as! OTPViewController
                    sign.mobilenumber = self.CountryCode.text! + self.mobileNumber.text! 
                    self.navigationController?.pushViewController(sign, animated: true)
                    
                    print(self.mobileNumber.text!)
                    
                    
                    
                }
                
            }
        }
 
        
    }
        
        
        
        
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return Country.allKeys.count
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        sortedArray = NSArray.init(array:self.Country.allKeys.sorted{ ($0 as AnyObject).localizedCaseInsensitiveCompare($1 as! String) == ComparisonResult.orderedAscending})
        return (sortedArray[row] as! String )
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        for i in 0..<Country.allKeys.count {
            if Country.allKeys[i] as! String == (sortedArray[row] as! String )
            {
                CountryCode.text = (Country.allValues[i] as! String )
            }
        }
        
        
        
    }
    @IBOutlet var visible: UIButton!
    @IBAction func visibleBtn(_ sender: Any) {
        
        
        if(iconClick == true) {
            password.isSecureTextEntry = false
            iconClick = false
            visible.isSelected = true
            
            
            
        } else {
            password.isSecureTextEntry = true
            iconClick = true
            visible.isSelected = false
            
        }
        
    }
    
    @IBOutlet var visible2: UIButton!
    @IBAction func visibleBtn2(_ sender: UIButton) {
        
        if(iconClick == true) {
            confirmPassword.isSecureTextEntry = false
            iconClick = false
            visible2.isSelected = true
            
            
            
        } else {
            confirmPassword.isSecureTextEntry = true
            iconClick = true
            visible2.isSelected = false
            
        }

        
        
        
        
        
        
        
        
        
        
    }
    

    
    func ok()
    {
        let ok = self.storyboard?.instantiateViewController(withIdentifier: "View") as! ViewController
        self.navigationController?.pushViewController(ok, animated: true)
        
        
    }
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    
    
    
    
    
    
}





