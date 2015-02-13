//
//  NewsfeedController.swift
//  BCITBlurbBoard
//
//  Created by alan on 2/4/15.
//  Copyright (c) 2015 Ben Soer. All rights reserved.
//

import UIKit
class NewsfeedController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnLogoutPressed(sender: UIButton)
    {
        // Do logout things 
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil);
    }
    @IBAction func btnContactsPressed(sender: UIButton)
    {
        var storyboard = UIStoryboard(name : "ContactsStoryboard", bundle: nil);
        var controller = storyboard.instantiateViewControllerWithIdentifier("contacts") as UIViewController;
        let dstController = controller as ContactsController;
        self.presentViewController(controller, animated: true, completion: nil);
    }
    @IBAction func btnMyCoursesPressed(sender: UIButton) {
        var storyboard = UIStoryboard(name : "MyCoursesStoryboard", bundle: nil);
        var controller = storyboard.instantiateViewControllerWithIdentifier("mycourses") as UIViewController;
        let dstController = controller as MyCoursesController;
        self.presentViewController(controller, animated: true, completion: nil);
    }
}