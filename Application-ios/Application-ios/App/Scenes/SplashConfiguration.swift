import SwiftUI

struct SplashConfiguration {
    var delay: Double = 0.35
    var background: Color = .primaryBackground
    var logoBackground: Color = .primaryText
    var scaling: CGFloat = 4
    var forceHideLogo: Bool = false
    var animation: Animation = .smooth(duration: 1, extraBounce: 0)
}
