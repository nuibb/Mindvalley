//
//  HttpClient.swift
//  MindvalleyDemo
//
//  Created by Nurul Islam on 6/2/24.
//

import Foundation

protocol HTTPClient {
    var networkMonitor: NetworkMonitor { get }
    func upload(for url: String) async -> Swift.Result<Bool, RequestError>
    func download(for url: String) async -> Swift.Result<Bool, RequestError>
    func getRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Swift.Result<T, RequestError>
    func postRequest<T1: Decodable, T2: Encodable>(endpoint: Endpoint, payload: T2, responseModel: T1.Type) async -> Swift.Result<T1, RequestError>
}

extension HTTPClient {
    
    func upload(for url: String) async -> Swift.Result<Bool, RequestError> {
        return .failure(.unknown)
    }
    
    func download(for url: String) async -> Swift.Result<Bool, RequestError> {
        return .failure(.unknown)
    }
    
    func getRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Swift.Result<T, RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        Logger.log(type: .info, "[URL] absoluteString: \(url.absoluteString)")
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request) //.data(from: url)
            return decode(data: data, response: response)
        } catch (let error ) {
            Logger.log(type: .error, "[API][Request] failed: \(error.localizedDescription)")
            return .failure(.requestFailed)
        }
    }
    
    func postRequest<T1: Decodable, T2: Encodable>(endpoint: Endpoint, payload: T2, responseModel: T1.Type) async -> Swift.Result<T1, RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        Logger.log(type: .info, "[URL][Path]: \(url.absoluteString)")
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let payload = try? encoder.encode(payload) else {
            return .failure(.encode)
        }
        
        Logger.log(type: .info, "[API][Payload]: \(String(data: payload, encoding: .utf8) ?? "Invalid Payload")")
        
        do {
            let (data, response) = try await URLSession.shared.upload(for: request, from: payload)
            Logger.log(type: .error, "[API][Response]: \(response)")
            return decode(data: data, response: response)
        } catch (let error ) {
            Logger.log(type: .error, "[API][Request] failed: \(error.localizedDescription)")
            return .failure(.requestFailed)
        }
    }
    
    private func decode<T: Decodable>(data: Data, response: URLResponse) -> Swift.Result<T, RequestError> {
        guard let response = response as? HTTPURLResponse else {
            return .failure(.noResponse)
        }
        
        switch response.statusCode {
        case 200...299:
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                return .failure(.decode)
            }
            return .success(decodedResponse)
        case 401:
            return .failure(.unauthorized)
        default:
            return .failure(.unexpectedStatusCode)
        }
    }
}

