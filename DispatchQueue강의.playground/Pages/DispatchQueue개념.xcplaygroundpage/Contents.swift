//: A UIKit based Playground for presenting user interface
  
import Foundation
import PlaygroundSupport
// 비동기 허용
PlaygroundPage.current.needsIndefiniteExecution = true

/*:
 ### 인프런 비동기강의
 */

// MARK: - 1-2강

// 큐로보내겟다.글로벌큐로.비동기로
DispatchQueue.global().async {
    // 하나의 작업단위
    // 안에서는 순서대로 작동
}

/*:
 * GCD
    * 간단한일, 함수를 사용하는 작업(메서드 위주)
 
 * Operation
    * 복잡한일, 데이터와 기능을 캡슐화한 객체
    * gcd기반으로 만들어짐
    * 취소, 순서지정, 일시중지
 */


// MARK: - 1-2강

/*:
 ### 비동기란?
 아래와같이 작업 1, 2, 3이 있을때
 Thread: task1 - task2 - task3 ---------->
 Queue:
 Thread2:
 
 DispatchQueue를 통해서 큐로 보내고
 Thread:  - task2 - task3 ---------->
 Queue: task1
 Thread2:
 
 큐가 자동으로 다른 스레드로 할당시켜준다.
 Thread:  - task2 - task3 ---------->
 Queue:
 Thread2: task1
 
 이때 Thread2에서 작업이 끝나기를 기다린후 리턴받는게아니라
 바로 리턴받고 Thread는 다음작업 task2를 수행할 수 있는상태가된다.
 Thread:  task2 - task3 ---------->
 Queue:
 Thread2: task1
 
 원래작업이 진행되고있던 곳에서 큐로 보낸작업을 기다리지않는다.
 
 
 ### 동기
 아래와 같은 상태에서 task1이 끝날때까지 task2를 시작하지않고 기다림
 Thread:  task2 - task3 ---------->
 Queue:
 Thread2: task1
 
 
 동기를 쓰면 메인에서 실행되는것과 무엇이다른가..... 대부분 비동기만 씀
  
 */

// MARK: - 1-3강

/*:
 GCD - 디스패치큐
 
 Serial큐는 단하나의 스레드로만 보내는 큐대기열
 분산처리 시킨 작업을 다른 한개의 쓰레드에서 처리하는큐
 
 Concurrent큐는 어려 스레드로 분산해서 처리
 분산처리 시킨 작업을 다른 여러개의 쓰레드에서 처리하는 큐
 
 동시큐가 무조건좋을텐데 왜쓸까??
 직렬큐는 순서가 중요한 작업을 처리할 때
 동시큐는 각자 독립적이지만 유사한 여러개의 작업을 처리할때 사용
 
 비동기와 동시란 같은말인가?
 작업을 보내는 시작점에서 기다릴지말지를 다루는것이 비동기/동기
 대기열로 보내진 작업이 여러개의 쓰레드로 갈것인지 하나의 쓰레드로 갈것인지 동시/직렬
 */


// MARK: - 2-1강

/*:
 디스패치 큐 - 메인, 글로벌, 커스텀큐
 
 ### 메인큐
 유일한 한개, 직렬, 메인쓰레드
 
 ### 글로벌큐
 종류 여러개, 기본설정(Concurrent), QoS(6종류)
 
 * QoS
    * userInteractive - 거의 즉시, UI업데이트, 애니메이션, 반응관련, 사용자와 상호작용
    * userInitiated - 몇초, 즉시필요하긴하지만 비동기적으로 처리된 작업 (앱내에서 pdf 여는작업)
    * default - 일반적 작업
    * utility - indicator와 함께 몇초에서 몇분, 길게 실행되는 작업, 계산, 네트워킹, 지속적인 데이터피드백
    * background - 유저가 직접 인지하지않고 시간이 중요하지않은 작업 (데이터 미리가져오기, db유지)
    * unspecified - lagacy API지원
 ```
 iOS가 알아서 우선적으로 중요한 일임을 인지하고
 쓰레드에 우선순위를 매겨 더 여러개의 쓰레드에 배치하고
 배터리를 더 집중해서 사용하도록함
 ```
 
 ### 프라이빗(커스텀)큐
 디폴트는 Serial
 Concurrent로도 설정가능
 label을 붙일수잇음
 QoS추론, 설정가능
 
 ### OperationQueue
 디폴트: background, Concurrent
 */

let defaultQueue = DispatchQueue.global()
defaultQueue.async(qos: .userInteractive) {
    // 이런 경우는 이작업의 우선순위가 중요하다고 판단해서 이작업만 우선순위가 올라감
}

// MARK: - 3-1강
/*:
 ### 주의사항
 
 UI관련일은 메인큐에서 처리해야한다
 
 메인큐에서는 항상 비동기적으로 보내야함
 sync로 보내면 작업을 기다리므로 버벅거리거나 멈춰잇는 현상이나타남
 
 현재큐에서 현재큐로 동기적으로 보내면 안된다 -> 교착상태
 
 ~~~ swift
 DispatchQueue.global().async {
    DispatchQueue.global().sync {
    }
 }
 ~~~
 
 캡처링
 
 작업이 종료하지않아서 해당값에 접근하면 잘못된값을 사용할 수도잇음
 비동기 작업이 끝났다는 것을 정확히 알려주는 시점 = 컴플리션핸들러
 
 
 
 */



//: [Next](@next)
