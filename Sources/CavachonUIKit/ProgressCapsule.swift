import Combine
import SwiftUI

public struct ProgressCapsule: View {
    public init() { }
    
    @StateObject private var model = Model()
    
    public var body: some View {
        ZStack {
            Capsule()
                .fill(Color.gray.opacity(0.2))
            
            Capsule()
                .trim(from: .zero, to: model.trim)
                .stroke(lineWidth: 2)
                .opacity(model.trimOpacity)
                .animation(.easeOut.speed(0.5), value: model.trim)
                .animation(.easeOut.speed(0.5), value: model.trimOpacity)
            
            Capsule()
                .fill(Color.white)
                .opacity(model.flashOpacity)
        }
        .frame(height: 24)
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
    }
}
