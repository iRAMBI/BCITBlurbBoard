//
//  SingleContactController.swift
//  BCITBlurbBoard
//
//  Created by alan on 2/4/15.
//  Copyright (c) 2015 Ben Soer. All rights reserved.
//

import UIKit
import Alamofire
class SingleContactController : UIViewController
{
    

    private struct ContactsDetails
    {
        var id : String;
        var officelocation : String;
        var phone : String;
       
        var name : String;
        var email : String;
         var position : String;
        var monHrs : String;
        var tueHrs : String;
        var wedHrs : String;
        var thurHrs : String;
        var friHrs : String;
        var dept : String;
        
    }

    @IBOutlet var lblEmail: UILabel!
let appData = GlobalAppData.getGlobalAppData()
@IBOutlet var lblTest: UILabel!
 private var contactDetails : ContactsDetails?;
var lblContactId = String();

    
    @IBOutlet var lblDept: UILabel!
    
    @IBOutlet var lblMonHrs: UILabel!
   
    @IBOutlet var lblTueHrs: UILabel!
    
    
    @IBOutlet var lblWedHrs: UILabel!
    
    @IBOutlet var lblThurHrs: UILabel!
    
    
    @IBOutlet var lblFriHrs: UILabel!
    
    @IBOutlet var lblPosition: UILabel!
    @IBOutlet var lblPhone: UILabel!
    
    @IBOutlet var lblLocation: UILabel!
override func viewDidLoad() {
        super.viewDidLoad()
         let token:String! = appData.getUserToken();
        let userId:String! = appData.getUserId()
       println("see contact details for selected id :\(lblContactId)")
    
     // display for student contact
     lblTest.text = "Unavailable"
     lblPosition.text = "Unavailable"
     lblLocation.text = "Unavailable"
     lblPhone.text = "Unavailable"
     lblEmail.text = "Unavailable"
     lblMonHrs.text = "Unavailable"
     lblTueHrs.text = "Unavailable"
     lblWedHrs.text = "Unavailable"
     lblThurHrs.text = "Unavailable"
     lblFriHrs.text = "Unavailable"
     lblDept.text = "Unavailable"
    
 Alamofire.request(.GET, "http://api.thunderchicken.ca/api/contacts/" + userId + "/single/" + lblContactId + "/"  + token)
            .responseJSON { (_,_, jsonobj, _) in
                println(jsonobj)
                var json = JSON(jsonobj!)
                if var statuscode = json["statuscode"].int
                {
                    if (statuscode == 200)
                    {
                        self.parseContactsDetails(json);
                        self.bindContactDataToView();
                        return;
                    }
                    else
                     {
                        if var logMessage = json["message"].string
                        {
                            let message:String = "\(statuscode) : \(logMessage)";
                            println(message);
                            return;
                     }
                  }
                }
                
                
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        
    }
    // parse all jason data into string format
private func parseContactsDetails(data : JSON)
    {
        let _id = data["data"]["userid"].stringValue;
        let _officelocation = data["data"]["officelocation"].stringValue;
        let _phone = data["data"]["phone"].stringValue;
        let _email = data["data"]["email"].stringValue;
        let _name = data["data"]["name"].stringValue;
        let _position = data["data"]["position"].stringValue;
        let _monhours = data["data"]["officehours"]["monday"].stringValue
        let _tuehours = data["data"]["officehours"]["tuesday"].stringValue
        let _wedhours = data["data"]["officehours"]["wednesday"].stringValue
        let _thurhours = data["data"]["officehours"]["thursday"].stringValue
        let _frihours = data["data"]["officehours"]["friday"].stringValue
        let _department = data["data"]["department"].stringValue
        self.contactDetails = ContactsDetails(id: _id,
            
            officelocation: _officelocation, phone:_phone, name: _name,email: _email, position:_position, monHrs:_monhours,tueHrs:_tuehours,wedHrs:_wedhours,thurHrs:_thurhours,friHrs:_frihours,dept:_department);
    }
    
    // bind data with Labels control for user

    func bindContactDataToView()
    {
         lblTest.text = contactDetails?.name
         lblEmail.text = contactDetails?.email
         lblLocation.text = contactDetails?.officelocation
         lblPhone.text = contactDetails?.phone
         lblPosition.text = contactDetails?.position
         lblMonHrs.text = contactDetails?.monHrs
         lblTueHrs.text = contactDetails?.tueHrs
         lblWedHrs.text = contactDetails?.wedHrs
         lblThurHrs.text = contactDetails?.thurHrs
         lblFriHrs.text = contactDetails?.friHrs
         lblDept.text = contactDetails?.dept
        
        // validate and format all field at runtime
        
        if(strlen(lblTest.text!) == 0)
        {
            lblTest.text = "Unavailable"
            
        }
        if(strlen(lblEmail.text!) == 0)
        {
            lblEmail.text = "Unavailable"
            
        }
        if(strlen(lblLocation.text!) == 0)
        {
            lblLocation.text = "Unavailable"
            
        }
        if(strlen(lblPhone.text!) == 0)
        {
            lblPhone.text = "Unavailable"
            
        }
        if(strlen(lblPosition.text!) == 0)
        {
            lblPosition.text = "Unavailable"
            
        }
        if(strlen(lblDept.text!) == 0)
        {
            lblDept.text = "Unavailable"
            
        }

        if(strlen(lblMonHrs.text!) == 0)
        {
            lblMonHrs.text = "Unavailable"
            
        }
        if(strlen(lblTueHrs.text!) == 0)
        {
            lblTueHrs.text = "Unavailable"
            
        }
        if(strlen(lblWedHrs.text!) == 0)
        {
            lblWedHrs.text = "Unavailable"
            
        }
        if(strlen(lblThurHrs.text!) == 0)
        {
            lblThurHrs.text = "Unavailable"
            
        }
        if(strlen(lblFriHrs.text!) == 0)
        {
            lblFriHrs.text = "Unavailable"
            
        }
        
    }

    

    @IBAction func backBtn(sender: UIBarButtonItem) {
         self.dismissViewControllerAnimated(true, completion: nil);
        
    }

    
}