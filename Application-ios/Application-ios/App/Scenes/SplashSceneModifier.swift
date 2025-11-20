import SwiftUI

struct SplashSceneModifier<Logo: View>: ViewModifier {

    @Environment(\.scenePhase) private var scenePhase

    @State private var window: UIWindow?

    var configuration: SplashConfiguration
    @ViewBuilder var logo: Logo

    func body(content: Content) -> some View {
        content
            .onAppear {
                let scenes = UIApplication.shared.connectedScenes
                for scene in scenes {
                    guard let windowScene = scene as? UIWindowScene,
                          check(windowScene.activationState),
                          !windowScene.windows.contains(where: { $0.tag == 1009 }) else {
                        continue
                    }

                    let window = UIWindow(windowScene: windowScene)
                    window.backgroundColor = .clear
                    window.isHidden = false
                    window.isUserInteractionEnabled = true

                    let rootViewController = UIHostingController(rootView: SplashView(configuration: configuration) {
                        logo
                    } isCompleted: {
                        window.isHidden = true
                        window.isUserInteractionEnabled = false
                    })
                    rootViewController.view.backgroundColor = .clear

                    window.rootViewController = rootViewController

                    self.window = window
                }
            }
    }

    private func check(_ state: UIWindowScene.ActivationState) -> Bool {
        switch scenePhase {
        case .active: return state == .foregroundActive
        case .inactive: return state == .foregroundInactive
        case .background: return state == .background
        default: return state.hashValue == scenePhase.hashValue
        }
    }

}
