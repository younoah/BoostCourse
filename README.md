# BoostCourse

## 찾아보기

- 파일, 폴더 명명법 (in ios, django)
  
- 퀵헬프, 점프투데피니션, 개발자문서(레퍼런스) 활용방법
  
  - https://www.edwith.org/boostcourse-ios/lecture/16883/ (첫번째 영상 참고)
  
- 사용자 정보 보안 승인 (info.plist)
  - 예) 사진첩에 접근 허용 요청하기
  - 이런 사용자 정보에 접근할때 세팅하지 않으면 앱스토어에 반려사유가 된다.
  - https://www.edwith.org/boostcourse-ios/lecture/16883/ (두전째 영상 참고)
  
- ARC Retina Cycle - week, strong
  
  - https://shark-sea.kr/entry/iOS-ARC-strong-weak-unowned
  
- private, lazy변수

- override func

- _(언더바) 변수 선언

  ```swift
  // ex 
  _ picker: UIImagePickerController,
          didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          
          if let image:UIImage =  info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
              self.userImageView.image = image
          }
  ```

- 지역변수, 전역변수

  - self를 언제 사용해야하나

- 디버깅 방법 / 오류잡는 방법

- 오토레이아웃 (뷰의 제약 조건 확실하게 잡기)

  - 디버깅 방법
  - 키보드 올릴때 오류 (signup project)
  - 테이블뷰(셀) 넘길때 오류

- 화면전화에서 나타내기 vs 보여주기 개념은 모달에서만인가? 아니면 내비게이션에서도인가? 아니면 뷰컨 전체 화면 띄우는 방식에서인가?

- 옵셔널 if let, guard let, / do-catch / 타입 캐스팅 확실하게 잡기

- 클로저

- 타입캐스팅 

  - 테이블뷰 cellForRowAt 델리게이트 메서드 생성시 

    ```swift
    // 강제 캐스팅
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    				let cell: CityTableViewCell = tableView.dequeueReusableCell(
              withIdentifier: cellIdentifier, 
              for: indexPath) as! CityTableViewCell
            return cell
        }
    
    // gaurd let 구문
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell: CityTableViewCell = tableView.dequeueReusableCell(
                    withIdentifier: cellIdentifier,
                    for: indexPath) as? CityTableViewCell else {
                return UITableViewCell()
            }
      
          return cell
        }
    ```

- 이미지 피커 뜯어보기

## 옵셔널 바인딩 & 타입 캐스팅

- 옵셔널 바인딩

  - if-let
  - gurad-let

- 타입검사 (타입 확인) : is

- 타입 캐스팅 (타입 변환) : 주로 클래스의 인스턴스에서 형변환할 때 많이 사용된다. (또는 딕셔너리, any anyobject타입을 많이 사용할떄 쓴다고한다.?)

  - as 업 캐스팅(많이 사용 안한다.) : 해당 인스턴스가 부목 클래스의 인스턴스로 사용할 수 있도록 한다. 너무나 당연한 일반적인 타입변환

  - 다운 캐스팅 : 해당 인스턴스가 자식 클래스의 인스턴스로 사용할 수 있도록 한다.

    - 조건부 다운 캐스팅 as? (반환타입: 옵셔널)

      ```swift
      class Person {
          var name: String = ""
          func breath() {
              print("숨을 쉽니다")
          }
      }
      
      class Student: Person {
          var school: String = ""
          func goToSchool() {
              print("등교를 합니다")
          }
      }
      
      class UniversityStudent: Student {
          var major: String = ""
          func goToMT() {
              print("멤버쉽 트레이닝을 갑니다 신남!")
          }
      }
      // UniversityStudent 인스턴스를 생성하여 Person 행세를 할 수 있도록 업 캐스팅
      var mike: Person = UniversityStudent() as Person
      
      var jenny: Student = Student()
      //var jina: UniversityStudent = Person() as UniversityStudent // 컴파일 오류
      
      // UniversityStudent 인스턴스를 생성하여 Any 행세를 할 수 있도록 업 캐스팅
      var jina: Any = Person() // as Any 생략가능
      var optionalCasted: Student?
      
      // mike는 Person 타입이어도 실질적으로 할당된 인스턴스가 UniversityStudent이었기때문에
      // Person 타입이어도 UniversityStudent으로 다운캐스팅이 가능하다.
      optionalCasted = mike as? UniversityStudent
      optionalCasted = jenny as? UniversityStudent // nil
      optionalCasted = jina as? UniversityStudent // nil
      optionalCasted = jina as? Student // nil
      ```

    - 강제 다운 캐스팅 as! (반환타입: 일반타입, 실패시 런타임 오류)

    - if-let-as? : 조건부 다운캐스팅과 동시에 nil반환되지 않도록 하기(?)

  - Any와 AnyObject를 위한 형 변환

- 오류처리

  - do-catch : 캐치해서 에러로 어떤걸 처리해주고싶으면
  - do-try-catch
  - try? : 걍 리턴하고싶으면 try?써서 간단하게
  - try!



예시

```swift
let imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/3/3d/LARGE_elevation.jpg")!
let imageData = try! Data.init(contentsOf: imageURL)
let image: UIImage = UIImage(data: imageData)!
            
self.imageView.image = image

//if-let
if let imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/3/3d/LARGE_elevation.jpg"),
          let imageData = try? Data.init(contentsOf: imageURL), 
					let image = UIImage(data: imageData) {
                self.imageView.image = image
            }

//gurard-let
guard let imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/3/3d/LARGE_elevation.jpg") else { return }
guard let imageData = try? Data.init(contentsOf: imageURL), let image = UIImage(data:imageData) else {return}
            
self.imageView.image = image
```







