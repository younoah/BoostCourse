//
//  ViewController.swift
//  Networking
//
//  Created by uno on 2020/10/02.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "friendCell"
    var friend: [Friend] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let url: URL = URL(string: "https://randomuser.me/api/?results=20&inc=name,email,picture") else {return}
        
        let session: URLSession = URLSession(configuration: .default)
        
        // 데이터태스크를 만들때 URL로 요청 할것이고 뒤에 클로저는 서버에서 응답이 왔을때 호출될 클로저이다.
        // 네트워크 통신을 통해 데이터작업을 할때는 많은 양의 데이터가 있을수 있기 때문에
        // 아래의 클로저는 메인쓰레드에서 작동하지 않는다. 즉. 백그라운드에서 클로저가 실행이된다.
        // 테이블뷰를 리로드할때는 메인쓰레드에서 작업을 해주어야 하기 때문에 디스패치큐를 통해 메인스레드에서 작업을 해주어야한다.
        // 또한 아래 테이블뷰데이터소스에서 셀의 이미지를 받아오는 DATA()메서드가 동기메서드(코드)로 작성되었기 때문에
        // 테이블뷰를 스크롤할 때마다 이미지를 받아오는 시간 때문에 화면이 끊기는 현상(프리징)이 발생한다.
        
        // dataTask.resume()에서 실제로 데이터태스크를 실행하고 서버에 요청을 보낸다.
        // 즉, 아래의 클로저는 지금 당장 실행하는 코드가 아니고 요청에 대한 응답이 왔을때 실행할 코드이다.
        // 따라서 실제로 실행하는 코드는
        // (위에)session만들기 / dataTask만들기 / dataTask실행하기( dataTask.resume() )
        // 이렇게 3가지 동작이 viewDidAppear에서 실행되는 동작이다.
        let dataTask: URLSessionDataTask = session.dataTask(with: url) {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {return}
            
            do {
                let apiResponse: APIResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                self.friend = apiResponse.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch(let err) {
                print(err.localizedDescription)
            }
        }
        dataTask.resume()
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friend.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let friend: Friend = self.friend[indexPath.row]
        
        cell.textLabel?.text = friend.name.full
        cell.detailTextLabel?.text = friend.email
        cell.imageView?.image = nil
        
        // 셀의 이미지를 받아오는 DATA()메서드가 동기메서드(코드)로 작성되었기 때문에
        // 테이블뷰를 스크롤할 때마다 이미지를 받아오는 시간 때문에 화면이 끊기는 현상(프리징)이 발생한다.
        // 이 문제를 해결하기 위해 디스패치큐의 글로벌 즉, 백그라운드 임의 공간에서 비동기(async)로 등록하여 실행한다.
        // 그리고 나서 이미지뷰에 이미지를 더하는 작업은 즉, 뷰와 관련된 작업은 메인쓰레드에서 해야하기 때문에
        // 메인쓰레드로 가지고 와서 작업은 이어간다.
        
        // guard let imageURL: URL = URL(string: friend.picture.thumbnail) else { return }
        // guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
        // 원래는 위의 코드와 같이 이미지url과 데이터를 가드렛하는 구문에 뒤가 { return cell }이었는데
        // 이미지를 다운받는 동안 사용자가 테이블 화면을 위아래로 스크롤을 할수도 있다.
        // 이때 셀의 인덱스가 바뀌게 된다. 즉, 다른 위치에 가 있는 셀이 되어있는 상황이 될수도 있다.
        // 다시 정리하자면 현재 인덱스의 셀이 이미지 세팅(다운로드)을 시작하고 작업하는도중
        // 작업이 끝나기 전에 사용자가 스크롤을 해버리면 인덱스가 바뀌어 버려 문제가 발생한다.
        // 따라서 이미지 세팅 작업을 시작할때와 끝날때의 셀의 인덱스를 구해서 일치할때 이미지 세팅작업을 완료해야한다.
        // 이를위해 메인쓰레드에서 아래와 같이 작업을 추가해주자.
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: friend.picture.thumbnail) else { return }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                // 정의한 테이블뷰의 인덱스를 현재 cell 대하여 불러온다.
                if let index: IndexPath = tableView.indexPath(for: cell) {
                    // 만약 cell 대한 인덱스가 현재의 테이블뷰의 셀을 그리는 인덱스와 같을떄 이미지를 입힌다.
                    if index.row == indexPath.row {
                        cell.imageView?.image = UIImage(data: imageData)
                        // 아래 코드를 작성하면 처음에 셀의 이미지가 안불러와지는 것이 해결이 된다.
                        // 누군가 댓글로 제보해줌
                        cell.setNeedsLayout()
                        cell.layoutIfNeeded()
                    }
                }
            }
        }
        
        
        return cell
    }
    
    
}
