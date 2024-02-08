//
//  CollectionsCollectionViewCell.swift
//  House
//
//  Created by Shahroze Zaheer on 10/26/22.
//  Copyright © 2022 Ahmed samir ali. All rights reserved.
//

import UIKit
import SmilesUtilities
import SmilesSharedServices

class CollectionsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI() {
        image.addMaskedCorner(withMaskedCorner: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], cornerRadius: 16.0)
        image.layer.borderColor = UIColor.appRevampBorderGrayColor.cgColor
        image.layer.borderWidth = 1
        
        collectionName.fontTextStyle = .smilesTitle1
        collectionName.textColor = .appRevampCollectionsTitleColor
    }

    func configureCell(with data: GetCollectionsResponseModel.CollectionDO) {
        image.setImageWithUrlString(data.imageUrl.asStringOrEmpty(), backgroundColor: .white) { [weak self] image in
            if let image = image {
                self?.image.image = image
            }
        }
        
        collectionName.text = data.title
    }
}
