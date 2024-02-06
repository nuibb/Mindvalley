//
//  RequestError.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import Foundation

enum RequestError: Error, CustomStringConvertible {
    case encode
    case decode
    case invalidURL
    case requestFailed
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case networkNotAvailable
    case custom(String)
    case unknown
    
    var description: String {
        switch self {
        case .encode:
            return "An error occurred while encoding the request data."
        case .decode:
            return "An error occurred while decoding the response data."
        case .invalidURL:
            return "The provided URL is not valid."
        case .requestFailed:
            return "The API request failed. Please try again later."
        case .noResponse:
            return "The API response timed out. Please check your internet connection and try again."
        case .unauthorized:
            return "Your session has expired. Please log in again."
        case .unexpectedStatusCode:
            return "Received an unexpected status code from the server."
        case .networkNotAvailable:
            return "You are in offline mode. Please connect to the internet to proceed."
        case .custom(let message):
            return message
        default:
            return "An unknown error occurred."
        }
    }
}

