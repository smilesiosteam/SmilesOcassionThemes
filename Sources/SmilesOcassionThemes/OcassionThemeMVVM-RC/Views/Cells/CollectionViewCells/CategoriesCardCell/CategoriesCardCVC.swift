//
//  CategoriesCardCVC.swift
//
//
//  Created by Habib Rehman on 09/11/2023.
//

import UIKit
import SmilesUtilities
import SmilesFontsManager

class CategoriesCardCVC: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var titleBGView: UIView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var uptoLabel: UILabel!
    @IBOutlet weak var categoryDescLabel: UILabel!
    @IBOutlet weak var validityDateLabel: UILabel!
    
    @IBOutlet weak var categoryCardImage: UIImageView!
    // MARK: - Properties
    
    var category:ThemeCategoriesResponse!{
        didSet{
            configureCellData()
        }
    }
    
    // MARK: - SuperCell Properties
    override func awakeFromNib() {
        super.awakeFromNib()
        cellUISetup()
    }
    
    
    
    
    // MARK: - cellUISetup
    private func cellUISetup(){
        
        //Fonts TypoGraphy
        self.categoryTitleLabel.fontTextStyle = .smilesTitle3
        self.uptoLabel.fontTextStyle = .smilesTitle3
        self.categoryDescLabel.fontTextStyle = .smilesTitle1
        self.validityDateLabel.fontTextStyle = .smilesBody4
        
        //Font Colors
        self.validityDateLabel.textColor = UIColor.black.withAlphaComponent(0.8)
        self.categoryDescLabel.textColor = UIColor.black
        self.uptoLabel.textColor = UIColor.black
        self.categoryTitleLabel.textColor = UIColor.black
        
        //Views Background Colors
        self.BGView.backgroundColor = UIColor.lightGreenColor
        self.titleBGView.backgroundColor = UIColor.appDarkGrayColor
        
        //View's Corner Radius
        self.BGView.layer.cornerRadius = 12
        self.titleBGView.layer.cornerRadius = 16
        titleBGView.clipsToBounds = true
        //Localization Settings
        self.validityDateLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        self.categoryTitleLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        self.uptoLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        self.categoryDescLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        self.uptoLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        
    }
    
    
    // MARK: - Cell Configuration
    public func configureCellData(){
        //Configure cell Data here
        self.categoryTitleLabel.text = category.categoryName
        self.categoryDescLabel.text = category.subTitle
        self.validityDateLabel.text = category.validTill
        self.uptoLabel.text = category.discountText
        
    }
    
}
