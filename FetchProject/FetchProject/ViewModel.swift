//
//  ViewModel.swift
//  FetchProject
//
//  Created by Ruoming Gao on 9/5/23.
//

import Foundation

class ViewModel {
    
    let networkController = NetworkController()
    
    func callAPI(url: String, completion: @escaping(Data?, Error?) -> Void) {
        networkController.callAPI(url: url) { (data, error) in
            completion(data, error)
        }
    }
    
    func callMeals(completion: @escaping(Data?, Error?) -> Void) {
        networkController.callMeals { (data, error) in
            completion(data, error)
        }
    }
    
    func getstrIngredient(meal: [DetailMeal]) -> [String] {
        let mealIngres = [meal[0].strIngredient1, meal[0].strIngredient2, meal[0].strIngredient3, meal[0].strIngredient4, meal[0].strIngredient5, meal[0].strIngredient6, meal[0].strIngredient7, meal[0].strIngredient8, meal[0].strIngredient9, meal[0].strIngredient10, meal[0].strIngredient11, meal[0].strIngredient12, meal[0].strIngredient13, meal[0].strIngredient14, meal[0].strIngredient15, meal[0].strIngredient16, meal[0].strIngredient17, meal[0].strIngredient18, meal[0].strIngredient19, meal[0].strIngredient20]
        var mealIngres1: [String] = []
        for ingres in mealIngres {
            if let mealIngre = ingres, ingres != "" {
                mealIngres1.append(mealIngre)
            }
        }
        return mealIngres1
    }
    
    func getMeasurement(meal: [DetailMeal]) -> [String] {
        let mealMeasure = [meal[0].strMeasure1, meal[0].strMeasure2, meal[0].strMeasure3, meal[0].strMeasure4, meal[0].strMeasure5, meal[0].strMeasure6, meal[0].strMeasure7, meal[0].strMeasure8, meal[0].strMeasure9, meal[0].strMeasure10, meal[0].strMeasure11, meal[0].strMeasure12, meal[0].strMeasure13, meal[0].strMeasure14, meal[0].strMeasure15, meal[0].strMeasure16, meal[0].strMeasure17, meal[0].strMeasure18, meal[0].strMeasure19, meal[0].strMeasure20]
        var mealMeasureArr = [String]()
        for measure in mealMeasure {
            if let mealMeasure = measure, measure != "" {
                mealMeasureArr.append(mealMeasure)
            }
        }
        return mealMeasureArr
    }
}
