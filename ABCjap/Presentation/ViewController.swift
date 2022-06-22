//
//  ViewController.swift
//  ABCjap
//
//  Created by mac on 29/03/2022.
//

import UIKit

class ViewController: UIViewController {
    
    weak var coordinator: CoordinatorTabABC?
    var collectionView:UICollectionView?
    
    var viewModel:ViewModel?
    
    func initViewModel(){
        viewModel!.fetchItems()
        viewModel!.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView?.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initViewModel()
        initCollectionView()
        setConstraintCV()
    }
    
    func setConstraintCV() {
        let setOffSet:CGFloat = 0
        NSLayoutConstraint.activate([
            collectionView!.topAnchor.constraint(equalTo: self.view.topAnchor,constant: -setOffSet),
            collectionView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: setOffSet),
            collectionView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: setOffSet),
            collectionView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -setOffSet)
                ])
     //   collectionView?.frame = view.bounds
    }
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .vertical
        
        return layout
    }()
    
    
    
    func initCollectionView(){
       
        let layout = flowLayout
        
        collectionView = UICollectionView(frame:self.view.frame, collectionViewLayout: layout)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.isPagingEnabled = true
        
        collectionView?.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView?.register(CustomCollectionViewCell.self,
                                 forCellWithReuseIdentifier: CustomCollectionViewCell.cellIdenditifator)
        collectionView?.register(HeaderCollectionReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        collectionView?.register(FooterCollectionReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCollectionReusableView.identifier)
        collectionView!.dataSource = self
        collectionView!.delegate = self

        self.view.addSubview(collectionView ?? UICollectionView())
    }
    
    init(vm:ViewModel) {
        super.init(nibName: nil, bundle: nil)
        viewModel = vm
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel!.getCountCell()
         // How many cells to display
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.cellIdenditifator, for: indexPath) as! CustomCollectionViewCell
       // var sec = Int(indexPath.section)
        let cellVM = viewModel!.getCellVM(at: indexPath)
        myCell.cellViewModel = cellVM
        return myCell
    }
    
    //Footer _ Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            return collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderCollectionReusableView.identifier,
                for: indexPath
            )
        }
        return collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: FooterCollectionReusableView.identifier,
            for: indexPath
        )
    }

}
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let width = collectionView.bounds.width
         let numberOfItemsPerRow: CGFloat = 5
         let spacing: CGFloat = flowLayout.minimumInteritemSpacing
         let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
         let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: itemDimension*1.5)
     }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return .zero
        }
        return CGSize(width: view.frame.size.width, height: view.frame.size.height/6)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height/6)
    }
}

//extension ViewController: UICollectionReusableView {
//
//}

