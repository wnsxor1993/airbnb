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
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowshape.turn.up.backward"), for: .normal)
        button.backgroundColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 23
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDetailPageCollectionView()
        self.setToolbar()
        self.setBackButton()
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
    
    func setBackButton() {
        view.addSubview(backButton)

        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
