//
//  LoginViewController.swift
//  BCITBlurbBoard
//
//  Created by Gary K on 2015-01-27.
//  Copyright (c) 2015 Ben Soer. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{
   
    
    
       @IBOutlet weak var txtPassword: UITextField!
    
        @IBOutlet weak var lblMessage: UILabel!
       @IBOutlet weak var txtUsername: UITextField!
        override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
    
  
  @IBAction func btnLogin(sender: AnyObject) {
        
        
        let user = "test";
        let pwd  = "test";
        
        if txtUsername.text == user &&
            txtPassword.text == pwd
        {
            lblMessage.text = "you logged in sssuccessfully "
              //lblMessage.textColor = UIColor.blueColor();
            
            let view2 = self.storyboard?.instantiateViewControllerWithIdentifier("home")as HomeController;
            self.navigationController?.pushViewController(view2, animated: true)
        
            //txtUsername.resignFirstResponder();
            //txtPassword.resignFirstResponder();
           
        }
        else
        {
            lblMessage.text = "Username or password is wrong"
            lblMessage.textColor = UIColor.redColor();
            //println("failed");
            txtUsername.resignFirstResponder();
            txtPassword.resignFirstResponder();
            
        }
        
        
        
    }

    

   
}
