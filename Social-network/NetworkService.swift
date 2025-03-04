//
//  NetworkService.swift
//  Social-network
//
//  Created by Даша Николаева on 04.03.2025.
//

import Alamofire
import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> ())
    func fetchImage(url: String, completion: @escaping (Result<Data, Error>) -> ())
}

class NetworkService {
    static let shared = NetworkService(); private init() {}
    
    func fetchData<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> ()) {
        AF.request(url).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
            
        }
    }
    
    func fetchImage(url: String, completion: @escaping (Result<Data, Error>) -> ()) {
        AF.request(url).validate().responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
