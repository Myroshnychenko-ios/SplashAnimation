import SwiftUI

struct SplashView<Logo: View>: View {

    var configuration: SplashConfiguration
    @ViewBuilder var logo: Logo
    var isCompleted: () -> ()

    @State private var scaleDown: Bool = false
    @State private var scaleUp: Bool = false

    var body: some View {
        Rectangle()
            .fill(configuration.background)
            .mask {
                GeometryReader {
                    let size = $0.size.applying(.init(scaleX: configuration.scaling, y: configuration.scaling))
                    Rectangle()
                        .overlay {
                            logo
                                .blur(radius: configuration.forceHideLogo ? 0 : (scaleUp ? 15 : 0))
                                .blendMode(.destinationOut)
                                .animation(.smooth(duration: 0.3, extraBounce: 0)) { content in
                                    content
                                        .scaleEffect(scaleDown ? 0.8 : 1)
                                }
                                .visualEffect { [scaleUp] content, proxy in
                                    let scaleX: CGFloat = size.width / proxy.size.width
                                    let scaleY: CGFloat = size.height / proxy.size.height
                                    let scale = max(scaleX, scaleY)

                                    return content
                                        .scaleEffect(scaleUp ? scale : 1)
                                }
                        }
                }
            }
            .opacity(configuration.forceHideLogo ? 1 : (scaleUp ? 0 : 1))
            .background {
                Rectangle()
                    .fill(configuration.logoBackground)
                    .opacity(scaleUp ? 0 : 1)
            }
            .ignoresSafeArea()
            .task {
                guard !scaleDown else { return }
                try? await Task.sleep(for: .seconds(configuration.delay))
                scaleDown = true
                try? await Task.sleep(for: .seconds(0.1))
                withAnimation(configuration.animation, completionCriteria: .logicallyComplete) {
                    scaleUp = true
                } completion: {
                    isCompleted()
                }
            }
    }

}
