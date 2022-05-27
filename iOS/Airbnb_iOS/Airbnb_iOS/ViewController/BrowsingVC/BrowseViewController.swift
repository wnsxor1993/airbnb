//
//  BrowseViewController.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/05/24.
//

import UIKit
import MapKit

class BrowseViewController: UIViewController {

    private let findAccomodationVC = FindAccomodationViewController()
    
    private let famousSpotDataSource = FamousSpotCollectionDataSource()
    private let browsingSpotDataSource = BrowsingSpotCollectionDataSource()
    private lazy var famousSpotCollectionView = FamousSpotCollectionView(frame: view.frame)
    private lazy var browsingSpotCollectionView = BrowsingSpotCollectionView(frame: view.frame)
    private var searchBarVC: UISearchController = {
        let searcher = UISearchController(searchResultsController: nil)
        searcher.searchBar.showsCancelButton = false
        searcher.hidesNavigationBarDuringPresentation = false
        searcher.searchBar.placeholder = "어디로 여행가세요?"
        return searcher
    }()

    private var searchCompleter = MKLocalSearchCompleter()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationItem()
        self.setSearchBar()
        self.setTouchCollectionViewToDismissKeyboard()

        self.searchCompleter.delegate = self
        self.searchCompleter.resultTypes = .address

        self.famousSpotCollectionView.setDataSource(famousSpotDataSource)
        self.famousSpotCollectionView.collectionView.keyboardDismissMode = .onDrag
        
        self.browsingSpotCollectionView.setDataSource(browsingSpotDataSource)
        self.browsingSpotCollectionView.collectionView.keyboardDismissMode = .onDrag
        self.browsingSpotCollectionView.collectionView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.browsingSpotCollectionView.removeFromSuperview()
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.hidesBarsOnSwipe = false
        self.view.addSubview(famousSpotCollectionView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.searchBarVC.isActive = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.searchBarVC.searchBar.text = ""
    }
}

extension BrowseViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText != "" else {
            browsingSpotDataSource.removeAllResults()
            DispatchQueue.main.async {
                self.browsingSpotCollectionView.collectionView.reloadData()
            }
            return
        }

        self.view.addSubview(browsingSpotCollectionView)
        self.famousSpotCollectionView.removeFromSuperview()
        searchCompleter.queryFragment = searchText
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
        browsingSpotDataSource.inputMKLocalSearchResults(input: completer.results)
        DispatchQueue.main.async {
            self.browsingSpotCollectionView.collectionView.reloadData()
        }
    }
}

extension BrowseViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.searchBarVC.searchBar.endEditing(true)
        self.navigationController?.pushViewController(findAccomodationVC, animated: true)
    }
}

private extension BrowseViewController {

    func setNavigationItem() {
        self.navigationItem.title = "숙소 찾기"
        self.navigationItem.backButtonTitle = "뒤로"
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
}
