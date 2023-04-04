import InkdryerKit
import SwiftUI

public struct ProgressButtonOne<Label: View>: View {
    public init(
        @ViewBuilder label: @escaping () -> Label,
        action: @escaping () async -> Void
    ) {
        self.label = label
        self._model = StateObject(wrappedValue: TaskModel(action))
    }
    
    @StateObject private var model: TaskModel
    
    private var label: () -> Label
    
    public var body: some View {
        Button(action: model.performTask, label: label)
            .buttonStyle(ProgressOneStyle(isBusy: model.isBusy))
    }
}

struct ProgressOneStyle: ButtonStyle {
    @Environment(\.colorScheme) private var scheme
    
    let isBusy: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configureLabel(AnyView(configuration.label), busy: AnyView(BouncingDots()), isPressed: configuration.isPressed)
        }
        .animation(.default, value: isBusy)
    }
    
    @ViewBuilder
    private func configureLabel(_ label: AnyView, busy: AnyView, isPressed: Bool) -> some View {
        VStack {
            switch isBusy {
            case false: label
            case true: busy
            }
        }
        .foregroundColor(isPressed ? Gray.baseColor.color : White.baseColor.color)
        .frame(minWidth: 120, maxWidth: .infinity, minHeight: 24, maxHeight: .infinity)
        .background(Blue.baseColor.color)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct ProgressButtonOne_Previews: PreviewProvider {
    static var previews: some View {
        ProgressButtonOne {
            Text("Hello, Button One!")
        } action: {
            try! await Task.sleep(for: .seconds(7))
        }
        .frame(maxWidth: 160, maxHeight: 40)
    }
}
