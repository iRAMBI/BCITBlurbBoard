//
//  NewsfeedController.swift
//  BCITBlurbBoard
//
//  Created by alan on 2/4/15.
//  Copyright (c) 2015 Ben Soer. All rights reserved.
//

import UIKit
class NewsfeedController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
        
    @IBOutlet var tableView: UITableView!
    
    let newsItem1 : [String] = ["Woop woop!", "This is a summary of everything that might be in this post. How exciting!",
        "Posted February 16, 2015", "D'Arcy Smith, Faculty of Computing", "12"]
    let newsItem2 : [String] = ["Hubba Bubba: Old News or Retro Cool?", "Gum is making a comeback according to a crack team of researchers at BCIT's Burnaby, BC, Canada campus.","Posted February 16, 2015", "Matthew Banman, CST", "3"]
    //let items: [[String]] = [self.newsItem1 , self.newsItem2]
    
    let items: [[String]] = [
        ["Woop woop!", "This is a summary of everything that might be in this post. How exciting!",
        "Posted February 16, 2015", "D'Arcy Smith, Faculty of Computing", "12"],
        ["Hubba Bubba: Old News or Retro Cool?", "Gum is making a comeback according to a crack team of researchers at BCIT's Burnaby, BC, Canada campus.","Posted February 16, 2015", "Matthew Banman, CST", "3"]]
    
    // table view methods
    /*
    override func numberOfSections() -> Int
    {
        return 1
    }
     */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int ) -> Int
    {
        return self.items.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : NewsItemCell!         = tableView.dequeueReusableCellWithIdentifier("newsItemCell") as NewsItemCell
        cell.CellTitle.text              = items[indexPath.row][0]
        cell.MessagePreview.text         = items[indexPath.row][1]
        cell.Date.text                   = items[indexPath.row][2]
        cell.Author.text                 = items[indexPath.row][3]
        cell.CommentNum.text             = items[indexPath.row][4]
           
        return cell
    }
    
    func tableView(tableView : UITableView, didSelectRowAtIndexPath indexPath : NSIndexPath)
    {
        // do some stuff here
    }
    
    // end table view methods
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "newsItemCell");
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