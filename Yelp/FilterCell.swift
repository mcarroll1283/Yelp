//
//  FilterCell.swift
//  Yelp
//
//  Created by Matthew Carroll on 4/25/15.
//  Copyright (c) 2015 blarg. All rights reserved.
//

import UIKit

protocol FilterCellDelegate: class {
    func filterCell(filterCell: FilterCell, switchValueDidChange switchValue: Bool)
}

class FilterCell: UITableViewCell {
    
    weak var delegate: FilterCellDelegate?

    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    @IBAction func switchValueChanged(sender: AnyObject) {
        if let delegate = delegate {
            delegate.filterCell(self, switchValueDidChange: mySwitch.on)
        } else {
            println("Error: FilterCell didn't have delegate")
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
