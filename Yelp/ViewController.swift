//
//  ViewController.swift
//  Yelp
//
//  Created by Matthew Carroll on 4/23/15.
//  Copyright (c) 2015 blarg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var businesses: [Business]!
    
    var client: YelpClient!
    
    var searchBar: UISearchBar!
    
    var filterConfiguration: FilterConfiguration = FilterConfiguration.defaultConfiguration()
    
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
        
        if let nc = navigationController {
            nc.navigationBar.barTintColor = UIColor(red:0.82, green:0.09, blue:0.02, alpha:1)
            nc.navigationBar.tintColor = UIColor.whiteColor()
        } else {
            println("no navigation controller?")
        }

        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // This is in walkthrough, is this necessary?
        // tableView.registerNib(UINib(nibName: "BusinessCell", bundle: nil), forCellReuseIdentifier: "BusinessCell")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.title = "Yelp"
        
        searchBar = UISearchBar()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        searchYelp()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchYelp()
    }
    
    private func searchYelp() {
        client.searchWithTerm(searchBar.text, filterConfiguration: filterConfiguration, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            if let businessesInfo = response["businesses"] as? [NSDictionary] {
                self.businesses = businessesInfo.map({ (dict) in
                    Business(fromBusinessInfoDict: dict)
                })
                
                let businessNames = self.businesses.map({ (business) in
                    business.name
                })
                println("\(businessNames.count) businesses found from API: \(businessNames)")
                
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
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell") as BusinessCell
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
    
    func filtersViewController(filtersViewController: UIViewController, filtersDidChange newConfiguration: FilterConfiguration) {
        filterConfiguration = newConfiguration
        searchYelp()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // XXX: Weird stuff to get through the segue which goes from ViewController to a UINavigationController, to a FiltersViewController
        let nc = segue.destinationViewController as UINavigationController
        if let fvc = nc.topViewController as? FiltersViewController {
            fvc.delegate = self
            fvc.ownFilterConfiguration = filterConfiguration
        }
    }
    
    // Hack from Sommer:
    // This is doing what autolayout *should* be doing which using the constraints to determine cell
    // height as needed. Currently, even with correctly setting prefferedMaxLayoutWidth on
    // labels within cells, heights calculated correctly at all times.
    // If you use this you MUST call dequeueReusableCellWithIdentifier, NOT
    // dequeueReusableCellWithIdentifier:atIndexPath in your cellForRow:atIndexPath method.
    // Otherwise you will crash. Again - this is a HACK and not good iOS dev.
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let contentView: UIView = tableView.dataSource!.tableView(tableView, cellForRowAtIndexPath: indexPath)
        contentView.updateConstraintsIfNeeded()
        contentView.layoutIfNeeded()
        return contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
    }

}

