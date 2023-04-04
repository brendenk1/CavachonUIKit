import Foundation

@MainActor
final class TaskModel: ObservableObject {
    init(_ action: @escaping () async -> Void) {
        self.task = action
    }
    
    private let task: () async -> Void
    
    @Published var isBusy = false
    
    func performTask() {
        Task {
            isBusy = true
            await task()
            isBusy = false
        }
    }
}
