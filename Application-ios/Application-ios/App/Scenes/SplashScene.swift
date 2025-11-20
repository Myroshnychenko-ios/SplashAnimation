import SwiftUI

struct SplashScene<Root: View, Logo: View>: Scene {

    var configuration: SplashConfiguration

    @ViewBuilder var root: Root
    @ViewBuilder var logo: () -> Logo

    var body: some Scene {
        WindowGroup {
            ZStack {
                root
                    .modifier(SplashSceneModifier(configuration: configuration, logo: logo))
            }
        }
    }

}
