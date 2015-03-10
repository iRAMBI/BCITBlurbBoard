//
//  ContactsController.swift
//  BCITBlurbBoard
//
//  Created by alan on 2/4/15.
//  Copyright (c) 2015 Ben Soer. All rights reserved.
//


import UIKit


class ContactsController: UIViewController , UITableViewDataSource, UITableViewDelegate {

    @IBAction func btnBack(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    let cellIdentifier = "cell";
    let animal = ["cat","dog"];
    var tableData:Array< String > = Array < String >()
    var tableViewController = UITableViewController (style: .Plain)
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
         get_data_from_url("http://www.ikhangura.com/service.php")
        tableData = animal
        // Do any additional setup after loading the view, typically from a nib.
        var tableView = tableViewController.tableView;
       tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
       self.view.addSubview(tableView)
        
        // "/api/contacts/:bsoer@my.bcit/:XAkyHqdz3Sw7qNTdfXKIS3ecn8X"
        
       
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
        cell.textLabel?.text = self.tableData[indexPath.row]
        
        return cell
    }
   
    
    func get_data_from_url(url:String)
    {
        let httpMethod = "GET"
        let timeout = 15
        let url = NSURL(string: url)
        let urlRequest = NSMutableURLRequest(URL: url!,
            cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 15.0)
        let queue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(
            urlRequest,
            queue: queue,
            completionHandler: {(response: NSURLResponse!,
                data: NSData!,
                error: NSError!) in
                if data.length > 0 && error == nil{
                    let json = NSString(data: data, encoding: NSASCIIStringEncoding)
                    self.extract_json(json!)
                }else if data.length == 0 && error == nil{
                    println("Nothing was downloaded")
                } else if error != nil{
                    println("Error happened = \(error)")
                }
            }
        )
    }
    
    func extract_json(data:NSString)
    {
        var parseError: NSError?
        let jsonData:NSData = data.dataUsingEncoding(NSASCIIStringEncoding)!
        let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &parseError)
        if (parseError == nil)
        {
            if let info_list = json as? NSArray
            {
                for (var i = 0; i < info_list.count ; i++ )
                {
                    if let info_obj = info_list[i] as? NSDictionary
                    {
                        if let info_name = info_obj["facultyid"] as? String
                        {
                            if let info_code = info_obj["userid"] as? String
                            {
                                tableData.append(info_name + " [" + info_code + "]")
                            }
                        }
                    }
                }
            }
        }
       
    
    }

}

 
