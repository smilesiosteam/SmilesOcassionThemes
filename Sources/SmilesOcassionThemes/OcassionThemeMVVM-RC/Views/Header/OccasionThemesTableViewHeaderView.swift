//
//  File.swift
//  
//
//  Created by Shmeel Ahmad on 14/08/2023.
//

import SmilesUtilities
import SmilesLanguageManager
import UIKit

class OccasionThemesTableViewHeaderView: UIView {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var titleLabel: UILocalizableLabel!
    @IBOutlet weak var subTitleLabel: UILocalizableLabel!
    @IBOutlet weak var mainView: UIView!
    
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
        Bundle.module.loadNibNamed("OccasionThemesTableViewHeaderView", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = bounds
        mainView.bindFrameToSuperviewBounds()
        titleLabel.fontTextStyle = .smilesHeadline2
        subTitleLabel.fontTextStyle = .smilesBody4
        
        titleLabel.textColor = .black
        subTitleLabel.textColor = .black.withAlphaComponent(0.8)
        
    }
    
    func setupData(title: String?, subTitle: String?, color: UIColor?,section:Int?, isPostSub:Bool = false) {
        titleLabel.localizedString = title ?? ""
        subTitleLabel.localizedString = subTitle ?? ""
        titleLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        subTitleLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
    }
    
}
