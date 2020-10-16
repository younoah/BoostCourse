//
//  AlertController.swift
//  BoxOffice
//
//  Created by uno on 2020/10/16.
//

import Foundation
import UIKit

class MovieSortActionSheet {
    static func touchUpShowActionSheetButton(_ viewController: UIViewController) {
        let alertController = UIAlertController(title: "정렬방식 선택", message: "영화를 어떤 순서로 정렬할까요?", preferredStyle: .actionSheet)

        let reservationRateAction = UIAlertAction(title: "예매율", style: UIAlertAction.Style.default) {
            (action : UIAlertAction) in
            viewController.navigationItem.title = "예매율"
            MovieSort.shared.orderTypeNumber = 0
            API.getMovies(orderType: MovieSort.shared.orderTypeNumber)
        }

        let currationAction = UIAlertAction(title: "큐레이션", style: UIAlertAction.Style.default) {
            (action : UIAlertAction) in
            viewController.navigationItem.title = "큐레이션"
            MovieSort.shared.orderTypeNumber = 1
            API.getMovies(orderType: MovieSort.shared.orderTypeNumber)
        }

        let openingDay = UIAlertAction(title: "개봉일", style: UIAlertAction.Style.default) {
            (action : UIAlertAction) in
            viewController.navigationItem.title = "개봉일"
            MovieSort.shared.orderTypeNumber = 2
            API.getMovies(orderType: MovieSort.shared.orderTypeNumber)
        }

        let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)

        alertController.addAction(reservationRateAction)
        alertController.addAction(currationAction)
        alertController.addAction(openingDay)
        alertController.addAction(cancelAction)

        viewController.present(alertController, animated: true)
    }
}

