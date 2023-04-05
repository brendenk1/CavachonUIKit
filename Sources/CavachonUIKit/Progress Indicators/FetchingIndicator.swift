import Combine
import InkdryerKit
import SwiftUI

public struct FetchingIndicator: View {
    public init() { }
    
    @StateObject private var model = Model()
    
    public var body: some View {
        VStack {
            ZStack {
                LinearGradient(
                    stops: [
                        .init(color: Gray.thirteen.color, location: 0),
                        .init(color: Gray.seven.color, location: 0.5),
                        .init(color: Gray.thirteen.color, location: 1.0)
                    ],
                    startPoint: UnitPoint(x: .zero, y: .zero),
                    endPoint: UnitPoint(x: model.location, y: .zero)
                )
                .overlay(Material.ultraThin)
                .animation(.easeInOut.speed(0.5),
                           value: model.location)
                
                
                Rectangle()
                    .fill(Gray.thirteen.color)
                    .overlay(Material.ultraThin)
                    .opacity(model.overlayOpacity)
                    .animation(.default, value: model.overlayOpacity)
            }
        }
    }
    
    @MainActor
    class Model: ObservableObject {
        init() {
            let fireTime = Double.random(in: 2.5..<7.0)
            subscription = Timer.publish(every: fireTime, on: .current, in: .common)
                .autoconnect()
                .sink(receiveValue: { [weak self] _ in self?.animate() })
            
            animate()
        }
        
        @Published var location: CGFloat        = .zero
        @Published var overlayOpacity: CGFloat  = .zero
        
        private var subscription: AnyCancellable?
        
        func animate() {
            Task {
                overlayOpacity = .zero
                location = 0.5
                
                try! await Task.sleep(for: .seconds(0.5))
                location = 3.0
                
                try! await Task.sleep(for: .seconds(0.1))
                location = 10.0
                overlayOpacity = 0.5
                
                try! await Task.sleep(for: .seconds(1.0))
                overlayOpacity = 1.0
                location = .zero
            }
        }
    }
}

struct FetchingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FetchingIndicator()
                .frame(height: 24)
            FetchingIndicator()
                .frame(height: 24)
            FetchingIndicator()
                .frame(height: 24)
        }
    }
}
