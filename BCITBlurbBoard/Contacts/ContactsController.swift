
//
//  ContactsController.swift
//  BCITBlurbBoard
//
//  Created by alan on 2/4/15.
//  Copyright (c) 2015 Ben Soer. All rights reserved.
//


import UIKit
import Alamofire



class ContactsController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    let appData = GlobalAppData.getGlobalAppData();
    
    @IBOutlet var searchBar: UISearchBar!
    let baseUrl:String = "http://api.thunderchicken.ca/api";
    @IBOutlet var tableView: UITableView!

    @IBAction func btnBack(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
        var tableData: [JSON] = []
    
    var tableViewController = UITableViewController (style: .Plain)
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let token:String! = appData.getUserToken();
        let userId:String! = appData.getUserId()
       
       //var tableView = tableViewController.tableView;
        
       self.tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
          self.view.addSubview(tableView)
      
        
        Alamofire.request(.GET,"http://api.thunderchicken.ca/api/contacts/" + userId + "/" + token)
            .responseJSON { (_,_, json, _) in
        
                // comment above line and uncomment following for testing
//       Alamofire.request(.GET, "http://api.thunderchicken.ca/api/contacts/A00843110/" + token).responseJSON { (request, response, json, error) in
            println(json)
            if json != nil {
                var jsonObj = JSON(json!)
                
                if let data = jsonObj["data"]["contacts"].arrayValue as [JSON]?{
                   
                    self.tableData = data
                     self.tableView.reloadData();
                    
                }
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be ecreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        let data = self.tableData[indexPath.row]
        cell.textLabel?.text = data["name"].string
        
        
       
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         let data = self.tableData[indexPath.row]
        
        var storyboard = UIStoryboard(name : "SingleContactStoryboard", bundle: nil);
        var controller = storyboard.instantiateViewControllerWithIdentifier("singlecontact") as UIViewController;
        let dstController = controller as SingleContactController;
         dstController.lblContactId = data["userid"].string!
         //println(data["name"].string!)
       self.presentViewController(controller, animated: true, completion: nil);
    }
    

    
}
