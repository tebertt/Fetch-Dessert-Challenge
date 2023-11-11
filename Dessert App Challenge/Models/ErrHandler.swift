//
//  ErrHandler.swift
//  Dessert App Challenge
//
//  Created by Troy Ebert on 11/9/23.
//

import Foundation

enum ClientError: Error {
    case runtimeError(message: String)
}

enum ServerError: Error {
    case requestFailure(message: String)
}
