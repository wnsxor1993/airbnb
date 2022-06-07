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
    private lazy var toolBarView = DetailPageToolBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDetailPageCollectionView()
        self.setToolbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        navigationController?.setToolbarHidden(false, animated: false)
        
        let customView = UIBarButtonItem(customView: toolBarView)
        navigationController?.toolbar.setItems([customView], animated: false)
    }
}
