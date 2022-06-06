//
//  AlamofireNet.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/06/06.
//

import Alamofire

struct AlamofireNet {
    
    func getNetwork<T: Codable>(url: String, completion handler: @escaping (T?) -> Void) {
        guard let validURL = URL(string: url) else { return }
        
        let validRequest = AF.request(validURL, method: .get).validate(statusCode: 200..<300)
        
        validRequest.response { response in
            switch response.result {
            case .success(let value):
                guard let validValue = value else { return }
                
                let decodedValue: T? = JSONConverter.decodeJsonObject(data: validValue)
                
                handler(decodedValue)
                
            case .failure(_):
                return
            }
        }
    }
}
