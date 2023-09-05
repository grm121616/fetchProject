//
//  TableViewCell.swift
//  FetchProject
//
//  Created by Ruoming Gao on 9/5/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var mealImage: UIImageView!
    
    let imageCache = NSCache<NSString, UIImage>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func getImage(uiimage: UIImage){
        mealImage.image = uiimage
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
