//
//  ShopByCategoriesCVC.swift
//  
//
//  Created by Habib Rehman on 30/10/2023.
//

import UIKit
import SmilesUtilities

class ShopByCategoriesCVC: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var titleBGView: UIView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var uptoLabel: UILabel!
    @IBOutlet weak var categoryDescLabel: UILabel!
    @IBOutlet weak var validityDateLabel: UILabel!
    
    // MARK: - Properties
    
    var categories:ThemeCategoriesResponse!{
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
        self.categoryTitleLabel.textColor = UIColor.white
        
        //Views Background Colors
        self.BGView.backgroundColor = UIColor.lightGreenColor
        self.titleBGView.backgroundColor = UIColor.appDarkGrayColor
        
        //View's Corner Radius
        self.BGView.layer.cornerRadius = 12
        self.BGView.clipsToBounds = true
        self.titleBGView.layer.cornerRadius = 10
        self.titleBGView.clipsToBounds = true
        
        
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
        self.titleBGView.backgroundColor = UIColor(hexString: categories.titleColor ?? "")
        self.categoryTitleLabel.text = categories.categoryName
        self.categoryDescLabel.text = categories.subTitle
        self.validityDateLabel.text = categories.validTill
        self.uptoLabel.text = categories.discountText
        
    }

}
