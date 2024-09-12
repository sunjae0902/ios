import SwiftUI

enum Route {
    case second
    case third
    case final
}

struct RouterView<Content: View>: View {
    @StateObject var router: Router = Router()
    // ObservableObject 프로토콜을 따르는 객체 값이 변경될 때, 뷰를 다시 그리도록 함
    private let content: Content // generic type view
    
    // 뷰 초기화
    // @escaping: 함수 밖에서(함수 실행 종료 후) 실행되는 클로저(body에서 뷰를 그릴 때 실행됨)임을 명시
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    // body 정의
    var body: some View {
        // NavigationStack 설정
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: Route.self) { route in
                    router.view(for: route)
                }
        }
        .environmentObject(router) // router 객체를 하위 뷰에 주입
    }
}


class Router: ObservableObject {
    @Published var path = NavigationPath() // 객체의 상태가 변경될 때 클래스를 구독하는 외부의 뷰를 업데이트(ObservableObject 상속받는 클래스에서 사용)
    
    @ViewBuilder func view(for route: Route) ->  some View {
        switch route {
        case .second: SecondView()
        case .third: ThirdView()
        case .final: FinalView()
        }
    }
  
    func to(_ destination: Route) {
        path.append(destination)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popAllUntilRoot() {
        path.removeLast(path.count)
    }
}

struct ContentView: View { //최상단 뷰
    @EnvironmentObject var router: Router

    var body: some View {
        VStack {
            Text("Home View")
                .font(.largeTitle)
                .padding()
            
            Button("Go to Second View") {
                router.to(.second)
            }
            .padding()
            
            Button("Go to Third View") {
                router.to(.third)
            }
            .padding()
        }
        .navigationTitle("Home")
    }
}

struct SecondView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
                .padding()
            Button("Go to Final View") {
                router.to(.final)
            }
            .padding()
        }
        .navigationTitle("Second")
        
    }
}

struct ThirdView: View{
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            Text("Third View")
                .font(.largeTitle)
                .padding()
            Button("Go to Final View") {
                router.to(.final)
            }
            .padding()
        }
        .navigationTitle("Third")
        }
    }

struct FinalView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        Text("Final View")
            .font(.largeTitle)
            .padding()
            .navigationTitle("Final")
        Button("Go To First Screen") {
            router.popAllUntilRoot()
        }
    }
}


#Preview{
    RouterView {
        ContentView()
    }
}
