import SwiftUI

@main
struct Application_iosApp: App {

    var body: some Scene {
        SplashScene(configuration: .init()) {
            ContentView()
        } logo: {
            Image(.logo)
        }
    }

}
