//
//  AnimeTheme.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

// MARK: - Anime Color Palette
struct AnimeColors {
    // Pastel Anime Colors
    static let sakuraPink = Color(red: 1.0, green: 0.8, blue: 0.9)
    static let mintGreen = Color(red: 0.6, green: 1.0, blue: 0.8)
    static let lavender = Color(red: 0.9, green: 0.8, blue: 1.0)
    static let peach = Color(red: 1.0, green: 0.9, blue: 0.7)
    static let skyBlue = Color(red: 0.7, green: 0.9, blue: 1.0)
    static let coral = Color(red: 1.0, green: 0.6, blue: 0.6)
    
    // Vibrant Anime Colors
    static let neonPink = Color(red: 1.0, green: 0.2, blue: 0.8)
    static let electricBlue = Color(red: 0.2, green: 0.6, blue: 1.0)
    static let limeGreen = Color(red: 0.6, green: 1.0, blue: 0.2)
    static let sunsetOrange = Color(red: 1.0, green: 0.5, blue: 0.2)
    static let purple = Color(red: 0.6, green: 0.2, blue: 1.0)
    static let cyan = Color(red: 0.2, green: 0.9, blue: 1.0)
    
    // Dark Anime Colors
    static let darkPurple = Color(red: 0.2, green: 0.1, blue: 0.3)
    static let darkBlue = Color(red: 0.1, green: 0.2, blue: 0.4)
    static let darkPink = Color(red: 0.4, green: 0.1, blue: 0.2)
}

// MARK: - Anime Gradients
struct AnimeGradients {
    static let sakura = LinearGradient(
        colors: [AnimeColors.sakuraPink, AnimeColors.peach],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let ocean = LinearGradient(
        colors: [AnimeColors.skyBlue, AnimeColors.mintGreen],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let sunset = LinearGradient(
        colors: [AnimeColors.sunsetOrange, AnimeColors.coral],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let neon = LinearGradient(
        colors: [AnimeColors.neonPink, AnimeColors.purple],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let cosmic = LinearGradient(
        colors: [AnimeColors.darkPurple, AnimeColors.purple, AnimeColors.neonPink],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let aurora = LinearGradient(
        colors: [AnimeColors.mintGreen, AnimeColors.cyan, AnimeColors.electricBlue],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

// MARK: - Anime Theme Manager
class AnimeThemeManager: ObservableObject {
    @Published var currentTheme: AnimeTheme = .sakura
    @Published var isDarkMode: Bool = false
    
    enum AnimeTheme: String, CaseIterable {
        case sakura = "Sakura"
        case ocean = "Ocean"
        case sunset = "Sunset"
        case neon = "Neon"
        case cosmic = "Cosmic"
        case aurora = "Aurora"
        
        var primaryGradient: LinearGradient {
            switch self {
            case .sakura: return AnimeGradients.sakura
            case .ocean: return AnimeGradients.ocean
            case .sunset: return AnimeGradients.sunset
            case .neon: return AnimeGradients.neon
            case .cosmic: return AnimeGradients.cosmic
            case .aurora: return AnimeGradients.aurora
            }
        }
        
        var accentColor: Color {
            switch self {
            case .sakura: return AnimeColors.sakuraPink
            case .ocean: return AnimeColors.skyBlue
            case .sunset: return AnimeColors.sunsetOrange
            case .neon: return AnimeColors.neonPink
            case .cosmic: return AnimeColors.purple
            case .aurora: return AnimeColors.cyan
            }
        }
        
        var emoji: String {
            switch self {
            case .sakura: return "🌸"
            case .ocean: return "🌊"
            case .sunset: return "🌅"
            case .neon: return "💫"
            case .cosmic: return "🌌"
            case .aurora: return "✨"
            }
        }
    }
}

// MARK: - Anime Style Modifiers
struct AnimeCardStyle: ViewModifier {
    let theme: AnimeThemeManager.AnimeTheme
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(theme.primaryGradient)
                    .shadow(color: theme.accentColor.opacity(0.3), radius: 10, x: 0, y: 5)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(theme.accentColor.opacity(0.5), lineWidth: 2)
            )
    }
}

struct AnimeButtonStyle: ButtonStyle {
    let theme: AnimeThemeManager.AnimeTheme
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(theme.primaryGradient)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(theme.accentColor, lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - Anime Avatar Generator
struct AnimeAvatarGenerator {
    static func generateAvatar(for user: User, theme: AnimeThemeManager.AnimeTheme) -> some View {
        // Check if user has a profile image
        if let imageName = user.profileImageName {
            return AnyView(
                Circle()
                    .fill(Color.clear)
                    .overlay(
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                    )
                    .overlay(
                        Circle()
                            .stroke(theme.accentColor, lineWidth: 3)
                    )
            )
        } else {
            // Fallback to generated avatar
            let colors = [AnimeColors.neonPink, AnimeColors.electricBlue, AnimeColors.limeGreen, 
                         AnimeColors.sunsetOrange, AnimeColors.purple, AnimeColors.cyan]
            let randomColor = colors[abs(user.id.hashValue) % colors.count]
            
            return AnyView(
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [randomColor, randomColor.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        Text(user.displayName.prefix(1))
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
                    )
                    .overlay(
                        Circle()
                            .stroke(theme.accentColor, lineWidth: 3)
                    )
            )
        }
    }
}

// MARK: - Anime Emojis
struct AnimeEmojis {
    static let reactions = ["💖", "😍", "🤩", "✨", "🌟", "💫", "🎉", "🔥"]
    static let moods = ["😊", "😌", "🥰", "😇", "🤗", "😋", "😎", "🤓"]
    static let actions = ["💬", "❤️", "🔥", "✨", "👀", "🎯", "🚀", "💎"]
}
