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

class FiltersViewController: UIViewController {
    
    weak var delegate: FiltersViewControllerDelegate?

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
        println("filters view controller viewDidLoad")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
