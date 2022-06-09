//
//  AlamofireNet.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/06/06.
//

import Alamofire

struct AlamofireNet {
    
    func connectNetwork(url: String, method: Alamofire.HTTPMethod, param: Parameters?, encode: URLEncoding, completion handler: @escaping (Result<Data, AFError>) -> Void) {
        guard let validURL = URL(string: url) else { return }
        
        let validRequest = AF.request(validURL, method: method, parameters: param, encoding: encode).validate(statusCode: 200..<300)
        
        validRequest.response { response in
            switch response.result {
            case .success(let value):
                guard let validValue = value else { return }
                
                handler(.success(validValue))
                
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}
