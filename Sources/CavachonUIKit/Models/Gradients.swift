import InkdryerKit
import SwiftUI

enum Gradients {
    static func actionOutlineGradient(_ scheme: ColorScheme) -> LinearGradient {
        switch scheme {
        case .dark:         return LinearGradient(colors: [Gray.thirteen.color, Gray.twelve.color], startPoint: .trailing, endPoint: .leading)
        case .light:        return LinearGradient(colors: [Blue.eight.color, Blue.baseColor.color], startPoint: .trailing, endPoint: .leading)
        @unknown default:   return LinearGradient(colors: [.clear, Gray.nine.color], startPoint: .trailing, endPoint: .leading)
        }
    }
    
    static func placeholderBackgroundGradient(_ scheme: ColorScheme) -> LinearGradient {
        switch scheme {
        case .dark:         return LinearGradient(colors: [Gray.thirteen.color, Gray.eleven.color], startPoint: .trailing, endPoint: .leading)
        case .light:        return LinearGradient(colors: [Gray.seven.color, Gray.eight.color], startPoint: .trailing, endPoint: .leading)
        @unknown default:   return LinearGradient(colors: [.clear, Gray.nine.color], startPoint: .trailing, endPoint: .leading)
        }
    }
    
    static func placeholderOutlineGradient(_ scheme: ColorScheme) -> LinearGradient {
        switch scheme {
        case .dark:         return LinearGradient(colors: [Gray.thirteen.color, Gray.twelve.color], startPoint: .trailing, endPoint: .leading)
        case .light:        return LinearGradient(colors: [Gray.seven.color, Gray.nine.color], startPoint: .trailing, endPoint: .leading)
        @unknown default:   return LinearGradient(colors: [.clear, Gray.nine.color], startPoint: .trailing, endPoint: .leading)
        }
    }
}
