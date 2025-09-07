//
//  AnimeTransitions.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

// MARK: - Custom Transition Animations

struct AnimeSlideTransition: ViewModifier {
    let isActive: Bool
    let direction: SlideDirection
    
    enum SlideDirection {
        case left, right, up, down
    }
    
    func body(content: Content) -> some View {
        content
            .offset(
                x: direction == .left ? (isActive ? -UIScreen.main.bounds.width : 0) : 
                   direction == .right ? (isActive ? UIScreen.main.bounds.width : 0) : 0,
                y: direction == .up ? (isActive ? -UIScreen.main.bounds.height : 0) :
                   direction == .down ? (isActive ? UIScreen.main.bounds.height : 0) : 0
            )
            .opacity(isActive ? 0 : 1)
            .scaleEffect(isActive ? 0.8 : 1.0)
            .animation(.spring(response: 0.6, dampingFraction: 0.8), value: isActive)
    }
}

struct AnimeFadeTransition: ViewModifier {
    let isActive: Bool
    
    func body(content: Content) -> some View {
        content
            .opacity(isActive ? 0 : 1)
            .scaleEffect(isActive ? 0.9 : 1.0)
            .blur(radius: isActive ? 10 : 0)
            .animation(.easeInOut(duration: 0.5), value: isActive)
    }
}

struct AnimeBounceTransition: ViewModifier {
    let isActive: Bool
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isActive ? 0.3 : 1.0)
            .opacity(isActive ? 0 : 1)
            .rotationEffect(.degrees(isActive ? -180 : 0))
            .animation(.spring(response: 0.5, dampingFraction: 0.6), value: isActive)
    }
}

struct AnimeFlipTransition: ViewModifier {
    let isActive: Bool
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                .degrees(isActive ? 90 : 0),
                axis: (x: 0, y: 1, z: 0)
            )
            .opacity(isActive ? 0 : 1)
            .animation(.easeInOut(duration: 0.6), value: isActive)
    }
}

// MARK: - View Extensions

extension View {
    func animeSlide(_ isActive: Bool, direction: AnimeSlideTransition.SlideDirection = .right) -> some View {
        self.modifier(AnimeSlideTransition(isActive: isActive, direction: direction))
    }
    
    func animeFade(_ isActive: Bool) -> some View {
        self.modifier(AnimeFadeTransition(isActive: isActive))
    }
    
    func animeBounce(_ isActive: Bool) -> some View {
        self.modifier(AnimeBounceTransition(isActive: isActive))
    }
    
    func animeFlip(_ isActive: Bool) -> some View {
        self.modifier(AnimeFlipTransition(isActive: isActive))
    }
}

// MARK: - Tab Transition Manager

class TabTransitionManager: ObservableObject {
    @Published var isTransitioning = false
    @Published var transitionDirection: AnimeSlideTransition.SlideDirection = .right
    
    func transition(to direction: AnimeSlideTransition.SlideDirection) {
        transitionDirection = direction
        isTransitioning = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.isTransitioning = false
        }
    }
}

// MARK: - Custom Tab Transition View

struct TabTransitionView<Content: View>: View {
    let content: Content
    @ObservedObject var transitionManager: TabTransitionManager
    
    init(transitionManager: TabTransitionManager, @ViewBuilder content: () -> Content) {
        self.transitionManager = transitionManager
        self.content = content()
    }
    
    var body: some View {
        content
            .animeSlide(transitionManager.isTransitioning, direction: transitionManager.transitionDirection)
    }
}

// MARK: - Sheet Transition

struct AnimeSheetTransition: ViewModifier {
    let isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isPresented ? 1.0 : 0.8)
            .opacity(isPresented ? 1.0 : 0.0)
            .offset(y: isPresented ? 0 : 50)
            .animation(.spring(response: 0.5, dampingFraction: 0.8), value: isPresented)
    }
}

extension View {
    func animeSheet(_ isPresented: Bool) -> some View {
        self.modifier(AnimeSheetTransition(isPresented: isPresented))
    }
}

// MARK: - Card Transition

struct AnimeCardTransition: ViewModifier {
    let isVisible: Bool
    let delay: Double
    
    func body(content: Content) -> some View {
        content
            .opacity(isVisible ? 1 : 0)
            .offset(y: isVisible ? 0 : 30)
            .scaleEffect(isVisible ? 1 : 0.9)
            .animation(
                .spring(response: 0.6, dampingFraction: 0.8)
                .delay(delay),
                value: isVisible
            )
    }
}

extension View {
    func animeCard(_ isVisible: Bool, delay: Double = 0) -> some View {
        self.modifier(AnimeCardTransition(isVisible: isVisible, delay: delay))
    }
}
