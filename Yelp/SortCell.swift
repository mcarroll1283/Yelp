//
//  SortCell.swift
//  Yelp
//
//  Created by Matthew Carroll on 4/26/15.
//  Copyright (c) 2015 blarg. All rights reserved.
//

import UIKit

let sortOptionsByIndex = [SortOption.Distance, SortOption.Rating]
let indexesBySortOption = [SortOption.Distance: 0, SortOption.Rating: 1]

protocol SortCellDelegate: class {
    func sortCell(sortCell: SortCell, sortChanged newSortValue: SortOption)
}

class SortCell: UITableViewCell {

    @IBOutlet weak var sortControl: UISegmentedControl!
    
    weak var delegate: SortCellDelegate?
    
    var sortOption: SortOption?
    
    @IBAction func onSortChanges(sender: AnyObject) {
        println("sort changed: \(sortControl.selectedSegmentIndex)")
        if let delegate = delegate {
            delegate.sortCell(self, sortChanged: sortOptionsByIndex[sortControl.selectedSegmentIndex])
        } else {
            println("SortCell: no delegate in onSortChanges")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        if let sortOption = sortOption {
            sortControl.selectedSegmentIndex = indexesBySortOption[sortOption]!
        } else {
            println("SortCell: No sortOption in awakeFromNib")
            sortControl.selectedSegmentIndex = indexesBySortOption[SortOption.Rating]!
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
