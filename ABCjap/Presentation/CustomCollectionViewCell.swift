//
//  CollectionViewCellViewModel.swift
//  ABCjap
//
//  Created by mac on 29/03/2022.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let cellIdenditifator = "CellColoectionView"
    
    lazy var kanjiLabel = makeLabel(size: 45)
    lazy var roumajiLabel = makeLabel(size: 20)
    lazy var bg = makeImageView()
    
    var cellViewModel: CustomABCViewModel? {
        didSet {
            kanjiLabel.text = cellViewModel?.kana
            roumajiLabel.text = cellViewModel?.roumaji
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        SetConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                self.layer.zPosition = self.isSelected ? 1 : -1

                self.transform = self.isSelected ? CGAffineTransform(scaleX: 3, y: 3) : CGAffineTransform.identity
            }, completion: nil)
        }
    }

}
private extension CustomCollectionViewCell {
    
    func SetConstraint(){
        NSLayoutConstraint.activate([
            bg.topAnchor.constraint(equalTo: contentView.topAnchor),
            bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            kanjiLabel.centerXAnchor.constraint(equalTo: bg.centerXAnchor,constant: 0),
            kanjiLabel.centerYAnchor.constraint(equalTo: bg.centerYAnchor,constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            roumajiLabel.bottomAnchor.constraint(equalTo: bg.bottomAnchor, constant: -5),
            roumajiLabel.trailingAnchor.constraint(equalTo: bg.trailingAnchor,constant: -5)
        ])
        
    }
    
    func setupUI() {
        // backgroundColor = .clear
        bg.image = #imageLiteral(resourceName: "frameCardBg.png")
        contentView.addSubview(bg)
        addSubview(roumajiLabel)
        roumajiLabel.textColor = .white
        
        addSubview(kanjiLabel)
        kanjiLabel.font = .boldSystemFont(ofSize: 35)
        
        
    }
}
