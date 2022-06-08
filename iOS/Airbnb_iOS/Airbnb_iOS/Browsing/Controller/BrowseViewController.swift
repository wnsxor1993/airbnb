//
//  BrowseViewController.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/05/24.
//

import UIKit
import MapKit

class BrowseViewController: UIViewController {
    
    private let famousSpotDataSource = FamousSpotCollectionDataSource()
    private let browsingSpotDataSource = BrowsingSpotCollectionDataSource()
    private lazy var browsingSpotCollectionView = BorwsingSpotCollectionView(frame: view.frame)
    private lazy var rightBarItem: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "지우기", style: .plain, target: self, action: #selector(clearSearchingText))
        return button
    }()

    private var searchBarVC: UISearchController = {
        let searcher = UISearchController(searchResultsController: nil)
        searcher.searchBar.showsCancelButton = false
        searcher.hidesNavigationBarDuringPresentation = false
        searcher.searchBar.placeholder = "어디로 여행가세요?"
        return searcher
    }()

    private var searchDataManager = MKDataManager()

    init(famousSpotData: [HomeViewComponentsData.AroundSpotData]) {
        super.init(nibName: nil, bundle: nil)
        famousSpotDataSource.data = famousSpotData
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureAllInitialSettings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeCollectionViewToDefaultView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.searchBarVC.isActive = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.searchBarVC.searchBar.text = ""
        self.searchBarVC.isActive = false
    }
}

extension BrowseViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            DispatchQueue.main.async {
                self.browsingSpotCollectionView.collectionView.reloadData()
            }
            return
        }

        self.changeCollectionViewToSearchingView()
        searchDataManager.updateQuearyFragment(text: searchText)
    }
}

extension BrowseViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            self.searchBarVC.searchBar.becomeFirstResponder()
        }
    }
}

extension BrowseViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchDataManager.updateResults(input: completer.results)
        DispatchQueue.main.async {
            self.browsingSpotCollectionView.collectionView.reloadData()
        }
    }
}

extension BrowseViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.searchBarVC.searchBar.endEditing(true)
        
        if self.browsingSpotCollectionView.isBrowsing {
            searchDataManager.getCoordinate(path: indexPath, handler: { [weak self] result in
                switch result {
                case .success(let coordinate):
                    let locationName = self?.searchDataManager.searchResults[indexPath.item].title
                    let locationData = AccomodationData.location(.init(name: locationName, latitude: coordinate.latitude, longitude: coordinate.longitude))

                    DispatchQueue.main.async {
                        let decidingOptionsVC = DecidingOptionsViewController()
                        decidingOptionsVC.setLocationData(locationData)
                        self?.navigationController?.pushViewController(decidingOptionsVC, animated: true)
                    }
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
}

// MARK: Configure All Initial setting

private extension BrowseViewController {

    func configureAllInitialSettings() {
        self.setNavigationItem()
        self.setSearchBar()
        self.setTouchCollectionViewToDismissKeyboard()
        self.setDataManager()
        self.setBrowsingCollectionView()
    }
    
    func setNavigationItem() {
        self.navigationItem.title = "숙소 찾기"
        self.navigationItem.backButtonTitle = "뒤로"
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.hidesBarsOnSwipe = false
    }

    func setSearchBar() {
        self.searchBarVC.delegate = self
        self.searchBarVC.searchBar.delegate = self
        self.navigationItem.searchController = searchBarVC
    }

    func setTouchCollectionViewToDismissKeyboard() {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(myTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(singleTapGestureRecognizer)
    }

    @objc
    func myTapMethod(sender: UITapGestureRecognizer) {
        self.searchBarVC.searchBar.endEditing(true)
    }
    
    func setDataManager() {
        self.searchDataManager.setDelegate(viewController: self)
        self.browsingSpotDataSource.connectDataManager(manager: self.searchDataManager)
    }
    
    func setBrowsingCollectionView() {
        self.browsingSpotCollectionView.collectionView.keyboardDismissMode = .onDrag
        self.browsingSpotCollectionView.collectionView.delegate = self
        self.view.addSubview(browsingSpotCollectionView)
    }
}

// MARK: Configure changing collectionView layout and dataSource

private extension BrowseViewController {
    
    func changeCollectionViewToSearchingView() {
        self.browsingSpotCollectionView.startToSearch()
        self.setCollectionViewDataSource()
        self.navigationItem.rightBarButtonItem = self.rightBarItem
    }
    
    func changeCollectionViewToDefaultView() {
        self.browsingSpotCollectionView.stopToSearch()
        self.setCollectionViewDataSource()
        self.navigationItem.rightBarButtonItem = nil
    }
    
    func setCollectionViewDataSource() {
        switch browsingSpotCollectionView.isBrowsing {
        case true:
            self.browsingSpotCollectionView.setDataSource(browsingSpotDataSource)
        case false:
            self.browsingSpotCollectionView.setDataSource(famousSpotDataSource)
        }
    }
    
    @objc
    func clearSearchingText(_ sender: Any) {
        self.searchBarVC.searchBar.text = ""
    }
}
