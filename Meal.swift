//
//  Meal.swift
//  FoodTracker
//
//  Created by Kelvin Checo on 7/1/17.
//  Copyright © 2017 Kelvin Checo. All rights reserved.
//

import UIKit
import Foundation

class Meal {
    
    /*
     ------------------------------------
     MARK: Properties
     ------------------------------------
     */
    var id: Int?
    var name: String?
    var photo: UIImage?
    var rating: Int?
    
    /*
     ------------------------------------
     MARK: Initializer
     ------------------------------------
     */
    init(json: JSONDictionary) {
        
        if let id = json["id"] as? Int {
            self.id = id
        }
        if let name = json["name"] as? String {
            self.name = name
        }
        if let photo = json["photo"] as? UIImage {
            self.photo = photo
        }
        if let rating = json["rating"] as? Int {
            self.rating = rating
        }
    }
    
    func toJsonDictionary() -> JSONDictionary {
        var dict: JSONDictionary = [:]
        
        if let id = id { dict["id"] = id as Int as AnyObject }
        if let name = name { dict["name"] = name as AnyObject }
        if let photo = photo { dict["photo"] = photo as UIImage }
        if let rating = rating { dict["rating"] = rating as AnyObject}
        
        return dict
    }
}
