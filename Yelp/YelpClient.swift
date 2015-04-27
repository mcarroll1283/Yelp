//
//  YelpClient.swift
//  Yelp
//
//  Created by Matthew Carroll on 4/23/15.
//  Copyright (c) 2015 blarg. All rights reserved.
//

import UIKit

class YelpClient: BDBOAuth1RequestOperationManager {
    var accessToken: String!
    var accessSecret: String!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        var baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        var token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func searchWithTerm(term: String, filterConfiguration: FilterConfiguration, success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        let categoryFilter = ",".join(filterConfiguration.categories)


        let radiusFilter = "\(filterConfiguration.selectedRadius.radiusInMeters())"
        var parameters = ["term": term, "ll": "37.7833,-122.4167", "category_filter": categoryFilter]
        
        if let maxRadiusMeters = filterConfiguration.selectedRadius.radiusInMeters() {
            parameters["radius_filter"] = NSString(format: "%.0f", maxRadiusMeters)
        }
        
        println("parameters: \(parameters)")
        return self.GET("search", parameters: parameters, success: success, failure: failure)
    }
}
