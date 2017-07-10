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
    
    init() {
    }
    
    func getMeals(completion: @escaping (_ meals: [Meal]) -> ()) -> Request {
        let router = MealRouter(endpoint: .GetMeals)
        
        return manager.request(router)
            .validate()
            .responseJSON{ response in
                if let error = response.error {
                    print(error)
                    return
                }
                
                let mealJson = ((response.value as! JSONDictionary)["meals"] as? [JSONDictionary])!
                
                var objs: [Meal] = []
                
                for json in mealJson {
                    objs += [Meal(json: json)]
                }
                completion(objs)
            }
    }
}
