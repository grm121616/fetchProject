//
//  NetworkController.swift
//  FetchProject
//
//  Created by Ruoming Gao on 9/5/23.
//

import Foundation
import UIKit
class NetworkController {
    
    let mealURL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    
    func callAPI(url: String, completion: @escaping(Data?, Error?) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            completion(data, error)
        }.resume()
    }
    
    
    func callMeals(completion: @escaping(Data?, Error?) -> Void)  {
        callAPI(url: mealURL, completion: completion)
    }
}

