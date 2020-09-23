//
//  ViewController.swift
//  SimpleTable
//
//  Created by uno on 2020/09/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "cell"
    let customCellIdentifier: String = "customCell"
    
    let korean: [String] = ["가", "나 ", "다", "라","마", "바", "사", "아", "자", "차", "타", "카", "파", "하"]
    let english: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    var dates: [Date] = []
    // 데이트포매터 변수
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    // 타임포메터 변수
    let timeFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let nibName = UINib(nibName: "CustomTableViewCell", bundle: nil)
        self.tableView.register(nibName, forCellReuseIdentifier: customCellIdentifier)
    }
    
    //MARK:- 액션 메서드
    @IBAction func touchUpAddButton(_ sender: UIButton){
        dates.append(Date())
        
        // 아래 코드는 테이블 뷰 전체를 다시 불러오기  때문에 비효율적
        //tabelView.reloadData()
        
        // 아래 코드로 새로운 섹션만 다시 불러오고 애니메이션 효과(자동) 추가
        tableView.reloadSections(IndexSet(2...2),
                                 with: UITableView.RowAnimation.automatic)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return korean.count
        case 1:
            return english.count
        case 2:
            return dates.count
        default:
            return 0
        }
    }
    
    // 행마다 해당하는 "셀"을 반환
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section < 2 {
            // tableView.dequeueReusableCell : "재사용 셀"
            // UITableViewCell() : "새로운 셀" 생성 -> 메모리를 많이 사용하게 되니 주의 해야한다.
            let cell: UITableViewCell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath)
            
            let text: String = indexPath.section == 0 ? korean[indexPath.row] : english[indexPath.row]
            cell.textLabel?.text = text
            
            return cell
        } else {
            let cell: CustomTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: customCellIdentifier,
            for: indexPath) as! CustomTableViewCell // 강제 타입 캐스팅 -> 더 좋은 방법은??
            
            // 아래 코드는 셀의 기본 형태
            //cell.textLabel?.text = dateFormatter.string(from: dates[indexPath.row])
            
            // 셀 커스터마이징 방식으로 만든 셀의 레이블 아웃렛 변수
            cell.leftLabel.text = dateFormatter.string(from: dates[indexPath.row])
            cell.rightLabel.text = timeFormatter.string(from: dates[indexPath.row])
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < 2{
            return section == 0 ? "한글" : "영어"
        } else {
            return nil
        }
        
    }
    
    // 세그를 통한 화면전환시 다음화면으로 데이터 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController : DetailViewController = segue.destination as? DetailViewController else {
            return
        }
        
        guard let cell: UITableViewCell = sender as? UITableViewCell else {
            return
        }
        
        // 다음 화면으로 데이터를 넘길때 다음 화면의 뷰컨트롤러의 변수에 담아서 보내줘야한다.
        nextViewController.textToSet = cell.textLabel?.text
        
        // 현재 다음화면의 뷰컨트롤러는 prepare(준비)상태 이므로
        // 아래처럼 다음화면의 뷰컨트롤러의 UILabel 같은 뷰요소는 아직 생성이 되지 않은 상태라 오류가난다.
        // nextViewController.textLabel.text = cell.text
    }

}

