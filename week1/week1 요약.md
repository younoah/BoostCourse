## 목차

- [인터페이스 빌더의 객체를 코드와 연결](#인터페이스 빌더의 객체를 코드와 연결)
  - [IBOutlet](#IBOutlet)
  - [IBAction](#IBAction)
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



## 인터페이스 빌더의 객체를 코드와 연결

### IBOutlet

- 인터페이스 빌더의 객체를 코드의 변수로 연결한다.

### IBOutlet 뷰객체 생성 방법

1. 인터페이스 빌더에서 뷰객체를 생성하고 직접연결

2. 코드로 **뷰객체 생성메서드** 구현 : 슈퍼뷰(뷰컨트롤러의 최상위뷰)에 뛰우기

   ```swift
   @IBOutlet var playPauseButton: UIButton!
   
   override func viewDidLoad() {
           super.viewDidLoad()
           self.addPlayPauseButton() // 버튼 뷰객체 생성메서드를 슈퍼뷰가 불러와질 때 실행
       }
   
   func addPlayPauseButton() {
           let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
           button.translatesAutoresizingMaskIntoConstraints = false
   
           self.view.addSubview(button)
           
           button.setImage(UIImage(named: "button_play"), for: UIControl.State.normal)
           button.setImage(UIImage(named: "button_pause"), for: UIControl.State.selected)
           
     			// 뷰 객체와 IBaction 메서드를 연결하기위해 addTarget메서드를 사용한다.
           button.addTarget(self, action: #selector(self.touchUpPlayPauseButton(_:)), for: UIControl.Event.touchUpInside)
           
           let centerX: NSLayoutConstraint
           centerX = button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
           
           let centerY: NSLayoutConstraint
           centerY = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 0.8, constant: 0)
           
           let width: NSLayoutConstraint
           width = button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5)
           
           let ratio: NSLayoutConstraint
           ratio = button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 1)
           
           centerX.isActive = true
           centerY.isActive = true
           width.isActive = true
           ratio.isActive = true
           
           self.playPauseButton = button // IBOutlet과 연결
       }
   ```

### IBAction

- 인터페이스 빌더의 객체에서 발생한 액션과 코드의 메서드로 연결하여 발생한 액션에 따른 동작을 정의할 수 있다.

> UIKit에는 UIButton, UISwitch, UIStepper 등 UIControl을 상속받은 다양한 컨트롤 클래스가 있다. 이런 컨트롤 객체에서 발생한 다양한 이벤트 종류를 특정 액션 메서드에 연결할 수 있다. 즉, 컨트롤 객체에서 특정 이벤트가 발생하면 미리 지정해 둔 타겟의 액션을 호출 할 수 있다.

### IBAction 뷰객체의 Event와 연결하는 방법

1. 인터페이스 빌더에서 뷰객체의 Event와 직접연결

2. **UI~~.addTarget **: 내가 원하는 뷰객체생성 메서드 내부 혹은 IBOutlet에서  addTarget메서드로  연결

   ```swift
   // 위에 addPlayPauseButton메서드에서
   button.addTarget(self, action: #selector(self.touchUpPlayPauseButton(_:)), for: UIControl.Event.touchUpInside)
   // 이부분이 addTarget
   
   @IBAction func touchUpPlayPauseButton(_ sender: UIButton) {
       sender.isSelected = !sender.isSelected
       if sender.isSelected {
         self.player?.play()
       } else {
         self.player?.pause()
       }
       if sender.isSelected {
         self.makeAndFireTimer()
       } else {
         self.invalidateTimer()
       }
   }
   ```

#### 컨트롤 이벤트의 종류

컨트롤 이벤트는 UIControl에 Event라는 타입으로 정의되어 있습니다. 아래는 컨트롤 객체에 발생할 수 있는 이벤트의 종류입니다.

```swift
//touchDown
//컨트롤을 터치했을 때 발생하는 이벤트
UIControl.Event.touchDown

//touchDownRepeat
//컨트롤을 연속 터치 할 때 발생하는 이벤트
UIControl.Event.touchDownRepeat

//touchDragInside
//컨트롤 범위 내에서 터치한 영역을 드래그 할 때 발생하는 이벤트
UIControl.Event.touchDragInside

//touchDragOutside
//터치 영역이 컨트롤의 바깥쪽에서 드래그 할 때 발생하는 이벤트
UIControl.Event.touchDragOutside

//touchDragEnter
//터치 영역이 컨트롤의 일정 영역 바깥쪽으로 나갔다가 다시 들어왔을 때 발생하는 이벤트
UIControl.Event.touchDragEnter

//touchDragExit
//터치 영역이 컨트롤의 일정 영역 바깥쪽으로 나갔을 때 발생하는 이벤트
UIControl.Event.touchDragExit

//touchUpInside
//컨트롤 영역 안쪽에서 터치 후 뗐을때 발생하는 이벤트
UIControl.Event.touchUpInside

//touchUpOutside
//컨트롤 영역 안쪽에서 터치 후 컨트롤 밖에서 뗐을때 이벤트
UIControl.Event.touchUpOutside

//touchCancel
//터치를 취소하는 이벤트 (touchUp 이벤트가 발생되지 않음)
UIControl.Event.touchCancel

//valueChanged
//터치를 드래그 및 다른 방법으로 조작하여 값이 변경되었을때 발생하는 이벤트
UIControl.Event.valueChanged

//primaryActionTriggered
//버튼이 눌릴때 발생하는 이벤트 (iOS보다는 tvOS에서 사용)
UIControl.Event.primaryActionTriggered

//editingDidBegin
//UITextField에서 편집이 시작될 때 호출되는 이벤트
UIControl.Event.editingDidBegin

//editingChanged
//UITextField에서 값이 바뀔 때마다 호출되는 이벤트
UIControl.Event.editingChanged

//editingDidEnd
//UITextField에서 외부객체와의 상호작용으로 인해 편집이 종료되었을 때 발생하는 이벤트
UIControl.Event.editingDidEnd

//editingDidEndOnExit
//UITextField의 편집상태에서 키보드의 return 키를 터치했을 때 발생하는 이벤트
UIControl.Event.editingDidEndOnExit

//allTouchEvents
//모든 터치 이벤트
UIControl.Event.allTouchEvents

//allEditingEvents
//UITextField에서 편집작업의 이벤트
UIControl.Event.allEditingEvents

//applicationReserved
//각각의 애플리케이션에서 프로그래머가 임의로 지정할 수 있는 이벤트 값의 범위
UIControl.Event.applicationReserved

//systemReserved
//프레임워크 내에서 사용하는 예약된 이벤트 값의 범위
UIControl.Event.systemReserved

//allEvents
//시스템 이벤트를 포함한 모든 이벤트
UIControl.Event.allEvents
```

### 컨트롤 상태 종류

컨트롤 상태는 UIControl에 State라는 타입으로 정의되어 있습니다. 아래는 컨트롤 객체에 발생할 수 있는 상태의 예시입니다.

```swift
//뷰 객체의 평상시 상태
UIControl.State.normal

//뷰 객체가 선택된 상태
UIControl.State.selected
```

## UIButton

### 버튼과 메서드 연결하는 방법

1. `addTarget(_:action:for:)` 메서드 사용
2. 인터페이스 빌더에서 연결 (`@IBAction`)

### 버튼과 연결되는 메서드 형식

```swift
func doSomething()
func doSomething(sender: UIButton)
func doSomething(sender: UIButton, forEvent event: UIEvent)
```

### 버튼의 상태

- 버튼의 상태는 5가지이며 조합된 상태도 가능하다.
  - `default`, `highlighted`, `focused`, `selected`, `disabled`

- 버튼 생성 시 기본 상태 값은 `default`입니다.
- 사용자가 버튼과 상호작용을 하면 상태 값이 변하게 됩니다.
- 프로그래밍 방식 혹은 인터페이스 빌더를 이용해 버튼의 각 상태에 대한 속성을 별도로 지정할 수 있습니다.

### 버튼 주요 프로퍼티

버튼의 프로퍼티 값을 설정하는 방식은 아래 프로퍼티를 활용하여 코드를 작성하는 방법과 스토리보드에서 인스펙터를 이용하는 방법이 있다.

- `enum UIButtonType`: 버튼의 유형
  - 가장 많이 사용하는 유형은 `Custom`과 `System`이지만 필요에 따라 다른 유형(`Detail Disclosure`, `Info Light`, `Info Dark`, `Add Contact`)를 사용할 수 있습니다.
- `var titleLabel: UILabel?`: 버튼 타이틀 레이블
- `var imageView: UIImageView?`: 버튼의 이미지 뷰
- `var tintColor: UIColor!`: 버튼 타이틀과 이미지의 [틴트 컬러](https://developer.apple.com/documentation/uikit/uiview/1622467-tintcolor)

### 버튼의 주요 메서드

```swift
// 특정 상태의 버튼의 문자열 설정
func setTitle(String?, for: UIControlState)
// 특정 상태의 버튼의 문자열 반환
func title(for: UIControlState) -> String?
// 특정 상태의 버튼 이미지 설정
func setImage(UIImage?, for: UIControlState)
// 특정 상태의 버튼 이미지 반환
func image(for: UIControlState) -> UIImage?
// 특정 상태의 백그라운드 이미지 설정
func setBackgroundImage(UIImage?, for: UIControlState)
// 특정 상태의 백그라운드 이미지 반환
func backgroundImage(for: UIControlState) -> UIImage?
// 특정 상태의 문자열 색상 설정
func setTitleColor(UIColor?, for: UIControlState)
// 특정 상태의 attributed 문자열 설정
func setAttributedTitle(NSAttributedString?, for: UIControlState)
```

## UILabel

### 레이브르 주요 프로퍼티

레이블의 프로퍼티에 접근해 나타내려는 문자의 내용, 색상, 폰트, 문자정렬방식, 라인 수 등을 조정할 수 있습니다.
레이블의 프로퍼티의 값을 설정하는 방식에는 프로그래밍 방식과 스토리보드의 인스펙터를 이용한 방법이 있습니다.

 ```swift
//var text: String? : 레이블이 표시할 문자열
label.text = '레이블이 표시할 문자열'

//var attributedText: NSAttributedString? : 레이블이 표시할 속성 문자열
// 좀더 찾아보기

//var textColor: UIColor!` : 문자 색상
label.textColor = UIColor.red

//var font: UIFont!`: 문자 폰트
label.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)

//var textAlignment: NSTextAlignment`: 문자열의 가로 정렬 방식
// `left`, `right`, `center`, `justified`, `natural` 중 하나를 선택할 수 있습니다.
label.textAlignment = .left  
label.textAlignment = .right

// `var numberOfLines: Int`: 문자를 나타내는 최대 라인 수
//기본값은 1, 문자열을 모두표시하려면 0
label.numberOfLines = 0

//`var baselineAdjustment: UIBaselineAdjustment`: 문자열이 Autoshrink 되었을 때의 수직 정렬 방식
label.baselineAdjustment = .alignCenters // 글자가 View Bound 세로 기준으로 중앙 정렬됨.
label.baselineAdjustment = .alignBaselines // 글자의 아래부분(Baseline)이 정해진 위치 기준으로 정렬됨. (Autolayout 포스팅할 때 더 설명하도록 하겠습니다.) 
label.baselineAdjustment = .none // 글자가 View Bound 세로 기준으로 좌상단 정렬됨. (기본값)


//`var lineBreakMode: NSLineBreakMode`: 레이블의 경계선을 벗어나는 문자열에 대응하는 방식
 ```



## UISlider

### 사용자 상호작용에 반응하기

> 사용자가 슬라이더의 값을 변경하면 슬라이더에 연결된 메서드가 호출되어 원하는 작업이 실행됩니다. 기본적으로는 사용자가 슬라이더의 *Thumb*를 이동시키면 연속적으로 이벤트를 호출하지만, `isContinous` 프로퍼티값을 `false`로 설정하면 슬라이더의 *Thumb*에서 손을 떼는 동시에 이벤트를 호출합니다.

#### 슬라이더와 메서드 연결하는 방법

1. `addTarget(_:action:for:)` 메서드 사용
2. 인터페이스 빌더에서 연결 (`@IBAction`)

### 슬라이더 주요 프로퍼티

> 슬라이더의 프로퍼티 값을 설정하는 방식에는 프로그래밍 방식과, 스토리보드의 인스펙터를 이용한 방법이 있습니다.

- `var minimumValue: Float`, `var maximumValue: Float`: 슬라이더 양끝단의 값
- `var value: Float`: 슬라이더의 현재 값
- `var isContinuous: Bool`: 슬라이더의 연속적인 값 변화에 따라 이벤트 역시 연속적으로 호출할 것인지의 여부
- `var minimumValueImage: UIImage?`, `var maximumValueImage: UIImage?`: 슬라이더 양끝단의 이미지
- `var thumbTintColor: UIColor?`: thumb의 틴트 색상
- `var minimumTrackTintColor: UIColor?`, `var maximumTrackTintColor: UIColor?`: thumb를 기준으로 앞쪽 트랙과 뒤쪽 트랙의 틴트 색상

### 슬라이더 주요 메서드

```swift
//  슬라이더의 현재 값 설정
func setValue(Float, animated: Bool)

//  특정 상태의 minimumTrackImage 반환
func minimumTrackImage(for: UIControlState) -> UIImage?

// 특정 상태의 minimumTrackImage 설정
func setMinimumTrackImage(UIImage?, for: UIControlState)

// 특정 상태의 maximumTrackImage 반환
func maximumTrackImage(for: UIControlState) -> UIImage?

// 특정 상태의 minimumTrackImage 설정
func setMaximumTrackImage(UIImage?, for: UIControlState)

//  특정 상태의 thumbImage 반환
func thumbImage(for: UIControlState) -> UIImage?

//특정 상태의 thumbImage 설정
func setThumbImage(UIImage?, for: UIControlState)
```

## AVFoundation

AVFoundation은 다양한 Apple 플랫폼에서 사운드 및 영상 미디어의 처리, 제어, 가져오기 및 내보내기 등 광범위한 기능을 제공하는 프레임워크입니다..

### 주요 기능

- 미디어 재생 및 편집(QuickTime 동영상 및 MPEG-4 파일 재생/생성/편집, HLS 스트림 재생: [재생가능 파일 목록 링크](https://developer.apple.com/documentation/avfoundation/avfiletype))
- 디바이스 카메라와 마이크를 이용한 영상 녹화 및 사운드 녹음
- 시스템 사운드 제어
- 문자의 음성화

### AVAudioPlayer Class

> 이번 프로젝트에서 사용한 AVAudioPlayer 클래스에 대해 조금 더 알아봅시다.
> AVAudioPlayer 클래스는 파일 또는 메모리에 있는 사운드 데이터를 재생하는 기능을 제공합니다.

### AVAudioPlayer 주요기능

- 파일 또는 메모리에 있는 사운드 재생(네트워크에 있는 사운드 파일은 재생 불가)
- 파일 재생 시간 길이의 제한없이 사운드 재생
- 여러 개 사운드 파일 동시 재생
- 사운드의 재생 속도 제어 및 스테레오 포지셔닝
- 앞으로 감기와 뒤로 감기 등의 기능을 지원해 사운드 파일의 특정 지점 찾기
- 현재 재생 정보 데이터 얻기
- 사운드 반복재생 기능

### AVAudioPlayer 주요 프로퍼티

- `var isPlaying: Bool`: 사운드가 현재 재생되고 있는지 아닌지 여부

- `var volume: Float`: 사운드의 볼륨값, 최소 0.0 ~ 최대 1.0

- `var rate: Float`: 사운드의 재생 속도

- ```
  var numberOfLoops: Int
  ```

  : 사운드 재생 반복 횟수

  - 기본값은 0으로 사운드 1회 재생 후 자동 종료
  - 양수값으로 설정시 설정값+1회 재생(ex. 1로 설정시 2회 재생 후 종료)
  - 음수값으로 설정시 `stop` 메서드가 호출 될때까지 무한 재생

- `var dutation: TimeInterval`: 사운드의 총 재생 시간(초 단위)

- `var currentTime: TimeInterval`: 사운드의 현재 재생 시각(초 단위)

- `protocol AVAudioPlayerDelegate`: 사운드 재생 완료, 재생 중단 및 디코딩 오류에 응답할 수 있는 프로토콜

### AVAudioPlayer 주요 메서드

- AVAudioPlayer 초기화 메서드

```swift
// 특정 위치에 있는 사운드 파일로 초기화 
func init(contentOf: URL)
// 메모리에 올라와있는 데이터를 이용해 초기화
func init(data: Data)
```

- AVAudioPlayer 재생관련 메서드

```swift
// 사운드 재생
func play()
// 특정 시점에서 사운드 재생
func play(atTime: TimeInterval)

// 사운드 일시 정지
func pause()
// 사운드 재생 정지 
func stop()
```

## Timer

Timer 클래스는 일정한 시간 간격이 지나면 지정된 메시지를 특정 객체로 전달하는 기능 제공합니다.

### Timer 특징

- 타이머는 런 루프(run loops)에서 작동합니다.
- 타이머를 생성할 때 반복 여부를 지정합니다.
  - 비 반복 타이머: 한 번 실행된 다음 자동으로 무효화 됩니다.
  - 반복 타이머: 동일한 런 루프에서 특정 TimeInterval 간격으로 실행됩니다. 반복되는 타이머 기능을 정지하려면 `invalidate()` 메서드를 호출해 무효화합니다.

### Timer 주요 프로퍼티

- `var isValid: Bool`: 타이머가 현재 유효한지 아닌지 여부
- `var fireDate: Date`: 다음에 타이머가 실행될 시각
- `var timeInterval: TimeInterval`: 타이머의 실행 시간 간격(초 단위)

### Timer 생성 메서드

- 타이머 생성과 동시에 런 루프에 `default mode`로 등록하는 클래스 메서드

```swift
class func scheduledTimer(withTimeInterval: TimeInterval, repeats: Bool, block: (Timer) -> Void)
class func scheduledTimer(timeInterval: TimeInterval, target: Any, selector: Selector, userInfo: Any?, repeats: Bool)
class func scheduledTimer(timeInterval: TimeInterval, invocation: NSInvocation, repeats: Bool)
```

- 타이머 생성 후 수동으로 타이머 객체를 `add(_:forMode:)` 메서드를 이용해 런 루프에 추가해줘야 하는 메서드

```swift
func init(timeInterval: TimeInterval, invocation: NSInvocation, repeats: Bool)
func init(timeInterval: TimeInterval, target: Any, selector: Selector, userInfo: Any?, repeats: Bool)
func init(fireAt: Date, interval: TimeInterval, target: Any, selector: Selector, userInfo: Any?, repeats: Bool)
```

## Cocoa Touch란?

### 코코아 터치 계층(Cocoa Touch Layer)

코코아 터치 계층은 iOS 애플리케이션 개발에 주 축을 이루는 개발환경으로, 애플리케이션의 다양한 기능 구현에 필요한 여러 프레임워크를 포함하는 최상위 프레임워크 계층입니다. 참고로 코코아 계층은 macOS 애플리케이션 제작에 사용합니다.

- '코코아'라는 단어는 Objective-C 런타임을 기반으로하고, NSObject를 상속받는 모든 클래스 또는 객체를 가리킬 때 사용합니다.
- '코코아 터치' 또는 '코코아'는 iOS 또는 macOS의 전반적인 기능을 활용해 애플리케이션을 제작할 때 사용하는 프레임워크 계층입니다.
- '코코아 터치'는 핵심 프레임워크인 UIKit과 Foundation을 포함합니다.

## UIKit 프레임워크

UIKit은 iOS 애플리케이션 개발시 사용자에게 보여질 **화면**을 구성하고 사용자 **액션**에 대응에 관련된 다양한 요소를 포함합니다. 이는 애플리케이션을 구현할 때 필수적인 부분으로 꼭 이해하고 넘어가야합니다.

### UIKit 소개

UIKit은 iOS 애플리케이션의 사용자 인터페이스를 구현하고 이벤트를 관리하는 프레임워크입니다.

- UIKit 프레임워크는 제스처 처리, 애니메이션, 그림 그리기, 이미지 처리, 텍스트 처리 등 사용자 **이벤트 처리**를 위한 클래스를 포함합니다.
- 또한 테이블뷰, 슬라이더, 버튼, 텍스트 필드, 얼럿 창 등 애플리케이션의 **화면을 구성하는 요소**를 포함합니다.
- UIKit 클래스 중 UIResponder에서 파생된 클래스나 사용자 인터페이스에 관련된 클래스는 애플리케이션의 메인 스레드(혹은 메인 디스패치 큐)에서만 사용하세요.
- UIKit은 iOS와 tvOS 플랫폼에서 사용합니다.

### UIKit 기능별 요소

**사용자 인터페이스**

- View and Control : 화면에 콘텐츠 표시
- View Controller : 사용자 인터페이스 관리
- Animation and Haptics : 애니메이션과 햅틱을 통한 피드백 제공
- Window and Screen : 뷰 계층을 위한 윈도우 제공

**사용자 액션**

- Touch, Press, Gesture: 제스처 인식기를 통한 이벤트 처리 로직
- Drag and Drop: 화면 위에서 드래그 앤 드롭 기능
- Peek and Pop: 3D 터치에 대응한 미리 보기 기능
- Keyboard and Menu: 키보드 입력을 처리 및 사용자 정의 메뉴 표시

> **왜 ViewController와 UIKit는 단짝일까요?**
>
> ViewController는 UIViewController를 상속받습니다. UIViewController는 UIKit 프레임워크에 정의된 클래스이기 때문에, UIKit을 import 해주지 않으면 컴파일러는 UIViewController가 누군지 알 수 없습니다.

## Foundation 프레임워크란?

Foundation은 iOS 애플리케이션의 **운영체제 서비스**와 **기본 기능**을 포함하는 프레임워크입니다. 애플리케이션에 원하는 **기능**을 적절히 구현하기 위해서 Foundation 프레임워크를 이해하는 일을 매우 중요합니다.

## Foundation 소개

Foundation은 원시 데이터 타입(String, Int, Double), 컬렉션 타입(Array, Dictionary, Set) 및 **운영체제 서비스**를 사용해 **애플리케이션의 기본적인 기능**을 관리하는 프레임워크 입니다.

- Foundation 프레임워크는 데이터 타입, 날짜 및 시간 계산, 필터 및 정렬, 네트워킹 등의 기본 기능을 제공합니다.
- Foundation 프레임워크에서 정의한 클래스, 프로토콜 및 데이터 타입은 iOS뿐만 아니라 macOS, watchOS, tvOS 등 모든 애플 SDK에서 사용됩니다.

### Foundation 기능별 요소

**기본** 

- Number, Data, String: 원시 데이터 타입 사용
- Collection: Array, Dictionary, Set 등과 같은 컬렉션 타입 사용
- Date and Time: 날짜와 시간을 계산하거나 비교하는 작업
- Unit and Measurement: 물리적 차원을 숫자로 표현 및 관련 단위 간 변환 기능
- Data Formatting: 숫자, 날짜, 측정값 등을 문자열로 변환 또는 반대 작업
- Filter and Sorting: 컬렉션의 요소를 검사하거나 정렬하는 작업

**애플리케이션 지원**

- Resources: 애플리케이션의 에셋과 번들 데이터에 접근 지원
- Notification: 정보를 퍼뜨리거나 받아들이기는 기능 지원
- App Extension: 확장 애플리케이션과의 상호작용 지원
- Error and Exceptions: API와의 상호작용에서 발생할 수 있는 문제 상황에 대처할 수 있는 기능 지원

**파일 및 데이터 관리**

- File System: 파일 또는 폴더를 생성하고 읽고 쓰는 기능 관리
- Archives and Serialization: 속성 목록, JSON, 바이너리 파일들을 객체로 변환 또는 반대 작업 관리
- iCloud: 사용자의 iCloud 계정을 이용해 데이터를 동기화하는 작업 관리

**네트워킹**

- URL Loading System: 표준 인터넷 프로토콜을 통해 URL과 상호작용하고 서버와 통신하는 작업
- Bonjour: 로컬 네트워크를 위한 작업

> 새롭게 ViewController 파일을 생성하면 상단에 'import UIKit'이 기본적으로 명시되어있죠.그렇다면 어떤 파일을 생성하면 'import Foundation'이 기본적으로 명시되어있을까요?
>
> .swift 파일이다. 그렇다면 ViewController에서도 원시 데이터 타입이나 컬렉션 타입은 사용할텐데 왜 import Foundation이 되지 않을까? 왜냐면 import UIKit을 하는 순간 간접적으로 Foundation이 추가되기 때문이다. UIKit에서  Jump to Definition 누르면 UIKit 정의하는 파일이 나오는데, 거기에 보면 맨 위에 ‘import Foundation’로 Foundation 프레임워크를 import 했기 때문에 따로 import 하지 않아도 UIKit에 의해서 추가되는 것입니다.



## Auto Layout 이란?

iPhone4, iPhoneSE, iPhone8, iPhone8 Plus 그리고 iPhoneX등 다양한 사이즈와 화면 비율로 출시 되면서, 사이즈에 구애받지 않고 시각적으로 동일한 화면을 구현해야하는데 이를 위한 가장 편리하고 권장되는 방법이 바로 오토레이아웃입니다.

>  **핵심은 다양한 제약사항중에 최소한을 선택하여 뷰의 X값과 Y값을 결정해주자**

### 오토레이아웃 구현

1. 코드 구현

   1. Layout Anchor(NSLayoutConstraint하위)

      ```swift
      var constraintX: NSLayoutConstraint
      constraintX = button.centerXAnchor.constraint(equalTo: self.view.constraintXanchor)
      ```

   2. NSLayoutConstraint (오토레이아웃 방정식 기반)

      ```swift
      let centerY: NSLayoutConstraint
              centerY = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 0.8, constant: 0)
      ```

   3. Visual Format Language (x)

      ```swift
       H:|-[find]-[findNext]-[findField(>=20)]-|
      ```

      코드를 읽을때 헷갈릴수 있을것같다. 위에 2가지를 우선적으로 사용해보자.

2.  인터페이스빌더
   - 정렬툴
   - 핀툴
   - 리졸브 툴
   - 임베디드 툴

## iOS 뷰의 체계

우리가 iOS 애플리케이션 화면에서 보는 콘텐츠는 윈도우와 뷰를 사용해 나타납니다.

원하는 모양으로 화면을 구성하고, 화면 위에서 일어나는 제스처를 관리하기 위해 뷰에 대해 이해하는 것은 매우 중요합니다. 

### 뷰체계 중첩 순서

(맨위에서부터 아래로 갈수록 바닥에서 뷰가 중첩되는 형태)

- UIWindow : 뷰컨트롤러를 받치고 있는 까만색 영영ㄱ
  - 뷰컨트롤러 : UIViewController는 스스로 화면에 표시되는 인스턴스가 아닌 자신이 운용할 View를 바로 아래 자동으로 생성한다.
    - 슈퍼뷰 
      - 서브뷰

**뷰의 기본적인 역할**

- iOS에서 화면에 애플리케이션의 콘텐츠를 나타내기 위해 윈도우와 뷰를 사용합니다.
- 윈도우는 그 자체로 콘텐츠를 표현할 수 없지만 애플리케이션의 뷰를 위한 컨테이너 역할을 합니다.
- 뷰는 UIView 클래스 또는 UIView 클래스의 하위클래스(Subclass)의 인스턴스로 윈도우의 한 영역에서 콘텐츠를 보여줍니다.
- 뷰가 나타낼 수 있는 콘텐츠는 이미지, 문자, 도형 등과 같이 다양합니다.
- 뷰는 또 다른 뷰를 관리하고 구성하기 위해 사용되기도 합니다.
- 뷰는 제스처 인식기(gesture recognizer)를 사용하거나 직접 터치 이벤트를 처리할 수 있습니다.
- 뷰 계층(view hierarchy)구조에서 부모뷰(parent view)는 자식뷰(child view)의 위치와 크기를 관리합니다.

나타내고자 하는 유형의 콘텐츠에 적합한 뷰를 여러 개 사용하여 뷰 계층(view hierarchy)구조를 구성하고 이를 통해 콘텐츠를 보여주는 것이 좋습니다. 예를 들어 UIKit에는 이미지, 텍스트 그리고 다른 유형의 콘텐츠를 나타내는 뷰가 포함되어 있습니다.

### 뷰 계층구조와 서브뷰 관리

뷰는 자신의 콘텐츠를 보여주는 것과 더불어, 다른 뷰를 위한 컨테이너로써의 역할도 합니다. 하나의 뷰가 다른 뷰를 포함할 때, 두 뷰 사이에 부모-자식 관계가 생성됩니다. 해당 관계에서는 자식뷰는 서브뷰(subview)로, 부모뷰는 슈퍼뷰(superview)로 불려집니다.

### 뷰 계층의 생성과 관리

1. **코드를 통한 생성 관리**
   - 서브뷰를 부모뷰에 추가하기 : 부모뷰의 **addSubView(_:)** 메서드를 호출 (이 메서드는 해당 서브뷰를 서브뷰 목록의 마지막에 추가합니다.)
   - 부모뷰의 서브뷰를 제거하기 : 서브뷰의 **removeFromSuperView()** 메서드를 호출
   - 서브뷰를 부모뷰 목록의 중간에 삽입하기 :  **insertSubview(_:at:)**
   - 부모뷰 내에 이미존재하는 서브뷰를 정렬하기 : **bringSubView(toFront:)**, **sendSubview(toBack:)**

2. **인터페이스 빌더를 통한 생성 관리**

## 뷰의 좌표계

UIKit에서 기본이 되는 좌표계는 좌측 상단 모서리를 원점으로 하며, 원점으로부터 아래쪽, 오른쪽 방향으로 확장됩니다. 좌표값은 해상도와 상관없이 콘텐츠의 위치를 잡는 부동소수점을 사용하여 나타냅니다.

### 프레임과 바운드

- 프레임(frame)은 뷰의 크기와 위치를 슈퍼뷰의 좌표계를 기준으로 나타냅니다. 
- 바운드(bounds)는 뷰의 크기와 위치를 해당 뷰 자신의 좌표계를 기준으로 나타냅니다.

### CGRect

뷰의 사각형을 정의하기 위해선 무엇이 필요할까요? 

- 첫번째로 뷰는 어디에 그려져야 할지 위치를 알아야 합니다. 
- 두번째로는 위치로부터 어떤 크기로 그려져야할지를 알아야합니다.

```swift
UIView(frame: CGRect)
CGRect(origin: CGPoint, size: CGSize)
CGPoint(x: CGFloat, y: CGFloat)
CGSize(width: CGFloat, height:CGFloat)

CGRect(x: CGFloat, y: CGFloat, width: CGFloat, height:CGFloat)
```

## MVC 디자인 패턴

애플리케이션의 **객체**를 **모델, 뷰, 컨트롤러**의 세 가지 역할로 나눈 프로그래밍 디자인 패턴

### 모델 객체 (Model Objects)

예) 데이터에셋, 모델.swift

- 애플리케이션과 관련된 데이터를 캡슐화
- 해당 데이터를 조작하고 처리하는 로직과 계산을 정의

모델 클래스, 즉 모델 객체를 생성하는 클래스는 **Core Data technology**를 사용하고 있는 경우 **NSManagerdObject** 서브 클래스를 많이 사용합니다.

#### 모델 서브클래스를 구현할 때, 클래스 디자인에서 다음 사항을 고려하세요.

- 인스턴스 변수
- 접근자 메서드와 프로퍼티
- 키-값 코딩
- 초기화 및 할당 해제
- 객체 인코딩
- 객체 복제

### 뷰 객체 (View Objects)

예) ios의 뷰체계

- 애플리케이션 내에서 사용자가 볼 수 있는 객체
- 자신이 보이는 방법을 알고 있고 사용자 동작에 응답할 수 있습니다.
- 모델 객체의 **데이터를 보여주고** 해당 **데이터를 편집**할 수 있도록 하는 것

### 컨트롤러 객체 (Controller Objects)

- 뷰 객체와 모델 객체 사이의 **중개자 역할**을 합니다.
- 뷰 객체에서 이루어진 사용자 동작 및 의도를 해석
- 신규 혹은 변경된 데이터를 모델 객체에 전달
- 뷰 객체로 하여금 모델 객체의 변경사항을 인지하거나, 그 반대의 경우가 가능하도록 하는 매개체

### ios환경(Cocoa Touch 프레임워크)에서 컨트롤러의 종류

- 코디네이팅 컨트롤러

  -  애플리케이션 전체 혹은 일부 기능을 감독하고 관리 합니다.
  -  델리게이션(delegation) 메시지에 응답하고 알림(notifications)을 관리.
  -  사용자가 버튼과 같은 컨트롤을 탭 하거나 클릭함에 따라 전송되는 동작 메시지(action message)에 응답.
  -  객체 간의 연결을 확립하거나 기타 설정 작업을 수행. (예: 애플리케이션을 시작하는 경우)
  -  소유한(owned) 객체의 생명 주기 관리.
  -  뷰 컨트롤러가 코디네이팅 컨트롤러의 역할을 겸하는 경우가 많습니다.

- 뷰 컨트롤러(UIVeiwController)

  - UIKit에서 뷰 컨트롤러는 콘텐츠를 화면에 표시하는 뷰를 관리
  - 뷰에 대한 참조(reference)를 유지
  - 뷰의 프레젠테이션(presentation) 및 후속 뷰로의 전환(transition)을 관리
  - 모든 프레젠테이션 동작 관리
  - 모달뷰를 표시하고 메모리 부족 경고에 응답하며 기기의 방향(orientation)이 바뀔 때 뷰를 회전시킵니다.

  iOS의 뷰 컨트롤러는 UIViewController 서브클래스의 인스턴스입니다. UIKit은 UITableViewController와 같은, UIViewController의 여러 특수 목적 서브클래스를 제공합니다. 컨트롤러가 모델과 뷰 간에 데이터를 중개하도록 반드시 프레임워크의 뷰-컨트롤러 클래스(예 : UIViewController, UITableViewController 등)를 확장하십시오. 뷰 컨트롤러는 여러 가지 프레임워크 객체에 대한 델리게이트 혹은 데이터 소스 객체인 경우가 많습니다.