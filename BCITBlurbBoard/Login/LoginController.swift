//
//  ViewController.swift
//  BCITBlurbBoard
//
//  Created by Ben Soer on 2015-01-07.
//  Copyright (c) 2015 Ben Soer. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    // get instance of HTTPClient
    let httpClient = HTTPClient.sharedInstance;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func LoginUser(sender: UIButton) {
        println( "User logging in!" )
        
        //TODO : Add actual verification for user auth  
        
        // test the login route!
        /*
        var loginInfo = ["username":"bsoer@my.bcit.ca", "password":"password"]
        httpClient.TestPost("http://api.thunderchicken.ca:8080/api/auth", data : loginInfo);
        */
        
        // test newsfeed route
        var getResult : NSDictionary? = httpClient.Get("http://api.thunderchicken.ca:8080/api/newsfeed/A00843110/standard/QLTw7tisv8O7ipX6B7Tdxnzv6")
        
        println( getResult )
        
        let auth = true;
        if (auth)
        {
            // Set user data, such as usertoken
            // Send device token back to server
            
            // Send to Newsfeed page
            var storyboard = UIStoryboard(name : "NewsfeedStoryboard", bundle: nil);
            var controller = storyboard.instantiateViewControllerWithIdentifier("newsfeed") as UIViewController;
            let dstController = controller as NewsfeedController;
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }

}

