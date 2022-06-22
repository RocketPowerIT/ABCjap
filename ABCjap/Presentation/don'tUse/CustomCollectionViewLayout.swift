//
//  CustomCollectionViewLayout.swift
//  ABCjap
//
//  Created by mac on 30/03/2022.
//

import UIKit
protocol PinterestLayoutDelegate: AnyObject {
  func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}

class CustomCollectionViewLayout: UICollectionViewLayout {
    // 1
    weak var delegate: PinterestLayoutDelegate?

    // 2
    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 6

    // 3
    private var cache: [UICollectionViewLayoutAttributes] = []

    // 4
    private var contentHeight: CGFloat = 0

    private var contentWidth: CGFloat {
      guard let collectionView = collectionView else {
        return 0
      }
      let insets = collectionView.contentInset
      return collectionView.bounds.width - (insets.left + insets.right)
    }

    // 5
    override var collectionViewContentSize: CGSize {
      return CGSize(width: contentWidth, height: contentHeight)
    }
}
