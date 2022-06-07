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
//        detailPageCollectionView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            detailPageCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            detailPageCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            detailPageCollectionView.bottomAnchor.constraint(equalTo: toolBarView.topAnchor),
//            detailPageCollectionView.topAnchor.constraint(equalTo: view.topAnchor)
//        ])
    }
    
    func setToolbar() {
        navigationController?.navigationBar.isHidden = true
//        self.view.addSubview(toolBarView)
//        toolBarView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            toolBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            toolBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            toolBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            toolBarView.heightAnchor.constraint(equalToConstant: 105)
//        ])
        let toolBar = UIToolbar()
        view.addSubview(toolBar)
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            toolBar.heightAnchor.constraint(equalToConstant: 105)
        ])
        
        let toolItem = UIBarButtonItem(customView: toolBarView)
        toolBar.setItems([toolItem], animated: true)
        
        toolBarView.setCostLabel(text: "$1,500 /박")
        toolBarView.setDateLabel(text: "7월 7일 - 7월 18일")
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
