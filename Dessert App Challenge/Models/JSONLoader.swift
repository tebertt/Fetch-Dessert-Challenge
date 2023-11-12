//
//  JSONLoader.swift
//  Dessert App Challenge
//
//  Created by Troy Ebert on 11/9/23.
//

import Foundation

class JSONLoader {
    
    // Decode generalized JSON
    func decode<T: Codable>(data: Data) -> T? {
        let decoder = JSONDecoder()
        var decodedValue: T?

        do {
            decodedValue = try decoder.decode(T.self, from: data)
        } catch DecodingError.dataCorrupted(let context) {
            print("\(context)")
        } catch let error {
            switch error {
            case DecodingError.dataCorrupted(let context):
                print("\(context)")
            default:
                print("\(error)")

            }
        }

        return decodedValue
    }
    
    // Handle requesst
    func doRequest<T: Codable>(request: RequestBuilder) async -> Result<T, Error> {
        
        // Send HTTP request
        let sesh = URLSession.shared
        do {
            let (data, urlResponse) = try await sesh.data(for: request.getRequest())
            let response = urlResponse as! HTTPURLResponse
            
            // If success
            if 199 < response.statusCode || response.statusCode < 300  {
                
                guard let record: T = decode(data: data) else {
                    // If failed to decode
                    return .failure(ServerError.requestFailure(message: "Failure to decode JSON"))
                }
                
                return .success(record)
            
            // If sends API failure
            } else {
                
                let errorString = String(data: data, encoding: .utf8) ?? "A parsing error occurred"
                return .failure(ServerError.requestFailure(message: "HTTP Error \(response.statusCode): \(errorString)"))
                
            }
        }
        // Failed to get response from API
        catch let error as NSError {
            return .failure(ClientError.runtimeError(message: "\(error.localizedDescription)"))
        }
    }
}
