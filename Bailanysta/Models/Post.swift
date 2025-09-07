//
//  Post.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import Foundation

struct Post: Identifiable, Codable {
    let id: UUID
    let author: User
    let content: String
    let timestamp: Date
    var likes: Int
    var likedBy: [UUID] // Track which users have liked this post
    var comments: [Comment]
    let imageURL: String?
    
    init(author: User, content: String, imageURL: String? = nil, likes: Int = 0, comments: [Comment] = []) {
        self.id = UUID()
        self.author = author
        self.content = content
        self.timestamp = Date()
        self.likes = likes
        self.likedBy = []
        self.comments = comments
        self.imageURL = imageURL
    }
    
    // Helper method to check if a user has liked this post
    func isLikedBy(_ user: User) -> Bool {
        return likedBy.contains(user.id)
    }
    
    // Helper method to toggle like for a user
    mutating func toggleLike(for user: User) {
        if isLikedBy(user) {
            // Remove like
            likedBy.removeAll { $0 == user.id }
            likes = max(0, likes - 1)
        } else {
            // Add like
            likedBy.append(user.id)
            likes += 1
        }
    }
}

struct Comment: Identifiable, Codable {
    let id: UUID
    let author: User
    let content: String
    let timestamp: Date
    
    init(author: User, content: String) {
        self.id = UUID()
        self.author = author
        self.timestamp = Date()
        self.content = content
    }
}

// MARK: - Sample Data
extension Post {
    static let samplePosts: [Post] = [
        Post(author: User.sampleUsers[0], content: "Сегодня летел из Алматы в Астану. Погода отличная, вид сверху просто невероятный! ✈️ Каждый раз поражаюсь красоте нашей страны с высоты птичьего полета! 🛩️ #Пилот #Авиация #Казахстан", imageURL: nil, likes: 45, comments: [
            Comment(author: User.sampleUsers[1], content: "Круто! А какой самолет пилотируешь? 🚀"),
            Comment(author: User.sampleUsers[2], content: "Завидую! Мечтаю полетать с тобой! ✈️")
        ]),
        Post(author: User.sampleUsers[1], content: "JobEscape растет! 🚀 Запустили новую функцию анализа акций. Теперь инвесторы могут принимать более обоснованные решения! 📈 Кто-нибудь уже попробовал? #JobEscape #Инвестиции #Акции", imageURL: nil, likes: 32, comments: [
            Comment(author: User.sampleUsers[3], content: "Отличная идея! Попробую обязательно! 🎉"),
            Comment(author: User.sampleUsers[4], content: "Молодцы! Развиваете инвестиционную культуру! 💪")
        ]),
        Post(author: User.sampleUsers[2], content: "Работаем над новой архитектурой JobEscape! 💻 Сложно, но очень интересно. Каждый день изучаю что-то новое в области финансовых алгоритмов! 🌟 #CTO #Разработка #JobEscape", imageURL: nil, likes: 28, comments: [
            Comment(author: User.sampleUsers[0], content: "Удачи с архитектурой! Сложная задача! ✨")
        ]),
        Post(author: User.sampleUsers[0], content: "Вчера был сложный полет в Шымкент. Сильный ветер, но справился! 💪 Опыт - это самое ценное в нашей профессии. Каждый полет учит чему-то новому! 🛩️ #Пилот #Опыт #Авиация", imageURL: nil, likes: 67, comments: [
            Comment(author: User.sampleUsers[1], content: "Респект! Безопасность превыше всего! 💯"),
            Comment(author: User.sampleUsers[3], content: "Горжусь тобой, брат! 📚"),
            Comment(author: User.sampleUsers[4], content: "Настоящий профессионал! 🌟")
        ]),
        Post(author: User.sampleUsers[3], content: "Подготовка к чемпионату идет полным ходом! 🥊 Каждый день тренировки, диета, режим. Цель - золото! 💪 Кто поддерживает? #Бокс #Чемпионат #Тренировки", imageURL: nil, likes: 41, comments: [
            Comment(author: User.sampleUsers[2], content: "Удачи на чемпионате! Ты справишься! 📱"),
            Comment(author: User.sampleUsers[1], content: "Болеем за тебя! 💪")
        ]),
        Post(author: User.sampleUsers[4], content: "Работаю над системой оптимизации эффективности железных дорог! 🚂 Создаю алгоритмы для улучшения использования инфраструктуры в разных странах! 🚄 #ЖелезныеДороги #Оптимизация #Эффективность", imageURL: nil, likes: 23, comments: [
            Comment(author: User.sampleUsers[0], content: "Интересный проект! Удачи! 🤝")
        ]),
        Post(author: User.sampleUsers[1], content: "JobEscape теперь доступен в 5 городах Казахстана! 🚀 Алматы, Астана, Шымкент, Актобе, Атырау. Инвестиционное сообщество растет! 📈 #JobEscape #Инвестиции #Казахстан", imageURL: nil, likes: 19, comments: []),
        Post(author: User.sampleUsers[0], content: "Сегодня был первый полет с новым курсантом. Передаю опыт молодому поколению пилотов! ✈️ Важно делиться знаниями в авиации! 🛩️ #Пилот #Обучение #Авиация", imageURL: nil, likes: 38, comments: [
            Comment(author: User.sampleUsers[3], content: "Отличный наставник! 👨‍✈️"),
            Comment(author: User.sampleUsers[2], content: "Передаешь опыт - это круто! ✈️")
        ]),
        Post(author: User.sampleUsers[2], content: "Изучаю новые технологии для JobEscape! 💻 Machine Learning для анализа рынка акций - это будущее! Очень увлекательно! 🌟 #ML #ИИ #JobEscape", imageURL: nil, likes: 25, comments: [
            Comment(author: User.sampleUsers[4], content: "Инновационный подход! Удачи! ✨")
        ]),
        Post(author: User.sampleUsers[3], content: "Победа в полуфинале! 🥊 Следующий бой - финал чемпионата! Все ближе к мечте! 💪 Спасибо всем за поддержку! #Бокс #Победа #Финал", imageURL: nil, likes: 52, comments: [
            Comment(author: User.sampleUsers[1], content: "Поздравляю с победой! 🎉"),
            Comment(author: User.sampleUsers[0], content: "Гордимся тобой! 💪"),
            Comment(author: User.sampleUsers[2], content: "Вперед к золоту! 🥇")
        ]),
        Post(author: User.sampleUsers[4], content: "Разрабатываю алгоритмы для оптимизации расписания поездов! 🚄 Улучшаю эффективность использования железнодорожной инфраструктуры! 🌱 #Оптимизация #Алгоритмы #ЖелезныеДороги", imageURL: nil, likes: 21, comments: []),
        Post(author: User.sampleUsers[0], content: "Авиация - это не просто работа, это страсть! ✈️ Каждый взлет - это новые возможности, каждый полет - новые горизонты! 🛩️ #Страсть #Авиация #Мечта", imageURL: nil, likes: 44, comments: [
            Comment(author: User.sampleUsers[1], content: "Вдохновляешь! 🚀"),
            Comment(author: User.sampleUsers[3], content: "Истинный пилот! ✈️")
        ])
    ]
}
