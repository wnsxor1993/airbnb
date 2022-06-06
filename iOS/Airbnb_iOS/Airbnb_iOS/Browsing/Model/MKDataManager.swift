//
//  SearchCompletionManager.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/06/02.
//

import MapKit

final class MKDataManager {
    
    private(set) var searchCompleter = MKLocalSearchCompleter()
    private(set) var searchResults = [MKLocalSearchCompletion]()
    
    init() {
        self.setCompleter()
    }
    
    func updateQuearyFragment(text: String) {
        self.searchCompleter.queryFragment = text
    }
    
    func updateResults(input: [MKLocalSearchCompletion]) {
        self.searchResults = input
    }
    
    func setDelegate(viewController: UIViewController) {
        guard let delegateVC = viewController as? MKLocalSearchCompleterDelegate else { return }
        self.searchCompleter.delegate = delegateVC
    }

    func getCoordinate(path: IndexPath, handler: @escaping (Result<CLLocationCoordinate2D, MKDataError>) -> Void) {
        let selectedResult = searchResults[path.item]
        let searchRequest = MKLocalSearch.Request(completion: selectedResult)
        let localSearch = MKLocalSearch(request: searchRequest)
        
        localSearch.start { response, error in
            guard error == nil else {
                return handler(.failure(.unknown))
            }
            guard let placeMark = response?.mapItems[0].placemark else {
                return handler(.failure(.notConverted))
            }
            
            let coordinate = placeMark.coordinate
            
            handler(.success(coordinate))
        }
    }
}

private extension MKDataManager {
    
    func setCompleter() {
        self.searchCompleter.pointOfInterestFilter = .init(including: [.park, .university, .publicTransport])
        self.searchCompleter.resultTypes = MKLocalSearchCompleter.ResultType([.address, .pointOfInterest])
    }
}

enum MKDataError: Error {
    case notConverted
    case unknown
}
