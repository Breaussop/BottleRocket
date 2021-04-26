//
//  Network.swift
//  BottleRocket
//
//  Created by Kenneth Adams on 4/15/21.
//

import UIKit

final class NetworkManager {
    static var shared = NetworkManager()
    var session: URLSession
    
    private init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}

extension NetworkManager {
    
    func fetchData<T: Decodable> (url:String, completion: @escaping (Result<T, MyError>) -> ()) {
        guard let url = URL(string: url) else {return}
        session.dataTask(with: url) { (data, result, error) in
            guard let data = data else {completion(.failure(.dataError));return}
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
    
    func fetchImage (url:String, completion: @escaping (Result<UIImage, MyError>) -> ()) {
        guard let url = URL(string: url) else {return}
        session.dataTask(with: url) { (data, result, error) in
            guard let data = data else {completion(.failure(.dataError));return}
            guard let resultImage = UIImage(data: data) else {return}
            completion(.success(resultImage))
        }.resume()
    }
    
}
enum MyError: String, Error {
    case urlError = "url error has occured"
    case dataError = "problem when decoding Data"
    case normError = "An error occured"
}
