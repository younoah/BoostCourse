# BoostCourse

## 찾아보기

- 퀵헬프, 점프투데피니션, 개발자문서(레퍼런스) 활용방법
  
  - https://www.edwith.org/boostcourse-ios/lecture/16883/ (첫번째 영상 참고)
  
- 사용자 정보 보안 승인 (info.plist)
  - 예) 사진첩에 접근 허용 요청하기
  - 이런 사용자 정보에 접근할때 세팅하지 않으면 앱스토어에 반려사유가 된다.
  - https://www.edwith.org/boostcourse-ios/lecture/16883/ (두전째 영상 참고)
  
- ARC Retina Cycle - week, strong
  
  - https://shark-sea.kr/entry/iOS-ARC-strong-weak-unowned
  
- 지역변수, 전역변수
  
  - self를 언제 사용해야하나
  
- 뷰의 제약 조건 확실하게 잡기

- 화면전화에서 나타내기 vs 보여주기 개념은 모달에서만인가? 아니면 내비게이션에서도인가? 아니면 뷰컨 전체 화면 띄우는 방식에서인가?

- 타입캐스팅 

  - 테이블뷰 cellForRowAt 델리게이트 메서드 생성시 

    ```swift
    // 강제 캐스팅
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    				let cell = tableView.dequeueReusableCell(withIdentifier: "zeddCell", for: indexPath) as! MyTableViewCell
            return cell
        }
    
    // gaurd let 구문
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: MovieTableViewCell.self),
                    for: indexPath) as? MovieTableViewCell else {
                    return UITableViewCell()
                }
            return cell
        }
    ```

    

## week1

- 인터페이스 빌더의 객체를 코드와 연결
  - IBOutlet
  - IBAction
- Cocoa Touch
  - UIKit
    - Foundation
    - UIControl
    - UIButton
    - UILabel
    - UISlider
  - AVFoundation
    - AVAudioPlayer
    - Timer
- 오토레이아웃
  - 코드구현
  - 인터페이스빌더
- iOS 뷰의 체계
- 디자인패턴
  - MVC패턴

## week2

- 화면전환
  - 내비게이션
  - 모달
- 뷰 라이프 사이클
- 델리게이션 (디자인패턴)
  - 델리게이트
- 싱글턴 (디자인패턴)
- 타겟-액션 (디자인패턴)
- 제스처 인식기

### 새로 배우는 내용

- Design Patterns
  - Delegation Pattern
  - Singleton
  - Target-Action
- View Transition
  - Navigation Interface
  - Modality
- UIKit
  - UITextField
  - UIDatePicker
  - UIStackView
  - UIImagePickerController
  - UINavigationController
  - UIGestureRecognizer
  - View Controller States Methods
- Foundation
  - DateFormatter
- Swift
  - Dictionary의 활용
  - guard 구문의 활용