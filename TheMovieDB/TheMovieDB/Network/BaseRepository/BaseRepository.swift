//
//  BaseRepository.swift
//  TheMovieDB
//
//  Created by Fede Flores on 13/03/2024.
//

import Foundation
import Combine

protocol BaseRepositoryProtocol {
    func fetchDecodable<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void)
}

class BaseRepository: BaseRepositoryProtocol {
    
    fileprivate enum Constant {
        static let sesionConfigTimeIntervals: CGFloat = 20.0
    }
    
    private var cancellable = Set<AnyCancellable>()
    let sessionConfig = URLSessionConfiguration.default
    
    init() {
        sessionConfig.timeoutIntervalForRequest = Constant.sesionConfigTimeIntervals
        sessionConfig.timeoutIntervalForResource = Constant.sesionConfigTimeIntervals
    }
        
    func fetchDecodable<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        
        let baseURL = endpoint.baseURL
        guard let baseStringAppended = baseURL.appendingPathComponent(endpoint.path).absoluteString.removingPercentEncoding, let url = URL(string: baseStringAppended)
        else {
            completion(.failure(TMDBError.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        urlRequest.url?.append(queryItems: endpoint.queryItems)
        
        urlRequest.httpMethod = endpoint.method.rawValue
        
        guard let authToken = AppConfigurationManager.shared.getAppConfiguration(with: .ACCESS_TOKEN) else {
            completion(.failure(TMDBError.invalidAPIKey))
            return
        }
        
        urlRequest.setValue(authToken, forHTTPHeaderField: "Authorization")
        
        endpoint.headers?.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }
                        
        URLSession(configuration: sessionConfig)
            .dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .map {
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .sink { resultCompletion in
                switch resultCompletion {
                case .finished:
                    return
                case .failure(let error):
                    completion(.failure(error))
                }
            } receiveValue: {  value in
                completion(.success(value))
            }
            .store(in: &cancellable)
    }
}

