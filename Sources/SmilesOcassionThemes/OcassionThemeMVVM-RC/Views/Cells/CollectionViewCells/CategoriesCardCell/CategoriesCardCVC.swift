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
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var foregroundImage: UIImageView!
    
    var btnCategoryTapHandler: ((ThemeCategoriesResponse) -> ())?
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
        self.discountLabel.fontTextStyle = .smilesHeadline3
        self.subTitleLabel.fontTextStyle = .smilesHeadline3
        
        //Font Colors
        self.subTitleLabel.textColor = UIColor.black.withAlphaComponent(0.8)
        self.discountLabel.textColor = UIColor.black
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
        self.subTitleLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        self.categoryTitleLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        self.uptoLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        self.discountLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        self.uptoLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        
    }
    
    
    // MARK: - Cell Configuration
    func configureCellData(){
        //Configure cell Data here
        self.BGView.backgroundColor = UIColor(hexString: category.backgroundColor ?? "")
        self.titleBGView.backgroundColor = UIColor(hexString: category.headerColor ?? "")
        self.categoryTitleLabel.text = category.headerText
        self.uptoLabel.text = category.title
        self.discountLabel.text = category.discountText
        self.subTitleLabel.text =  category.subTitle
        self.foregroundImage.setImageWithUrlString(category.foregroundImage ?? "")
       
    }
    
}
