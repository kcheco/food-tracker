//
//  APIManager.swift
//  FoodTracker
//
//  Created by Kelvin Checo on 7/9/17.
//  Copyright © 2017 Kelvin Checo. All rights reserved.
//

import Foundation
import Alamofire

public class APIManager {
    
    public static let sharedInstance: APIManager = APIManager()
    
    let manager = SessionManager()
    var meal: Meal!
    var meals = [Meal]()
    
    init() {
    }
    
    func getMeals(completion: @escaping (_ meals: [Meal]) -> ()) -> Request {
        let router = MealRouter(endpoint: .GetMeals)
        
        return manager.request(router)
            .responseJSON{ response in
                if let error = response.error {
                    print(error)
                    return
                }
                
                if let dict = response.value as? JSONDictionary {
                    
                    if let meals = dict["meals"] as? [JSONDictionary] {
                        
                        for obj in meals {
                            let meal = Meal(json: obj)
                            self.meals.append(meal)
                            print(obj)
                        }
                    }
                }
                completion(self.meals)
            }
    }
}
