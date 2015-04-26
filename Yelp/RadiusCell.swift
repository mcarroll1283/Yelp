//
//  RadiusCell.swift
//  Yelp
//
//  Created by Matthew Carroll on 4/26/15.
//  Copyright (c) 2015 blarg. All rights reserved.
//

import UIKit

let radiusOptionsByIndex = [RadiusOption.Any, RadiusOption.ThousandMeters, RadiusOption.FiveHundredMeters]
let indexesByRadiusOption = [RadiusOption.Any: 0, RadiusOption.ThousandMeters: 1, RadiusOption.FiveHundredMeters: 2]

protocol RadiusCellDelegate: class {
    func radiusCell(radiusCell: RadiusCell, radiusChanged newRadiusValue: RadiusOption)
}

class RadiusCell: UITableViewCell {
    
    weak var delegate: RadiusCellDelegate?

    @IBOutlet weak var radiusControl: UISegmentedControl!
    
    var radiusOption: RadiusOption? {
        didSet {
            radiusControl.selectedSegmentIndex = indexesByRadiusOption[radiusOption!]!
        }
    }
    
    @IBAction func onRadiusChanged(sender: AnyObject) {
        if let delegate = delegate {
            delegate.radiusCell(self, radiusChanged: radiusOptionsByIndex[radiusControl.selectedSegmentIndex])
        } else {
            println("RadiusCell: No delegate in onRadiusChanged")
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
