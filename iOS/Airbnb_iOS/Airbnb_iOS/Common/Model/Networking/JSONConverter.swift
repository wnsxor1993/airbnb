//
//  JSONConverter.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/06/06.
//

import Foundation

final class JSONConverter {
    
    static func decodeJsonObject<T: Codable>(data: Data) -> T? {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch {
            guard let error = error as? DecodingError else { return nil }
            
            switch error {
            case .dataCorrupted(let context):
                print(context.codingPath, context.debugDescription, context.underlyingError ?? "", separator: "\n")
                return nil
            default:
                return nil
            }
        }
    }
    
    static func encodeJsonObject<T: Codable>(param: T) -> Data? {
        do {
            let result = try JSONEncoder().encode(param)
            return result
        } catch {
            return nil
        }
    }
}
