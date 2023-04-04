import Combine
import SwiftUI

@MainActor
class ProgressModel: ObservableObject {
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
