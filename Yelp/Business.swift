//
//  Business.swift
//  Yelp
//
//  Created by Matthew Carroll on 4/23/15.
//  Copyright (c) 2015 blarg. All rights reserved.
//

import UIKit

class Business: NSObject {
    var imageUrl: String!
    var name: String!
    var ratingImageUrl: String!
    var numReviews: Int!
    var address: String!
    var categories: String!
    var distance: Double!
    var rating: Int!
    var distanceMeters: Double!
    
    init(fromBusinessInfoDict businessInfoDict: NSDictionary) {
        super.init()
        imageUrl = businessInfoDict["image_url"] as String?
        name = businessInfoDict["name"] as String?
        ratingImageUrl = businessInfoDict["rating_img_url"] as String?
        numReviews = businessInfoDict["review_count"] as Int?
        
        let dictAddresses = businessInfoDict.valueForKeyPath("location.address") as [String]?
        let dictNeighborhoods = businessInfoDict.valueForKeyPath("location.neighborhoods") as [String]?
        if dictAddresses != nil && dictNeighborhoods != nil {
            if dictNeighborhoods?.count > 0 && dictAddresses?.count > 0 {
                let firstNeighborhood = dictNeighborhoods![0]
                let firstAddress = dictAddresses![0]
                address = "\(firstAddress), \(firstNeighborhood)"
            }
        }
        
        if let dictCategories = businessInfoDict["categories"] as? [[String]] {
            categories = dictCategories.reduce("", combine: { (catStr: String, catUpperAndLower: [String]) -> String in
                let upper = catUpperAndLower[0]
                if countElements(catStr) > 0 {
                    return catStr + ", \(upper)"
                } else {
                    return "\(upper)"
                }
            })
        }
        
        if let dictDistanceMeters = businessInfoDict["distance"] as? Double {
            distanceMeters = dictDistanceMeters
            let milesPerMeter = 0.000621371
            distance = milesPerMeter * dictDistanceMeters
        } else {
            distance = 0
            distanceMeters = 0
        }
        
        if let dictRating = businessInfoDict["rating"] as? Int {
            rating = dictRating
        } else {
            rating = 0
        }
    }
    
    // TODO: Centralize definition of sort options. Spread between here, FiltersViewController, SortCell
    // Options are "rating", "distance"
    func isSortedBefore(otherBusiness: Business, selectedSort: SortOption) -> Bool {
        switch selectedSort {
        case SortOption.Rating:
            return self.rating! > otherBusiness.rating!
            
        case SortOption.Distance:
            return self.distance! < otherBusiness.distance
            
        default:
            println("Business: unknown sort type \(selectedSort)")
            return self.rating! > otherBusiness.rating!
            
        }
    }
}
