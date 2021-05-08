# 📙 [Chapter 05] 공부 기록

<br/>

## 💡 [더 생각해보기]

<br/>

- IBAction 생성 시 주의사항(ViewDidLoad안에)(p.442):

  p.442를 구현하며 무의식중에 앞서 구현하던 ViewDidLoad안에 IBAction을 선언하려고 했습니다. Ctrl + 마우스를 동작시켜도 정의가 안되어 이상하게 생각했는데 우연히 바깥에 선언하게 되고 깨달았습니다. ViewDidLoad는 View의 Load가 완료된 후 자동으로 진행되는 코드들입니다. 하지만 IBAction의 메소드를 선언하는 것은 자동으로 진행될 수 없고, sender의 파라미터가 동작되었을 때, 즉 버튼이 클릭되는 등의 action이 있을 때 reaction으로 동작하는 것이므로 ViewDidLoad 안에서 정의되는 것은 논리적으로 불가능합니다.

- 글자 수 제안시 text 객체를 누구로 설정할 지 문제(p.452):

  text?.count를 구현하며 책에서는 textField의 첫번째 파라미터인 textField의 text를 지정해서 textField.text?.count로 구현했습니다. 코드는 아래와 같습니다.

  ```swift
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          print("텍스트 필드의 내용이 \(tf.text!+string)으로 변경됨")
          if Int(string) == nil {
              if (textField.text?.count)! + string.count > 10 {
                  return false
              } else {
                  return true
              }
          } else {
              return false
          }
      }
  ```

  저는 여기서 textField가 아닌 어차피 이 뷰 인스턴스 안에서 일어나는 일이므로 이 인스턴스 내부에 있는 텍스트필드 tf를 활용해서 tf.text?.count로 선언했습니다. 결과는 둘 다 동작했습니다.

  🧐 차이가 무엇일까?

  생각에는 textField라는 메소드는 tf.delegate 내부의 메소드입니다. 

  ```swift
  self.tf.delegate = self
  ```

  를 통해 위임받았으므로 tf의 delegate에서 동작하는 메소드 textField의 첫번째 파라미터 textField는 tf 자신이 될 것입니다. 결과적으로 같은 구조라고 할 수 있지만 위임의 역할을 생각해보면 위임된 메소드 내부에서 직접 tf에 접근하기보다 파라미터를 통하는 것이 더 나은 구조라고 생각됩니다.

  🧐 textField.text?.count가 옵셔널인 이유?

  textField의 text는 아무것도 작성되지 않았을 때 nil일 수 있으므로 count 전에 옵셔널로 처리되는 것이 합당합니다. 하지만 count 메소드는 사실 옵셔널이 아닌 Int값을 반환할 텐데 체이닝에서 앞선 text가 옵셔널이므로 전체 결과가 옵셔널이 되는 것 같습니다. 마지막 것이 기준이 아니라 전체가 기준이라는 것을 인식할 필요가 있습니다.

<br/>

## 🛠 [Error Report]

<br/>

- extension 선언 위치 에러

  >Declaration is only valid at file scope

  p.478을 작성하며 위와 같은 에러가 발생했습니다. file scope에서만 선언 가능하다는 의미를 알기 어려워 검색 결과 Stack Overflow에서 답을 찾았습니다. extension ViewController를 선언하며 당연히 ViewController 밖에 선언해야하는데 ViewController 안에 선언하면서 문제가 발생했습니다. extension을 선언하고 싶은 클래스 안에 선언하면 위와 같은 에러가 발생한다는 사실을 알게 되었습니다.

- Delegate 오타 에러

  마찬가지로 p.478을 작성하며 UINavigationControllerDelegate을 conform하는 것이 아니라 UINavigationController를 conform하게 한 후 아래와 같은 에러가 발생했습니다.

  >Inheritance from non-protocol type 'UINavigationController'

  UINavigationController는 프로토콜이 아니고 UIViewController를 상속받는 클래스입니다. ViewController 역시 마찬가지이므로 자식이 자식을 상속받게하여 문제가 생겼습니다. 

  🧐 상속은 클래스 간에도 일어날 수 있는데 non-protocol type이라고 명시되어있는 것이 조금 이해가 가지 않았습니다. 프로토콜 뿐만 아니라 클래스도 protocol type이라고 할 수 있는 것인지 추가적인 확인이 필요합니다.

  또한 위의 실수로 추가적인 에러도 있었습니다.

  ```swift
  @IBAction func pick(_ sender: Any) {
    ...
    picker.delegate = self // 에러 발생
  }
  ```

  >Cannot assign value of type 'ViewController' to type '(UIImagePickerControllerDelegate & UINavigationControllerDelegate)?'

  UIImagePickerController는 UIImagePickerControllerDelegate과 UINavigationControllerDelegate이 모두 필요하다는 것을 알 수 있습니다. delegate 오타를 수정함으로써 문제는 해결되었습니다.

<br/>