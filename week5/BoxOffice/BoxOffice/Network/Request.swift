//
//  Request.swift
//  BoxOffice
//
//  Created by uno on 2020/10/15.
//

import Foundation

let DidReceiveMoviesNotification = Notification.Name("DidReceiveMovies")
let DidReceiveMovieInfoNotification = Notification.Name("DidReceiveMovieInfo")
let DidRecevieCommentsNotification = Notification.Name("DidReceiveComments")
let DidCommentSuccessNotificaion = Notification.Name("DidCommentSuccess")


class API {
    
    let baseURL = "https://connect-boxoffice.run.goorm.io"
    
    //서버에 데이터 요청
    func dataRequest(url: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: url) else { return }
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url, completionHandler: completion)
        dataTask.resume()
    }

    // 영화 리스트 호출
    func requestMovies(_ orderType: Int) {
        dataRequest(url: "\(baseURL)/movies?order_type=\(orderType)") {
            (data: Data?, reponse: URLResponse?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
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
    
    // 영화 상세 정보 호출
    func requestMovieInfo(_ orderType: Int) {
        dataRequest(url: "\(baseURL)/movies?order_type=\(orderType)") {
            (data: Data?, reponse: URLResponse?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
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


