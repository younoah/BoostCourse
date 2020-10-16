//
//  API.swift
//  BoxOffice
//
//  Created by uno on 2020/10/16.
//

import Foundation

let DidReceiveMoviesNotification = Notification.Name("DidReceiveMovies")

class API {
    static let baseURL = "https://connect-boxoffice.run.goorm.io/"
    
    // HTTP Request GET Data Method
    // class 선언을 안했다면 그냥 requestGet()사용
    class func requestGet(url: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request, completionHandler: completion)
        dataTask.resume()
    }
    
    // HTTP Request POST Data Method
    class func requestPost(url: String, body: NSMutableDictionary, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            print(error)
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: completion)
        dataTask.resume()
    }
    
    class func getMovies(orderType: Int) {
        // class 선언을 안했다면 그냥 requestGet()사용
        API.requestGet(url: "\(baseURL)/movies?order_type=\(orderType)") {
            (data: Data?, reponse: URLResponse?, error: Error?) in
            if let error = error {
                print(error)
                return
            }
            
            guard let responseData = data else { return }
            
            do {
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: responseData)
                DispatchQueue.main.async {
                    NotificationCenter.default.post(
                        name: DidReceiveMoviesNotification,
                        object: nil,
                        userInfo: ["movies": movieResponse.movies])
                }
            } catch (let error) {
                print(error)
            }
        }
    }
    
}
