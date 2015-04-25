//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Matthew Carroll on 4/24/15.
//  Copyright (c) 2015 blarg. All rights reserved.
//

import UIKit

protocol FiltersViewControllerDelegate: class {
    // XXX: Why can't (shouldn't?) I use FiltersViewController as the type of the first argument below?
    // XXX: Understand this function declaration syntax. That 'filtersDidChange' seems to be an argument
    // name for the caller, but not for the callee (for the callee it's filtersDict)
    func filtersViewController(filtersViewController: UIViewController, filtersDidChange filtersDict: [Int: Bool])
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: FiltersViewControllerDelegate?

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onApply(sender: AnyObject) {
        if let delegate = delegate {
            delegate.filtersViewController(self, filtersDidChange: [Int : Bool]())
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FilterCell", forIndexPath: indexPath) as FilterCell
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
        
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
