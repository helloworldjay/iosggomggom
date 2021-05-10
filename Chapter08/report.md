# 📙 [Chapter 08] 공부 기록

<br/>

## 💡 [더 생각해보기]

<br/>

-  인스턴스의 Optional이어서 초기값이 nil로 할당된 프로퍼티에 값을 추가로 할당하는 것은 상수여도 가능하다?

  메세지는 아래에서 발생했습니다.

  ```swift
  for (title, desc, opendate, rating) in dataset {
              var mvo = MovieVO()
              mvo.title = title
              mvo.description = desc
              mvo.opendate = opendate
              mvo.rating = rating
              self.list.append(mvo)
          }
  ```

  인스턴스를 담을 변수 mvo가 var일 때 mutated 되지 않았으므로 let으로 변경하라는 메세지였습니다. 바로 아래 title부터 내용을 변경하고 있는데 이해가 안가 예시를 만들어보았습니다.

  ```swift
  let tests: [Int] = []
  
  tests.append(10)
  
  print(tests)
  ```

  당연히 문제가 발생할 수 밖에 없습니다. 상수인 tests에 새로운 값을 추가하면 tests가 변했다고 볼 수 있기 때문입니다. 다른 예시를 만들어 보았습니다.
  
  ```swift
  class Car {
      var brand: String?
      var name: String = "Test"
      var number: Int
      init(number: Int){
          self.number = number
      }
  }
  
  struct StructedCar {
     var brand: String?
      var name: String = "Test"
      var number: Int
      init(number: Int){
          self.number = number
      }
  }
  
  let testCar = Car(number: 10)
  //  testCar = Car(number: 10)
  //  testCar = Car(number: 20)
  testCar.name = "A8"
  print(testCar.name)
  
  
  let structTestCar = StructedCar(number: 1)
  structTestCar.name = "R8" // 에러발생
  
  ```
  
  주석 처리된 두 코드 중 어느하나라도 주석이 풀리면 에러가 발생합니다. 즉, 상수 testCar의 프로퍼티를 변경하는 것은 관계없지만, 상수 testCar에 완전히 새로운 인스턴스를 할당(심지어 완전히 똑같은 값을 가져도)하면 문제가 생깁니다. 여기에 대한 설명이 있습니다.
  
  >- why is constant instance of a value type can NOT change its properties
  >
  >Because value type is treated as an indivisible unit: it gets copied on assignment, passing it as a parameter behaves like a copy, and so using const-ness locks down the entire `struct`. In a sense, `structedTestCar` variable represents the structure itself, not a pointer or a reference to it.
  
  🧐 왜 상수선언된 값타입의 인스턴스 프로퍼티는 변경이 안될까?
  
  해석해보면 값타입은 개별 유닛으로 취급받고, 할당 시 복사되어 전달됩니다. 그래서 상수처리를 하면 전체 struct자체를 하나의 값으로 판단해 lock을 합니다. structedTestCar는 포인터나 참조를 의미하는 것이 아니라 값 자체이므로 내부의 프로퍼티를 변경하는 순간 다른 값이 되어 상수에서 에러가 발생합니다.
  
  >- while constant instance of a reference type can?
  >
  >This is not entirely correct to say that declaring a const variable of reference type makes the instance constant as well. Only the reference is constant, not the instance.
  >
  >If you think about it, that is the only way this could be meaningfully implemented, because multiple variables can reference the same by-reference instance. If one of these variables is constant and the other one is not constant, assigning a non-const reference to a constant variable could not possibly lock down the referenced object, which would lock out the non-const reference as well:
  
  🧐 왜 상수선언된 참조타입의 인스턴스 프로퍼티는 변경이 될까?
  
  참조 타입의 상수가 인스턴스 자체를 상수로 만든다고 말할 수 없습니다. 참조 그 자체만 상수이며, 인스턴스는 상수가 아닙니다. 여러 변수들은 참조 인스턴스에 의해 같은 것들을 참조할 수 있습니다. 이 변수 중 하나가 상수일 수 있고 다른 것들은 상수가 아닐 수 있습니다. 그래서 참조되는 객체를 lock down할 수 없습니다. 예를 들면,
  
  ```swift
  var testCar = Car(number: 10)
  let testCar2 = testCar // testCar2 is a constant reference to the same instance as "testCar"
  testCar2.name = "R8" // Prohibiting this assignment would be inconsistent
  print(testCar.name)
  ```
  
  위의 경우 testCar2는 testCar와 같은 객체를 가르키게 됩니다. 즉, 주소를 공유하는 상태에서 변수 testCar의 프로퍼티를 변경하는 것을 막는 것은 모순이 됩니다(문제가 없습니다). testCar의 값이 변경될 경우 이것은 같은 것을 가르키고 있는 testCar2에도 영향을 미칩니다. 위의 말을 정리해보면 결국 let으로 선언된 testCar2에서 불변의 부분은 testCar2가 가르키는 객체 자체가 아니라 그 객체를 가르키는 주소가 됩니다. 참조 타입은 하나의 객체를 여러 변수가 공유하여 가르킬 수 있기 때문입니다.
  
  >ref: https://stackoverflow.com/questions/35661753/why-is-constant-instance-of-a-value-type-can-not-change-its-properties-while-con

<br/>

## 🛠 [Error Report]

<br/>

- for문에서 요소 나누기

  에러는 아래의 코드에서 발생했습니다.

  ```swift
  var dataset = [
          ("다크나이트", "영웅물에 철학에 음악까지 더해져 예술이 되다.", "2008-09-04", 8.95),
          ("호우시절", "때를 알고 내리는 좋은 비", "2009-10-08", 7.31),
          ("말할 수 없는 비밀", "여기서 너까지 다섯 걸음", "2015-05-07", 9.19)
      ]
  
  for title, desc, opendate, rating in dataset {
              var mvo = MovieVO()
              mvo.title = title
              mvo.description = desc
              mvo.opendate = opendate
              mvo.rating = rating
          }
  ```

  >Error: Expected 'in' after for-each pattern

  Python의 경우 iterable한 요소가 여러가지 요소로 구성되어 있을 때(튜플 등) 개수만 맞다면 알아서 순서에 맞게 매칭시켜주었습니다. 하지만 Swift는 정확히 같은 타입이어야 하므로 튜플에는 튜플로 매칭해주어야합니다.

  ```swift
  for (title, desc, opendate, rating) in dataset {
              var mvo = MovieVO()
              mvo.title = title
              mvo.description = desc
              mvo.opendate = opendate
              mvo.rating = rating
          }
  ```

  








<br/>