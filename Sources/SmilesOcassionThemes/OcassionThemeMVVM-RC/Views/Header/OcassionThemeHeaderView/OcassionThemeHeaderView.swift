//
//  OcassionThemeHeaderView.swift
//  
//
//  Created by Habib Rehman on 01/11/2023.
//

import UIKit
import SmilesUtilities

class OcassionThemeHeaderView: UIView {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var themeTitleLabel: UILabel!
    @IBOutlet weak var themeDescLabel: UILabel!
    @IBOutlet weak var themeOfferLabel: UILabel!
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet var mainView: UIView!
    
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
//        Bundle.module.loadNibNamed(String(describing: OcassionThemeHeaderView.self), owner: self, options: nil)
//        addSubview(mainView)
//        mainView.frame = bounds
//        mainView.bindFrameToSuperviewBounds()
        
        //Fonts Style
        themeTitleLabel.fontTextStyle = .smilesHeadline2
        themeDescLabel.fontTextStyle = .smilesBody3
        dateLabel.fontTextStyle = .smilesBody3
        themeOfferLabel.fontTextStyle = .smilesBody3
        
        
        //Fonts Color
        themeTitleLabel.textColor = .white
        themeDescLabel.textColor = .black
        dateLabel.textColor = .white
        themeOfferLabel.textColor = .black
        
        //Localization Settings
        self.themeTitleLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        self.themeDescLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        self.dateLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        self.themeOfferLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        
        
    }

}
