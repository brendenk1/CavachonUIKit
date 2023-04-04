import Combine
import InkdryerKit
import SwiftUI

public struct ProgressCapsule: View {
    public init() { }
    
    @StateObject private var model = Model()
    
    @Environment(\.colorScheme) private var scheme
    
    public var body: some View {
        ZStack {
            Capsule()
                .fill(capsuleBackground.color)
            
            Capsule()
                .trim(from: .zero, to: model.trim)
                .stroke(outline.color, style: StrokeStyle(lineWidth: 2))
                .opacity(model.trimOpacity)
                .animation(.easeOut.speed(0.5), value: model.trim)
                .animation(.easeOut.speed(0.5), value: model.trimOpacity)
            
            Capsule()
                .fill(flashColor.color)
                .opacity(model.flashOpacity)
        }
        .frame(height: 24)
    }
    
    private var capsuleBackground: any InkDryerColor {
        switch scheme {
        case .light:        return Gray.seven
        case .dark:         return Gray.thirteen
        @unknown default:   return Gray.baseColor
        }
    }
    
    private var flashColor: any InkDryerColor {
        switch scheme {
        case .light:        return Gray.eight
        case .dark:         return Gray.nine
        @unknown default:   return White.baseColor
        }
    }
    
    private var outline: any InkDryerColor {
        switch scheme {
        case .light:        return Gray.nine
        case .dark:         return Gray.baseColor
        @unknown default:   return Gray.baseColor
        }
    }
}

extension ProgressCapsule {
    @MainActor
        class Model: ObservableObject {
            init() {
                self.subscription = Timer.publish(every: 3.5, on: .current, in: .common)
                    .autoconnect()
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] _ in
                        self?.flash()
                    }
                
                flash()
            }
            
            @Published var flashOpacity: CGFloat   = 0.0
            @Published var trim: CGFloat           = 0.0
            @Published var trimOpacity: CGFloat    = .zero
            
            var subscription: AnyCancellable?
            
            func flash() {
                Task {
                    trimOpacity  = 1.0
                    trim         = 1.0
                    
                    try! await Task.sleep(for: .seconds(1))
                    flashOpacity = 1.0
                    try! await Task.sleep(for: .seconds(0.1))
                    flashOpacity = .zero
                    
                    try! await Task.sleep(for: .seconds(0.2))
                    trimOpacity  = .zero
                    try! await Task.sleep(for: .seconds(1.5))
                    trim         = .zero
                }
            }
        }
}

struct ProgressCapsule_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCapsule()
            .frame(height: 24)
            .padding()
    }
}
