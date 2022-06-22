//
//  HeaderCollectionReusableView.swift
//  ABCjap
//
//  Created by mac on 30/03/2022.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "HeaderCollectionReusableView"
    
    private let imageView:UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "headerABC"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
       // imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func configure(with showColor: Bool){
        if showColor {
            imageView.isHidden = true
            backgroundColor = .systemRed
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
}


class FooterCollectionReusableView: UICollectionReusableView {
    static let identifier = "FooterCollectionReusableView"
    
    private let imageView:UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "headerABC"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
       // imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    func configure(with showColor: Bool){
        if showColor {
            imageView.isHidden = true
            backgroundColor = .systemRed
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
}
