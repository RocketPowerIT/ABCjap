//
//  CustomHelperUI.swift
//  ABCjap
//
//  Created by mac on 29/03/2022.
//

import Foundation
import UIKit

extension CustomCollectionViewCell {

    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    func makeLabel(size: CGFloat) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: size)
        return label
    }
}
