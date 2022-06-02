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
    
    func getQuearyFragment(text: String) {
        self.searchCompleter.queryFragment = text
    }
    
    func getResults(input: [MKLocalSearchCompletion]) {
        self.searchResults = input
    }
    
    func setDelegate(viewController: UIViewController) {
        guard let delegateVC = viewController as? MKLocalSearchCompleterDelegate else { return }
        self.searchCompleter.delegate = delegateVC
    }

}

private extension MKDataManager {
    
    func setCompleter() {
        self.searchCompleter.pointOfInterestFilter = .excludingAll
        self.searchCompleter.pointOfInterestFilter = .init(including: [.park, .university, .publicTransport])
        self.searchCompleter.resultTypes = MKLocalSearchCompleter.ResultType([.address, .pointOfInterest])
    }
}
