//
//  ItemRecord.swift
//  ecommerce
//
//  Created by Guy Daher on 03/02/2017.
//  Copyright © 2017 Guy Daher. All rights reserved.
//

import InstantSearch
import Foundation

struct ItemRecord {
    private var json: JSONObject
    private let MAX_BEST_SELLING_RANK = 32691;
    
    init(json: JSONObject) {
        self.json = json
    }
    var dish_name: String? {
        return json["dish_name"] as? String
    }
    
    var restuant_name: String? {
        return json["restuant_name"] as? String
    }
    
    var name: String? {
        return json["name"] as? String
    }
    
    var type: String? {
        return json["restaurant_name"] as? String
    }
    
    var category: String? {
        return json["category"] as? String
    }
    
    var price: Double? {
        var inputPrice = json["dish_price"] as? Double
        inputPrice = inputPrice!/100
        return inputPrice
    }
    
    
    var rating: Int? {
        return json["bestSellingRank"] as? Int
    }
    
    var imageUrl: URL? {
        guard let urlString = json["best_image"] as? String else { return nil }
        return URL(string: urlString)
    }
    
    var name_highlighted: String? {
        return SearchResults.highlightResult(hit: json, path: "dish_name")?.value
    }
    
    var category_highlighted: String? {
        return SearchResults.highlightResult(hit: json, path: "category")?.value
    }
    
    var type_highlighted: String? {
        return SearchResults.highlightResult(hit: json, path: "restaurant_name")?.value
    }
}

