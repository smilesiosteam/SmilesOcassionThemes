//
//  ShopByCategoriesTVC.swift
//  
//
//  Created by Habib Rehman on 30/10/2023.
//

import UIKit
import SmilesUtilities

class ShopByCategoriesTVC: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var topCardHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleBGView: UIView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var cardBGView: UIView!
    @IBOutlet weak var uptoLabel: UILabel!
    @IBOutlet weak var categoryDescLabel: UILabel!
    @IBOutlet weak var validityDateLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    let n:Int = 0
    var collectionsData: ThemeCategoriesResponse?{
       didSet{
           self.collectionView?.reloadData()
       }
   }
    
    // MARK: - SuperCell Properties
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cellUISetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

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
        self.cardBGView.backgroundColor = UIColor.lightGreenColor
        self.titleBGView.backgroundColor = UIColor.appDarkGrayColor
        
        //View's Corner Radius
        self.cardBGView.layer.cornerRadius = 16
        self.titleBGView.layer.cornerRadius = 16
        
        //Card Hide/Show
        self.topCardHeightConstraint.constant = n%2 == 0 ? 0:140
        
        //Localiation Setting
        self.validityDateLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        self.categoryTitleLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        self.uptoLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        self.categoryDescLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        self.uptoLabel.semanticContentAttribute = AppCommonMethods.languageIsArabic() ? .forceRightToLeft : .forceLeftToRight
        
        //CollectionView Setup
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: String(describing: ShopByCategoriesCVC.self), bundle: .module), forCellWithReuseIdentifier: String(describing: ShopByCategoriesCVC.self))
        
        
    }
    
    
    // MARK: - Cell Configuration
    public func configureCellData(){
        //Configure cell Data here
    }
    
}


extension ShopByCategoriesTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ShopByCategoriesCVC.self), for: indexPath) as? ShopByCategoriesCVC else {return UICollectionViewCell()}
        cell.configureCellData()
        return cell
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    
    
}
