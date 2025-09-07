//
//  User.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    let username: String
    let displayName: String
    let email: String
    let joinDate: Date
    let bio: String?
    let profileImageURL: String?
    let profileImageName: String?
    
    init(username: String, displayName: String, email: String, bio: String? = nil, profileImageURL: String? = nil, profileImageName: String? = nil) {
        self.id = UUID()
        self.username = username
        self.displayName = displayName
        self.email = email
        self.joinDate = Date()
        self.bio = bio
        self.profileImageURL = profileImageURL
        self.profileImageName = profileImageName
    }
}

// MARK: - Sample Data
extension User {
    static let sampleUsers: [User] = [
        User(username: "maksat_pilot", displayName: "Максат Пилот ✈️", email: "maksat.pilot@mail.ru", bio: "Пилот самолета. Рассказываю о ежедневной работе в авиации! 🛩️", profileImageURL: nil, profileImageName: "maks"),
        User(username: "moris_ceo", displayName: "Морис CEO 🚀", email: "moris@jobescape.com", bio: "CEO и сооснователь JobEscape - платформы для инвестиций в акции! 📈", profileImageURL: nil, profileImageName: "moris"),
        User(username: "margo_cto", displayName: "Марго CTO 💻", email: "margo@jobescape.com", bio: "CTO JobEscape. Помогаем людям инвестировать и изучать фондовый рынок! 🌟", profileImageURL: nil, profileImageName: "margo"),
        User(username: "nariman_boxer", displayName: "Нариман Боксер 🥊", email: "nariman.boxer@gmail.com", bio: "Профессиональный боксер. Тренируюсь каждый день! 💪", profileImageURL: nil, profileImageName: "narik"),
        User(username: "anuar_railways", displayName: "Ануар Железные дороги 🚂", email: "anuar@railways.uz", bio: "Создаю систему оптимизации эффективности использования железных дорог в разных странах! 🚄", profileImageURL: nil, profileImageName: "anuar")
    ]
}
