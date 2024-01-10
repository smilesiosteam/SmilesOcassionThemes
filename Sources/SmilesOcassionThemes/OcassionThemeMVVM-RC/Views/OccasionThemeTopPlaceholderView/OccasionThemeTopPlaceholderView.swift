//
//  OcassionThemeHeaderView.swift
//  
//
//  Created by Habib Rehman on 01/11/2023.
//

import UIKit
import SmilesUtilities

class OccasionThemeTopPlaceholderView: UIView {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var themeHeaderLabel: UILabel!
    @IBOutlet weak var themeTitleLabel: UILabel!
    @IBOutlet weak var themeOfferLabel: UILabel!
    @IBOutlet weak var foregroundImage: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet var mainView: UIView!
    @IBOutlet var titeContainerView: UIView!
    
    // MARK: - METHODS -
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        //XibView Setup
        Bundle.module.loadNibNamed(String(describing: OccasionThemeTopPlaceholderView.self), owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = bounds
        mainView.bindFrameToSuperviewBounds()
        //Fonts Style
        themeHeaderLabel.fontTextStyle = .smilesBody3
        themeTitleLabel.fontTextStyle = .smilesHeadline3
        dateLabel.fontTextStyle = .smilesBody4
        
        //Fonts Color
        themeHeaderLabel.textColor = .black
        themeTitleLabel.textColor = .white
        dateLabel.textColor = .white
        themeOfferLabel.textColor = .black
        
        //Localization Settings
        self.themeHeaderLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        self.themeTitleLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        self.dateLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        self.themeOfferLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        self.titeContainerView.isHidden = true
        self.titeContainerView.layer.cornerRadius = 12.0
        self.titeContainerView.clipsToBounds = true
    }
    
    func setupData(topBannerObject: TopPlaceholderTheme) {
        
        self.titeContainerView.isHidden = false
        dateLabel.text = topBannerObject.validTill
        themeHeaderLabel.text = topBannerObject.header
        themeTitleLabel.text = topBannerObject.title
        
        let offerText = NSMutableAttributedString()
        if let discountText = topBannerObject.discountText {
            offerText.append(discountText.getAttributedString(style: .smilesHeadline3, color: .black))
        }
        if let subText = topBannerObject.subText {
            offerText.append(NSAttributedString(string: " "))
            offerText.append(subText.getAttributedString(style: .smilesBody3, color: .black))
        }
        themeOfferLabel.attributedText = offerText
        backgroundImageView.setImageWithUrlString(topBannerObject.backgroundImage ?? "")
        foregroundImage.setImageWithUrlString(topBannerObject.foregroundImage ?? "")
        self.mainView.backgroundColor = UIColor(hexString: topBannerObject.backgroundColor ?? "#ffffff")
        
    }

}
