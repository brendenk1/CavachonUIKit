import Combine
import InkdryerKit
import SwiftUI

public struct PlaceholderCapsule: View {
    public init() { }
    
    @StateObject private var model = ProgressModel()
    
    @Environment(\.colorScheme) private var scheme
    
    public var body: some View {
        ZStack {
            Capsule()
                .fill(Gradients.placeholderBackgroundGradient(scheme))
            
            Capsule()
                .trim(from: 0.0, to: model.trim)
                .stroke(Gradients.placeholderOutlineGradient(scheme), style: StrokeStyle(lineWidth: 2, lineCap: .round))
                .opacity(model.trimOpacity)
                .animation(.easeOut.speed(0.5), value: model.trim)
                .animation(.easeOut.speed(0.5), value: model.trimOpacity)
            
            Capsule()
                .fill(flashColor.color)
                .opacity(model.flashOpacity)
        }
        .frame(height: 24)
    }
    
    private var flashColor: any InkDryerColor {
        switch scheme {
        case .light:        return Gray.eight
        case .dark:         return Gray.nine
        @unknown default:   return White.baseColor
        }
    }
}

struct PlaceholderCapsule_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderCapsule()
            .frame(height: 24)
            .padding()
    }
}
