//
//  TopBrandsCollectionViewCell.swift
//  House
//
//  Created by Shahroze Zaheer on 11/3/22.
//  Copyright © 2022 Ahmed samir ali. All rights reserved.
//

import UIKit
import SmilesFontsManager
import SmilesUtilities
import SmilesSharedServices
class TopBrandsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI() {
        image.addBorder(withBorderWidth: 1, borderColor: UIColor(white: 0.91, alpha: 1))
        image.addMaskedCorner(withMaskedCorner: [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner], cornerRadius: image.frame.width / 2)
        
        title.fontTextStyle = .smilesTitle2
        title.textColor = .black
    }

    func configureCell(with data: GetTopBrandsResponseModel.BrandDO) {
        image.setImageWithUrlString(data.iconUrl.asStringOrEmpty()) { [weak self] image in
            if let image = image {
                self?.image.image = image
            }
        }
        
        title.text = data.title
    }
}
