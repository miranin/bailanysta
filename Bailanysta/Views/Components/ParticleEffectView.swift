//
//  ParticleEffectView.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

struct ParticleEffectView: View {
    let particles: [Particle]
    @State private var animationOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            ForEach(particles, id: \.id) { particle in
                Text(particle.emoji)
                    .font(.system(size: particle.size))
                    .offset(
                        x: particle.startX + (particle.endX - particle.startX) * animationOffset,
                        y: particle.startY + (particle.endY - particle.startY) * animationOffset
                    )
                    .opacity(1 - animationOffset)
                    .scaleEffect(1 + animationOffset * 0.5)
                    .rotationEffect(.degrees(particle.rotation * animationOffset))
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.0)) {
                animationOffset = 1.0
            }
        }
    }
}

struct Particle {
    let id = UUID()
    let emoji: String
    let size: CGFloat
    let startX: CGFloat
    let startY: CGFloat
    let endX: CGFloat
    let endY: CGFloat
    let rotation: Double
}

// MARK: - Particle Generator

class ParticleGenerator {
    static func generateLikeParticles(center: CGPoint, theme: AnimeThemeManager.AnimeTheme) -> [Particle] {
        let emojis = ["💖", "❤️", "✨", "💫", "🌟", "💕", "😍", "🥰"]
        var particles: [Particle] = []
        
        for i in 0..<8 {
            let angle = Double(i) * 45.0
            let distance: CGFloat = 80
            let endX = center.x + cos(angle * .pi / 180) * distance
            let endY = center.y + sin(angle * .pi / 180) * distance
            
            particles.append(Particle(
                emoji: emojis.randomElement() ?? "💖",
                size: CGFloat.random(in: 16...24),
                startX: center.x,
                startY: center.y,
                endX: endX,
                endY: endY,
                rotation: Double.random(in: -180...180)
            ))
        }
        
        return particles
    }
    
    static func generateCommentParticles(center: CGPoint, theme: AnimeThemeManager.AnimeTheme) -> [Particle] {
        let emojis = ["💬", "✨", "💭", "🗨️", "💫", "🌟"]
        var particles: [Particle] = []
        
        for i in 0..<6 {
            let angle = Double(i) * 60.0
            let distance: CGFloat = 60
            let endX = center.x + cos(angle * .pi / 180) * distance
            let endY = center.y + sin(angle * .pi / 180) * distance
            
            particles.append(Particle(
                emoji: emojis.randomElement() ?? "💬",
                size: CGFloat.random(in: 14...20),
                startX: center.x,
                startY: center.y,
                endX: endX,
                endY: endY,
                rotation: Double.random(in: -90...90)
            ))
        }
        
        return particles
    }
    
    static func generatePostCreatedParticles(center: CGPoint, theme: AnimeThemeManager.AnimeTheme) -> [Particle] {
        let emojis = ["🎉", "✨", "💫", "🌟", "🚀", "💖", "🎊", "⭐"]
        var particles: [Particle] = []
        
        for i in 0..<12 {
            let angle = Double(i) * 30.0
            let distance: CGFloat = 100
            let endX = center.x + cos(angle * .pi / 180) * distance
            let endY = center.y + sin(angle * .pi / 180) * distance
            
            particles.append(Particle(
                emoji: emojis.randomElement() ?? "🎉",
                size: CGFloat.random(in: 18...28),
                startX: center.x,
                startY: center.y,
                endX: endX,
                endY: endY,
                rotation: Double.random(in: -360...360)
            ))
        }
        
        return particles
    }
}

// MARK: - Particle Effect Overlay

struct ParticleEffectOverlay: View {
    @State private var particles: [Particle] = []
    @State private var showParticles = false
    
    var body: some View {
        ZStack {
            if showParticles {
                ParticleEffectView(particles: particles)
                    .allowsHitTesting(false)
            }
        }
    }
    
    func showLikeEffect(at center: CGPoint, theme: AnimeThemeManager.AnimeTheme) {
        particles = ParticleGenerator.generateLikeParticles(center: center, theme: theme)
        showParticles = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            showParticles = false
        }
    }
    
    func showCommentEffect(at center: CGPoint, theme: AnimeThemeManager.AnimeTheme) {
        particles = ParticleGenerator.generateCommentParticles(center: center, theme: theme)
        showParticles = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            showParticles = false
        }
    }
    
    func showPostCreatedEffect(at center: CGPoint, theme: AnimeThemeManager.AnimeTheme) {
        particles = ParticleGenerator.generatePostCreatedParticles(center: center, theme: theme)
        showParticles = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            showParticles = false
        }
    }
}
