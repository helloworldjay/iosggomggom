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

  당연히 문제가 발생할 수 밖에 없습니다. 상수인 tests에 새로운 값을 추가하면 tests가 변했다고 볼 수 있기 때문입니다. 하지만 위의 경우 mvo가 선언되면서 내부를 생각해볼 필요가 있습니다. mvo는 클래스이므로 memberwise init이 없고, 클래스 내부에 init을 따로 선언해주지 않았습니다. 기본 값이 모두 Optional이므로 모두 nil로 선언되어 mvo에 할당됩니다. 특이한 점은, 이렇게 nil로 되어있는 값을 변경하는 것은 let이어도 가능하다는 것입니다. 

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

- 







<br/>