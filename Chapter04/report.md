# 📙 [Chapter 04] 공부 기록

<br/>

## 💡 [더 생각해보기]

<br/>

- 🧐 Navigation Control에서 첫 화면이 Navigation Controller가 아니라 단순히 첫번째 페이지라면?

  ![](https://images.velog.io/images/jayb/post/0a99a896-6222-4dc5-a8b6-48335a81b64a/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202021-05-04%20%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE%206.02.59.png)

  <br/>

  첫 화면이 나오기는 하지만 Navigation Bar 자체가 구현되지 않습니다. 스토리보드 상에 네비게이션 바가 존재하여 버튼을 만들고 그 후에 다른 화면으로 이동을 구현하여도 Nav Bar 자체가 존재하지 않습니다. 그래서 Navigation Controller가 시작화면인지 확인할 필요가 있습니다.

  <br/>

- 🧐 Navigation Bar에 Title을 작성할 때 Label을 단순히 붙여넣는다면?:

  화면이 검게 나오는 현상이 발생합니다. Navigation Controller 아래에 있는 모든 뷰에서 공유되는 Bar 중 한 Bar에 단순히 Labelling 하는 것은 문제가 발생하므로 반드시 Navigation Item을 추가해야 합니다.

- 🧐 Scene-MultiUnwind를 구현하면서 들었던 의문, 하나의 View Controller를 두개의 뷰가 공유할 때 MulitUnwind를 동작시키면 어떻게 될까?:

  사실 에러를 발생시킬 줄 알고 시도했지만 의외로 에러가 발생하지 않았습니다. 상황은 다음과 같습니다. View Controller를 첫번째 페이지 뷰와 두번째 페이지 뷰가 공유합니다. View Controller에는 페이지를 한번에 돌아오는 unwind가 구현되어있고 이것은 네번째 페이지 뷰의 Home 버튼과 연결되어있습니다. 만약 이 버튼을 누르면 View Controller 화면으로 한번에 돌아올텐데 그때에는 첫번째 페이지 뷰가 아니라 두번째 페이지 뷰로 돌아왔습니다. 마찬가지로 세번째 뷰까지 View Controller를 갖게 해도 세번째 뷰로 돌아왔습니다. 즉, View Controller를 공유할 때에는 그 View Controller와 연결된 뷰 중 Stack에서 최상단에 있는 뷰가 기준이 되는 것을 알 수 있었습니다. 하지만 이것은 단순한 실험으로 실제 프로그램에서는 이렇게 할 이유도, 이렇게 해서도 안됩니다.

- 🧐 화면 이동전 전처리 시에 화면에 변경점을 만들고 이동해야할 때:

  화면이 이동하기 직전 변경이 있고 나서 화면이 바뀌는 경우를 생각해봤습니다. 예를 들면, 특정 버튼을 클릭했을 때 화면 배경색이 바뀌면서 다음 화면이 나오는 등의 경우입니다. 그래서 전처리에서 custom segue를 활용할 때 화면의 label 텍스트를 바꾸는 작업을 추가해봤습니다. 하지만 결과는 화면 전환 전 레이블 텍스트의 변화가 없었습니다.

  ```swift
  // ViewController
  @IBOutlet var firstScreenLabel: UILabel!
      
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          self.firstScreenLabel.text = "천천히 변경"
          NSLog("\(segue.identifier) 세그웨이 실행")
      }
  
  // NewSegue
  override func perform() {
          let srcUVC = self.source
          let destUVC = self.destination
          UIView.transition(from: srcUVC.view, to: destUVC.view, duration: 5, options: .transitionCurlDown)
      }
  ```

  결과는 아래와 같습니다.

  <br/>

  ![](https://images.velog.io/images/jayb/post/f727fc01-afd3-4bf3-8a91-959540b88989/culrdown%E1%84%90%E1%85%B3%E1%84%85%E1%85%A2%E1%86%AB%E1%84%8C%E1%85%B5%E1%84%89%E1%85%A7%E1%86%AB.gif)

  <br/>

  전처리시 기존 화면을 변경할 수 없는 문제인가 확인하기 위해 다른 애니메이션 효과를 주었습니다. Action을 통해 쉽게 구현했습니다.

  <br/>

  ![](https://images.velog.io/images/jayb/post/6cf964da-226c-474f-9a65-fedb8c0d3168/%E1%84%8B%E1%85%A2%E1%86%A8%E1%84%89%E1%85%A7%E1%86%AB.gif)

  <br/>

  짧은 시간이지만 텍스트가 변경되는 것을 볼 수 있습니다. 단순히 화면 변경의 애니메이션 문제였습니다. 전처리를 통해 화면에 미리 변화를 줄 수 있습니다.



<br/>

## 🛠 [Error Report]

<br/>

- p.177 구현 실패 에러: 

  버튼에 메소드를 만들어 실행시 다음 화면으로 넘어가는 것을 구현했는데, 쓰레드 에러가 발생함. 또 구현된 레이블이 화면에 나타나지 않음.

  -> 구현이 iPhone11 기준으로 그려졌는데 시뮬레이터가 다른 버전이어서 레이블 자체가 안나오고 메소드 작동이 안되었음. Xcode 에러라고 생각됨. 

  🧐 코드 테스트를 위해 화면을 엄밀하게 작성하고 있지 않을 때에는 시뮬레이터의 버전을 확인할 필요가 있습니다.

  <br/>

- p.175 partialCurl 에러

  다른 modal transition style처럼 partial curl도 적용해보려고 했는데 에러가 발생했습니다. partial curl은 다른 style과 다르게 버튼 하나로 View가 완전히 변경되는 구조가 아니므로 다른 방식의 접근이 필요할 것 같습니다.

  🧐 iOS 13 이후 full screen이 아닌 새로운 프리젠테이션 스타일 때문에 partial curl 트랜지션시 문제가 발생합니다. 이것을 사용하기 위해 default presentation style을 변경할 필요가 있습니다.

  >https://forums.xamarin.com/discussion/170504/after-ios13-update-uimodaltransitionstylepartialcurl-crashes

  <br/>