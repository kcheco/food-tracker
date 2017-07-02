//
//  Meal.swift
//  FoodTracker
//
//  Created by Kelvin Checo on 7/1/17.
//  Copyright © 2017 Kelvin Checo. All rights reserved.
//

import UIKit

class Meal {
    
    /*
     ------------------------------------
     MARK: Properties
     ------------------------------------
     */
    var name: String
    var photo: UIImage?
    var rating: Int
    
    /*
     ------------------------------------
     MARK: Initializer
     ------------------------------------
     */
    init?(name: String, photo: UIImage?, rating: Int) {
        
        // Initialization should fail if there is no name or if the rating is negative
        if name.isEmpty || rating < 0 {
            return nil
        }
        
        // Initialize stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
