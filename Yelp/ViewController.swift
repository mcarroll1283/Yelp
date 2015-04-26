//
//  ViewController.swift
//  Yelp
//
//  Created by Matthew Carroll on 4/23/15.
//  Copyright (c) 2015 blarg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var businesses: [Business]!
    
    var client: YelpClient!
    
    var searchBar: UISearchBar!
    
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    let yelpConsumerKey = "6JNzXvGKzzb8VKOaR-TfYQ"
    let yelpConsumerSecret = "evystiqHI1q2JywYEFxtwuJEnvE"
    let yelpToken = "YeLAcsCms6jZGfqLEofLqBQo_EyFoJVD"
    let yelpTokenSecret = "iWX3Y-TOBBitvDm7FWg39Ikb08Q"
    
//    let yelpConsumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
//    let yelpConsumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
//    let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
//    let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        searchBar.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        searchYelp("Thai", categoryFilter: nil)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // This is in walkthrough, is this necessary?
        // tableView.registerNib(UINib(nibName: "BusinessCell", bundle: nil), forCellReuseIdentifier: "BusinessCell")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.title = "Yelp"
        
        searchBar = UISearchBar()
        navigationItem.titleView = searchBar
    }
    
    private func searchYelp(searchTerm: String, categoryFilter: [String]?) {
        client.searchWithTerm(searchTerm, categoryFilter: categoryFilter, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            if let businessesInfo = response["businesses"] as? [NSDictionary] {
                self.businesses = businessesInfo.map({ (dict) in
                    Business(fromBusinessInfoDict: dict)
                })
                
                self.tableView.reloadData()
            }
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as BusinessCell
        cell.business = businesses[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let businesses = self.businesses {
            return businesses.count
        } else {
            return 0
        }
    }
    
    func filtersViewController(filtersViewController: UIViewController, filtersDidChange categoryFilter: [String]) {
        searchYelp("Thai", categoryFilter: categoryFilter)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // XXX: Weird stuff to get through the segue which goes from ViewController to a UINavigationController, to a FiltersViewController
        let nc = segue.destinationViewController as UINavigationController
        if let fvc = nc.topViewController as? FiltersViewController {
            fvc.delegate = self
        }
    }

}

