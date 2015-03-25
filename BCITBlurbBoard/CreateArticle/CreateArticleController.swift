//
//  CreateArticleController.swift
//  BCITBlurbBoard
//
//  Created by Ryan Sadio on 2015-03-10.
//  Copyright (c) 2015 Ben Soer. All rights reserved.
//

import UIKit
import AlamoFire

class CreateArticleController : UIViewController
{
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var toField: UITextField!
    @IBOutlet weak var expiryField: UITextField!
    @IBOutlet weak var criticalSwitch: UISwitch!
    @IBOutlet weak var contentField: UITextView!
    
    let baseUrl:String = "http://api.thunderchicken.ca/api";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // Date picker for Expiry date
    @IBAction func dp(sender: UITextField) {
        
    }
    
    // User press the done button
    @IBAction func doneWasPressed(sender: AnyObject) {
        [self .sendArticleEntry()]
        [self .dismissSelf()]
    }
    
    // User press the cancel button
    @IBAction func cancelWasPressed(sender: AnyObject) {
        [self .dismissSelf()]
    }
    
    func updateExpiryField() {
        
    }
    
    // Send entry to API
    func sendArticleEntry() {
        let programid = "test";
        let title = titleField.text!;
        let to = toField.text!;
        let expiry = expiryField.text!;
        let critical = criticalSwitch.on ? "critical" : "standard";
        let content = contentField.text!;
        
        //server call
        var articleInfo:[String:AnyObject] = [
            "programid": programid,
            "coursesectionid": to,
            "title" : title,
            "content" : content,
            "priority" : critical,
            "expirydate" : expiry,]
        let route = baseUrl + "/api/newsfeed/:userid/article/:token";
        
        
        Alamofire.request(.POST, route, parameters: articleInfo, encoding: .JSON)
            .responseJSON{ (_, _, data, _) in
                
                println("Response Arrived!");
                
                //parse with SwiftlyJSON (located in /Common)
                let json = JSON(data!);
                
                if var statuscode = json["statuscode"].int {
                    if (statuscode == 201){
                        // success
                        println("success!")
                    }
                    else { //403
                        if var logMessage = json["message"].string{
                            let message:String = "\(statuscode) : \(logMessage)";
                            println(message);
                            return;
                        }
                    }
                }
        }
    }
    
    // Dismiss view
    func dismissSelf() {
        [self .dismissViewControllerAnimated(true, completion: nil)]
    }
    
}