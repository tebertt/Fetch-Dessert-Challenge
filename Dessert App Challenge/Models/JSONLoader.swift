//
//  JSONLoader.swift
//  Dessert App Challenge
//
//  Created by Troy Ebert on 11/9/23.
//

import Foundation

class JSONLoader {
    
    private func decode<T: Codable>(data: Data) -> T? {
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
    
    func doRequest<T: Codable>(request: RequestBuilder) async -> Result<T, Error> {
        
        let task = URLSession.shared
        do {
            let (data, urlResponse) = try await task.data(for: request.getRequest())
            let response = urlResponse as! HTTPURLResponse
            
            if (200...299).contains(response.statusCode) {
                
                guard let record: T = decode(data: data) else {
                    return .failure(ServerError.requestFailure(message: "Failure to decode JSON"))
                }
                
                return .success(record)
                
            } else {
                
                let errorString = String(data: data, encoding: .utf8) ?? "A parsing error occurred"
                return .failure(ServerError.requestFailure(message: "HTTP Error \(response.statusCode): \(errorString)"))
                
            }
        }
        catch let error as NSError {
            return .failure(ClientError.runtimeError(message: "\(error.localizedDescription)"))
        }
    }
}
