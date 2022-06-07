//
//  DetailPageViewController.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/06/06.
//

import UIKit

class DetailPageViewController: UIViewController {

    private let detailPageDataSource = DetailPageCollectionDataSource()
    private lazy var detailPageCollectionView = DetailPageCollectionView(frame: view.frame)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDetailPageCollectionView()
        
    }
}

extension DetailPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: Configure All Initial setting

private extension DetailPageViewController {
    
    func setDetailPageCollectionView() {
        self.detailPageCollectionView.collectionView.delegate = self
        self.detailPageCollectionView.setDataSource(detailPageDataSource)
        self.view.addSubview(detailPageCollectionView)
    }
    
    func setToolbar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.isToolbarHidden = false
        let toolBarButtons = [
            UIBarButtonItem(title: "건너뛰기", style: .plain, target: self, action: #selector())
        ]
        toolbarItems = toolBarButtons
    }
}
