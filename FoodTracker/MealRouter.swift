//
//  MealController.swift
//  FoodTracker
//
//  Created by Kelvin Checo on 7/7/17.
//  Copyright © 2017 Kelvin Checo. All rights reserved.
//

import Foundation
import Alamofire

enum MealEndpoint {
    case GetMeals
    case CreateMeal(meal: Meal)
    case GetMeal(id: Int)
    case UpdateMeal(meal: Meal)
    case DeleteMeal(id: Int)
}

class MealRouter : BaseRouter {
    
    var endpoint: MealEndpoint
    init(endpoint: MealEndpoint) {
        self.endpoint = endpoint
    }
    
    override var method: Alamofire.HTTPMethod {
        switch endpoint {
        case .CreateMeal:
            return .post
        case .GetMeal:
            return .get
        case .UpdateMeal:
            return .put
        case .DeleteMeal:
            return .delete
        default:
         return .get
        }
        
    }
    
    override var path: String {
        switch endpoint {
        case .GetMeals: return "meals/"
        case .CreateMeal(let meal): return "meals/\(meal)"
        case .GetMeal(let id): return "meals/\(id)"
        case .UpdateMeal(let meal): return "meals/\(meal.id)/\(meal)"
        case .DeleteMeal(let id): return "meals/\(id)"
        }
    }
    
    override var parameters: APIParams {
        switch endpoint {
        case .CreateMeal(let meal):
            return meal.toJsonDictionary()
        case .UpdateMeal(let meal):
            return meal.toJsonDictionary()
        default: return nil
        }
    }
    
    override var encoding: ParameterEncoding? {
        switch endpoint {
        case .GetMeals: return URLEncoding()
        case .GetMeal: return URLEncoding()
        default: return JSONEncoding()
        }
    }
}
