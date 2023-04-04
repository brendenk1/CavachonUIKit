import SwiftUI

struct BouncingDots: View {
    @StateObject private var model = Model()
    
    var body: some View {
        HStack {
            Text(".")
                .offset(y: model.firstOffset)
            
            Text(".")
                .offset(y: model.secondOffset)
            
            Text(".")
                .offset(y: model.thirdOffset)
        }
        .font(.largeTitle)
        .animation(.easeIn.repeatForever(), value: model.firstOffset)
        .animation(.easeIn.repeatForever(), value: model.secondOffset)
        .animation(.easeIn.repeatForever(), value: model.thirdOffset)
    }
}

extension BouncingDots {
    @MainActor
    final class Model: ObservableObject {
        init() {
            animateOffsets()
        }
        
        @Published var firstOffset: CGFloat     = .zero
        @Published var secondOffset: CGFloat    = .zero
        @Published var thirdOffset: CGFloat     = .zero
        
        func animateOffsets() {
            Task {
                firstOffset     = -30
                try! await Task.sleep(for: .seconds(0.1))
                
                firstOffset     = .zero
                secondOffset    = -30
                try! await Task.sleep(for: .seconds(0.1))
                
                secondOffset    = .zero
                thirdOffset     = -30
                try! await Task.sleep(for: .seconds(0.1))
                
                thirdOffset     = .zero
            }
        }
    }
}

struct BouncingDots_Previews: PreviewProvider {
    static var previews: some View {
        BouncingDots()
    }
}
