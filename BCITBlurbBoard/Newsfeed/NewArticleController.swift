//
//  NewArticleController.swift
//  BCITBlurbBoard
//
//  Created by alan on 2/4/15.
//  Copyright (c) 2015 Ben Soer. All rights reserved.
//

import UIKit
import Alamofire

class NewArticleController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate {
    
    //Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var expiryLabel: UIPickerView!
    @IBOutlet weak var criticalLabel: UILabel!
    
    //Fields and buttons
    @IBOutlet var titleField: UITextField!
    @IBOutlet var criticalSwitch: UISwitch!
    @IBOutlet var expTextField: UITextField!
    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var receiverField: UITextField!
    @IBOutlet var contentField: UITextView!
    @IBOutlet var pickerToCat: UIPickerView!
    
    private let USERINFO = GlobalAppData.getGlobalAppData()
    private var popDatePicker:PopDatePicker?
    private var baseUrl:String!
    private var routeGetPostableContacts:String?
    private var routePostNewsArticle:String?
    private var userID:String?
    private var userToken:String?
    private var msSqlDate:String?
    private var currentCourseId:String?
    
    struct PostableContact {
        var usercoursesectionid:String = ""
        var usercoursesectionname:String = ""
    }
    
    private var postableContacts:[PostableContact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Data and API
        userID = USERINFO.getUserId()
        userToken = USERINFO.getUserToken()
        
        // base url of api server
        baseUrl = "http://api.thunderchicken.ca/api"
        
        // /api/contacts/:userid/postable/:token
        routeGetPostableContacts = baseUrl! + "/contacts/" + userID! + "/postable/" + userToken!
        
        // /api/newsfeed/:userid/article/:token
        routePostNewsArticle = baseUrl! + "/newsfeed/" + userID! + "/article/" + userToken!
        
        println("ID: " + userID! + " PW: " + userToken!)
        
        loadPostableContacts()
        
        println(postableContacts)
        
        // Itempicker
        pickerToCat.hidden = true
        receiverField.delegate = self
        pickerToCat.delegate = self
        
        // Datepicker
        popDatePicker = PopDatePicker(forTextField : expTextField)
        expTextField.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func enterTitle(sender: UITextField) {
        doneButton.enabled = (titleField.text != "" && receiverField.text != "" && contentField.text != "")
    }
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView:UIPickerView!) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int{
        return postableContacts.count
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        return postableContacts[row].usercoursesectionname
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
    {
        receiverField.text = postableContacts[row].usercoursesectionname
        currentCourseId = postableContacts[row].usercoursesectionid
        
        contentField.hidden = false
        pickerToCat.hidden = true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        //pickerToCat.hidden = true
    }
    
    // User selects the a text field
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if (textField === expTextField) {
            
            // dismiss keyboard
            resign()
            
            let formatter = NSDateFormatter()
            formatter.dateStyle = .MediumStyle
            formatter.timeStyle = .NoStyle
            
            let initDate = formatter.dateFromString(expTextField.text)
            
            popDatePicker!.pick(self, initDate:initDate, dataChanged: { (newDate : NSDate, forTextField : UITextField) -> () in
                
                // here we don't use self (no retain cycle)
                // newDate returns Dec 31, 9999, 11:59 PM if the user press "none"
                forTextField.text = newDate.ToDateMediumString() == "Dec 31, 9999, 11:59 PM" ? "none" : newDate.ToDateMediumString()
                
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" + ":00.000"
                
                // format date to be sent to api
                self.msSqlDate = dateFormatter.stringFromDate(newDate)
                
            })
            return false
            // popDatePicker
        }
        else if (textField === receiverField) {
            
            // dismiss keyboard
            resign()
            
            // show 'to' picker
            contentField.hidden = true
            pickerToCat.hidden = false
            
            println("Enter receivers.")
            doneButton.enabled = (titleField.text != "" && receiverField.text != "" && contentField.text != "")

            return false
        }
        else if (textField === contentField) {
            doneButton.enabled = (titleField.text != "" && receiverField.text != "" && contentField.text != "")
            return false
        }
        else {
            return true
        }
    }
    
    @IBAction func criticalSwitched(sender: UISwitch) {
        if (criticalSwitch.on) {
            //unhide expiry date fields
        } else {
            //hide expiry date fields

            // TODO: reset date
        }
    }
    
    
    // Post entry to API
    func sendForm()
    {
        let form:[String:AnyObject] = [
            "title": titleField.text,
            "coursesectionid": currentCourseId!,
            "expirydate": expTextField.text == "none" ? "9999-12-31 23:59:59.997" : msSqlDate!,
            "priority": criticalSwitch.on ? "Critical" : "Standard",
            "content": contentField.text,
        ]
        Alamofire.request(.POST, routePostNewsArticle!, parameters: form, encoding: .JSON)
        .responseJSON { (req, res, data, error) in
            println("Post Article Response!")
            
            //parse with SwiftlyJSON (located in /Common)
            let json = JSON(data!)
            println("Sending data... ")
            println(form)
            println(data)
            if var statuscode = json["statuscode"].int
            {
                if (statuscode == 201)
                {
                    // Data successfully received
                    println("Data sent!")
                    return
                }
                else
                {
                    if var logMessage = json["message"].string
                    {
                        let message:String = "\(statuscode) : \(logMessage)"
                        println(message)
                        return
                    }
                }
            }
        }
    }

    // Get Postable Contacts from API
    func loadPostableContacts() {
        Alamofire.request(.GET, routeGetPostableContacts!).responseJSON {
            (req, res, data, error) in
            
            println("Postable Contacts Response!")
            
            //parse with SwiftlyJSON (located in /Common)
            let json = JSON(data!)
            
            //print response
            println(data)
            if var statuscode = json["statuscode"].int
            {
                if (statuscode == 200)
                {
                    // Data successfully received
                    println("Reading data...")
                    self.parsePostableContacts(json["data"]["coursesections"].arrayValue)
                    println("Data read.")
                    self.pickerToCat.reloadAllComponents()
                    return
                }
                else
                {
                    if var logMessage = json["message"].string
                    {
                        let message:String = "\(statuscode) : \(logMessage)"
                        println(message)
                        return
                    }
                }
            }
        }
    }
    
    // Parse Postable Contacts from Get method
    private func parsePostableContacts (contactsArray:[JSON]) {
        println("contactsArray count: \(contactsArray.count)")
        for contact in contactsArray {
            let newContact = PostableContact(
                usercoursesectionid: contact["coursesectionid"].stringValue,
                usercoursesectionname: contact["coursename"].stringValue)
            println(contact)
            self.postableContacts.append(newContact)
        }
    }
    
    // Navigation buttons
    @IBAction func donePressed(sender: AnyObject) {
        // send form to API
        self.sendForm()
        self.dismissSelf()
    }
    
    @IBAction func cancelPressed(sender: AnyObject) {
        self.dismissSelf()
    }
    
    // Dismiss keyboard
    func resign() {
        titleField.resignFirstResponder()
        expTextField.resignFirstResponder()
    }
    
    // Dismiss view
    func dismissSelf() {
        [self.dismissViewControllerAnimated(true, completion: nil)]
    }
    
}