//
//  DetailPageViewController.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/06/06.
//

import UIKit

class DetailPageViewController: UIViewController {

    private var detailPageDataSource: DetailPageCollectionDataSource?
    private lazy var detailPageCollectionView = DetailPageCollectionView(frame: view.frame)
    private lazy var toolBarView = DetailPageToolBar()
    private var repository = DetailPageRepository()
    
    private let roomData: AccomodationsViewComponentsData.AccomodationInfo?
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowshape.turn.up.backward"), for: .normal)
        button.backgroundColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 23
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(data: AccomodationsViewComponentsData.AccomodationInfo?) {
        self.roomData = data
        super.init(nibName: nil, bundle: nil)
        setDetailPageRepositoryDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDetailPageDatasource()
        self.setDetailPageCollectionView()
        self.setToolbar()
        self.setBackButton()
        self.setMoreButtonNotification()
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
    
    func setDetailPageDatasource() {
        guard let data = roomData else { return }
        self.detailPageDataSource = DetailPageCollectionDataSource(data: data)
    func setDetailPageRepositoryDelegate() {
        repository.delegate = self
    }
    
    func setDetailPageCollectionView() {
        guard let dataSource = self.detailPageDataSource else { return }
        self.detailPageCollectionView.collectionView.delegate = self
        self.detailPageCollectionView.setDataSource(dataSource)
        self.view.addSubview(detailPageCollectionView)
    }
    
    func setToolbar() {
        navigationController?.navigationBar.isHidden = true
        self.toolBarView.delegate = self

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
        
        if #available(iOS 14.0, *) {
            backButton.addAction(UIAction(handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }), for: .touchDown)
        } else {
            backButton.addTarget(self, action: #selector(touchedBackButton), for: .touchDown)
        }
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc
    func touchedBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setMoreButtonNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectMoreButton), name: NSNotification.Name(rawValue: "moreButton"), object: nil)
    }
    
    @objc
    func didSelectMoreButton() {
        self.detailPageDataSource?.toggleIsShowMore()
        
        DispatchQueue.main.async {
            self.detailPageCollectionView.collectionView.reloadSections(IndexSet(integer: IndexSet.Element(bitPattern: 3)))
        }
    }
}

extension DetailPageViewController: ReserveToolBarDelegate {
    
    func didSelectReserveButton() {
        print("예약 완료")
    }
}

extension DetailPageViewController: DetailPageRepositoryDelegate {
    func didFetchData(_ data: DetailRoomInfo) {
        detailPageDataSource.data = data
        DispatchQueue.main.async {
            self.detailPageCollectionView.collectionView.reloadData()
        }
    }
}
