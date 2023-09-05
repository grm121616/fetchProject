//
//  DetailViewController.swift
//  FetchProject
//
//  Created by Ruoming Gao on 9/5/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var mealImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var instructionLabel: UILabel!
    
    @IBOutlet weak var ingredStackView: UIStackView!
    
    let imageCache = NSCache<NSString, UIImage>()
    
    var nameLabelText: String?
    
    let viewModel = ViewModel()
    
    var switchArrCount = 0
    var switchUIArr: [UISwitch] = []
    var ingretsArray:[String] = []
    var measurementArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = nameLabelText
    }
    
    @objc func switchDidChange(_ sender: UISwitch) {
        if !sender.isOn {
            switchArrCount += 1
        } else if switchArrCount > 0, sender.isOn {
            switchArrCount -= 1
        }
    }
    
    func getDetailData(url: String) {
        viewModel.callAPI(url: url, completion: { (data, _) in
            DispatchQueue.main.async {
                guard let data = data, let jsonObject = try? JSONDecoder().decode(DetailsMealModels.self, from: data).meals else { return }
                self.displayUI(jsonObject: jsonObject)
            }
        })
    }
    
    func displayUI(jsonObject: [DetailMeal]) {
        ingretsArray = viewModel.getstrIngredient(meal: jsonObject)
        measurementArray = viewModel.getMeasurement(meal: jsonObject)
        instructionLabel.text = jsonObject[0].strInstructions
        for i in 0..<self.ingretsArray.count {
            let ingreLabel = UILabel()
            let measureLabel = UILabel()
            ingreLabel.text = self.ingretsArray[i]
            if self.measurementArray.count > i {
                measureLabel.text =  self.measurementArray[i]
            }
            let checkMark = UISwitch()
            checkMark.addTarget(self, action: #selector(self.switchDidChange(_:)), for: .valueChanged)
            self.switchUIArr.append(checkMark)
            self.switchArrCount += 1
            let hzStackView = UIStackView()
            let ingretsMeasureStack = UIStackView()
            ingretsMeasureStack.addArrangedSubview(ingreLabel)
            ingretsMeasureStack.addArrangedSubview(measureLabel)
            ingretsMeasureStack.alignment = .center
            ingretsMeasureStack.spacing = 16
            hzStackView.spacing = 20
            hzStackView.addArrangedSubview(ingretsMeasureStack)
            hzStackView.addArrangedSubview(checkMark)
            self.ingredStackView.spacing = 8
            self.ingredStackView.addArrangedSubview(hzStackView)
        }
    }
    
    func getImage(uiimage: UIImage){
        mealImageView.image = uiimage
    }
    
    func loadImage(urlString: String? = nil, imageData: Data? = nil) {
        if let urlString = urlString, let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            DispatchQueue.main.async {
                self.getImage(uiimage: imageFromCache)
            }
        } else if let imageData = imageData, let uiImage = UIImage(data: imageData) {
            DispatchQueue.main.async {
                self.getImage(uiimage: uiImage)
            }
        } else {
            guard let urlString = urlString, let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { (data, _, error) in
                guard let data = data,
                let image = UIImage(data: data) else { return }
                self.imageCache.setObject(image, forKey: urlString as NSString)
                DispatchQueue.main.async {
                    self.getImage(uiimage: image)
                }
            }.resume()
        }
    }
}
