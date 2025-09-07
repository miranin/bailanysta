//
//  HapticManager.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import UIKit
import SwiftUI

class HapticManager {
    static let shared = HapticManager()
    
    private init() {}
    
    // MARK: - Haptic Feedback Types
    
    enum HapticType {
        case light
        case medium
        case heavy
        case success
        case warning
        case error
        case selection
    }
    
    func impact(_ type: HapticType) {
        switch type {
        case .light:
            let impactFeedback = UIImpactFeedbackGenerator(style: .light)
            impactFeedback.impactOccurred()
            
        case .medium:
            let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
            impactFeedback.impactOccurred()
            
        case .heavy:
            let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
            impactFeedback.impactOccurred()
            
        case .success:
            let notificationFeedback = UINotificationFeedbackGenerator()
            notificationFeedback.notificationOccurred(.success)
            
        case .warning:
            let notificationFeedback = UINotificationFeedbackGenerator()
            notificationFeedback.notificationOccurred(.warning)
            
        case .error:
            let notificationFeedback = UINotificationFeedbackGenerator()
            notificationFeedback.notificationOccurred(.error)
            
        case .selection:
            let selectionFeedback = UISelectionFeedbackGenerator()
            selectionFeedback.selectionChanged()
        }
    }
    
    // MARK: - Convenience Methods
    
    func like() {
        impact(.light)
    }
    
    func comment() {
        impact(.medium)
    }
    
    func postCreated() {
        impact(.success)
    }
    
    func postDeleted() {
        impact(.warning)
    }
    
    func themeChanged() {
        impact(.selection)
    }
    
    func buttonTap() {
        impact(.light)
    }
    
    func error() {
        impact(.error)
    }
}

// MARK: - SwiftUI View Modifier

struct HapticFeedback: ViewModifier {
    let hapticType: HapticManager.HapticType
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                HapticManager.shared.impact(hapticType)
                action()
            }
    }
}

// MARK: - SwiftUI Extension

extension View {
    func hapticFeedback(_ type: HapticManager.HapticType, action: @escaping () -> Void) -> some View {
        self.modifier(HapticFeedback(hapticType: type, action: action))
    }
    
    func hapticLike(_ action: @escaping () -> Void) -> some View {
        self.hapticFeedback(.light, action: action)
    }
    
    func hapticComment(_ action: @escaping () -> Void) -> some View {
        self.hapticFeedback(.medium, action: action)
    }
    
    func hapticSuccess(_ action: @escaping () -> Void) -> some View {
        self.hapticFeedback(.success, action: action)
    }
    
    func hapticButton(_ action: @escaping () -> Void) -> some View {
        self.hapticFeedback(.light, action: action)
    }
}
