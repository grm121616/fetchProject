//
//  ViewController.swift
//  FetchProject
//
//  Created by Ruoming Gao on 9/5/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var meals: [Meal] = []
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.callMeals { (data, _) in
            guard let data = data else { return }
            let jsonObject = try? JSONDecoder().decode(MealModels.self, from: data)
            DispatchQueue.main.async {
                self.meals = jsonObject?.meals ?? []
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "detailVC") as? DetailViewController else { return }
        let mealId = meals[indexPath.row].idMeal
        let url = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)"
        vc.getDetailData(url: url)
        vc.nameLabelText = meals[indexPath.row].strMeal
        vc.loadImage(urlString: meals[indexPath.row].strMealThumb)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.nameLabel.text = meals[indexPath.row].strMeal
        cell.loadImage(urlString: meals[indexPath.row].strMealThumb)
        return cell
    }
}
