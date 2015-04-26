//
//  SortCell.swift
//  Yelp
//
//  Created by Matthew Carroll on 4/26/15.
//  Copyright (c) 2015 blarg. All rights reserved.
//

import UIKit

let sortValueStrings = ["distance", "rating"]

protocol SortCellDelegate: class {
    func sortCell(sortCell: SortCell, sortChanged newSortValue: String)
}

class SortCell: UITableViewCell {

    @IBOutlet weak var sortControl: UISegmentedControl!
    
    weak var delegate: SortCellDelegate?
    
    @IBAction func onSortChanges(sender: AnyObject) {
        println("sort changed: \(sortControl.selectedSegmentIndex)")
        if let delegate = delegate {
            delegate.sortCell(self, sortChanged: sortValueStrings[sortControl.selectedSegmentIndex])
        } else {
            println("SortCell: no delegate in onSortChanges")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
