# 📙 [Chapter 05] 공부 기록

<br/>

## 💡 [더 생각해보기]

<br/>

- p.289쪽 stepper 메소드 생성 관련

  >"항목을 'Any'타입으로 지정하면 필요한 속성을 읽을 수 없으므로 적절한 타입으로 다시 캐스팅해서 사용해야 하거든요. 번거로운 일이죠"

  'Any는 말 그대로 아무거나 받을 수 있는 타입인데 UISwitch나 UIStepper는 받을 수 없는 것인가?'에 대한 고민이 필요합니다.

  Action 메소드를 정의할 때 매개변수 타입은 두 가지 방식 중 선택할 수 있습니다. 범용 타입인 Any와 UI***로 시작하는 개별 타입이 있습니다. Any 타입으로 선언하면 하나의 액션 메소드를 서로 다른 타입의 컨트롤들이 공용으로 사용할 수 있어 편리하지만 막상 해당 인자값을 사용할 때에는 다시 하위 타입으로 캐스팅해주어야 합니다. 반면 UI로 시작하는 개별타입은 이에 맞는 타입의 컨트롤만 호출할 수 있어 제한적이지만 컨트롤의 속성을 제어하거나 읽어 들여야 할 경우엔 캐스팅할 필요없이 바로 사용 가능합니다. 결국 기준은 다음과 같습니다.

  >1. 서로 다른 타입의 컨트롤이 동일한 액션 메소드를 호출하고 싶게 정의하고 싶을 때
  >
  >2. 액션 메소드를 호출한 컨트롤의 정보가 필요 없을 때
  >
  >에는 Any 타입을 선택합니다. 반면
  >
  >1. 액션 메소드를 호출한 컨트롤의 속상값이 필요하거나, 제외해야할 때
  >
  >다시 말하면, 특정 타입으로 결정된 인자(parameter)를 가지고 어떤 동작을 하고 싶을 때에는 구체적으로 타입을 명시해줍니다. 

  여기서 주의해야할 점은 다운 캐스팅입니다. 특별히 무슨 작업이 필요하다기보다 파라미터 타입이 Any로 설정되어 있는 상황에서 UIStepper에 특정 역할을 해주고 싶다면 이 파라미터의 타입을 UIStepper로 변경해주어야 관련 속성들을 사용할 수 있기 때문이 이 변환이 필요하다는 개념입니다. 상위 개념으로 변환하는 업 캐스팅(Up Casting)의 경우 문제가 발생할 여지가 없지만 하위로 다운 캐스팅(Down Casting)하는 경우는 적합하지 못한 타입으로 지정될 수 있습니다. 이런 경우 캐스팅에 실패할 가능성이 있습니다. 그래서 옵셔널 바인딩으로 결과를 던져주거나 강제로 캐스팅하여 일반 타입을 던져줄지 판단해야합니다. 

<br/>

## 🛠 [Error Report]

<br/>

- p.278 SubmitValue를 구현하던 중 에러가 발생했습니다.

  >Thread 1: "[<Chapter05.ViewController 0x150f08900> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key UIStepper."

  정확하게 알 수 없지만 UIStepper에 문제가 있다고 판단했습니다. 위의 오류 메세지를 구글링 해본 결과 다음과 같은 말이 있었습니다.

  >Outlet removed in the code, but is still set in Storyboard/Xib 
  >
  >ref: [Permalink](https://nikrodionov.com/this-class-is-not-key-value-coding-compliant-for-the-key/#outlet-removed-in-the-code-but-is-still-set-in-storyboardxib)

  정확하게 인지하지는 못했지만 UIStepper 관련 스토리보드와 View Controller간의 연결문제라고 생각되어 연결을 살펴보던 중 의도하지 않은 연결이 있음을 발견했습니다.

  ![](https://images.velog.io/images/jayb/post/236ad094-73fe-4133-86a8-4e4c39146bec/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202021-05-05%20%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE%204.41.45.png)

  interval은 UIStepper 타입의 Outlet 변수였습니다. 즉, storyboard에 존재하는 UIStepper의 인스턴스라고 생각했습니다. 하지만 아래 UIStepper가 View Controller에 연결되어있는 것은 타입 자체가 연결되어 있는 것이므로 이해하기가 어렵습니다. 정확한 이해는 아니지만 저 연결을 삭제해서 문제를 해결했습니다. 

- SubmitValue-Back을 구현하기위해 파일명과 클래스명을 바꾸던 중 큰 에러가 발생했습니다. ViewController의 이름을 FormViewController로, ResultViewController를 ViewController로 바꾸는 과정에서 rename을 사용해도 계속 

  >Invalid redeclaration of 'ViewController' error without redeclare

  에러가 발생했습니다. 검색을 해봐도 에러메세지를 봐도 문제는 재선언이 되었다는 부분인데 프로젝트 내 어떤 곳에서도 ViewController를 정의한 부분은 없었습니다. 프로젝트 내 검색 결과를 봐도 ViewController가 없었는데 아마 유추하기로는 프로젝트 파일 내에 존재하는 파일 연결 상태가 같은 이름의 파일 및 클래스로 변경되어 문제가 생긴 것 같습니다. 이전 상태로 돌려도 에러메세지가 뜨고, git clone으로 다시 받아도 에러메세지가 떴습니다. 

  🧐 앞으로는 절대 파일명 및 클래스명을 쉽게 바꾸면 안됩니다.

<br/>