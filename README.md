# 🌸 Bailanysta - Anime-Themed Social Media App

A beautiful iOS social media app built with SwiftUI, featuring anime-inspired design and smooth animations.

## 📱 What We Built

### Core Features
- **Social Feed**: Browse posts from friends with like and comment functionality
- **User Profiles**: View user profiles with posts, stats, and profile editing
- **Post Creation**: Create new posts with beautiful UI and animations
- **Real-time Updates**: Posts sync instantly between feed and profile pages
- **Like System**: Like/unlike posts with haptic feedback and particle effects

### UI/UX Enhancements
- **Anime Theme**: Beautiful gradient backgrounds and anime-inspired colors
- **Smooth Animations**: Custom transitions, particle effects, and micro-interactions
- **Haptic Feedback**: Tactile responses for all user interactions
- **Custom Components**: Floating action buttons, animated tab bars, pull-to-refresh
- **Profile Images**: Support for custom user avatars from image assets

### Technical Architecture
- **MVP Pattern**: Clean separation between Models, Views, and Presenters
- **Shared Data Management**: Centralized data source for consistent state
- **Reactive Updates**: Real-time synchronization using Combine framework
- **Modular Design**: Organized file structure with reusable components

## 🛠️ Technical Stack

- **SwiftUI**: Modern declarative UI framework
- **Combine**: Reactive programming for data flow
- **MVVM/MVP**: Clean architecture pattern
- **iOS 15+**: Latest iOS features and APIs

## 📁 Project Structure

```
Bailanysta/
├── Models/           # Data models (User, Post, Comment)
├── Views/            # SwiftUI views organized by feature
│   ├── Feed/         # Feed-related views
│   ├── Profile/      # Profile-related views
│   ├── Main/         # Main navigation and settings
│   └── Components/   # Reusable UI components
├── Presenters/       # Business logic and data management
├── Data/             # Shared data managers
├── Theme/            # App theming and styling
└── Utils/            # Utility classes and helpers
```

## 🚀 Getting Started

### Prerequisites
- **Xcode 14.0+** (Latest version recommended)
- **iOS 15.0+** target device or simulator
- **macOS 12.0+** for development

### Installation Steps

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/Bailanysta.git
   cd Bailanysta
   ```

2. **Open in Xcode**
   ```bash
   open Bailanysta.xcodeproj
   ```

3. **Select Target Device**
   - Choose your iOS device or simulator from the device selector
   - Recommended: iPhone 14 Pro or newer for best experience

4. **Build and Run**
   - Press `Cmd + R` or click the "Play" button in Xcode
   - Wait for the build to complete (first build may take a few minutes)

### Running on Physical Device

1. **Connect your iPhone** via USB cable
2. **Trust the computer** when prompted on your device
3. **Select your device** from the device selector in Xcode
4. **Sign in with Apple ID** in Xcode preferences (Xcode → Preferences → Accounts)
5. **Update signing settings**:
   - Select the project in navigator
   - Go to "Signing & Capabilities" tab
   - Choose your development team
   - Xcode will automatically manage provisioning

6. **Build and run** - the app will install on your device

### Running on Simulator

1. **Open Xcode**
2. **Select a simulator** from the device selector (iPhone 15 Pro recommended)
3. **Press Cmd + R** to build and run
4. **Wait for simulator to launch** and app to install

## 🎮 How to Use

### Getting Started
1. **Launch the app** - you'll see the main feed
2. **Browse posts** - scroll through posts from sample users
3. **Like posts** - tap the heart button to like/unlike
4. **View comments** - tap the comment button to see and add comments
5. **Create posts** - tap the floating "+" button to create new posts

### Navigation
- **Feed Tab**: Main social feed with all posts
- **Profile Tab**: Your personal profile and posts
- **Settings**: Access theme selection and user switching

### Features to Try
- **Like System**: Like a post, then unlike it - notice the smooth animation
- **Post Creation**: Create a post in feed, then check your profile - it appears instantly
- **Theme Switching**: Go to settings and try different anime themes
- **User Switching**: Switch between different sample users
- **Pull to Refresh**: Pull down on the feed to refresh posts

## 🎨 Customization

### Adding New Themes
1. Open `Bailanysta/Theme/AnimeTheme.swift`
2. Add new theme colors and gradients
3. Update the theme selection in settings

### Adding New Users
1. Open `Bailanysta/Models/User.swift`
2. Add new users to the `sampleUsers` array
3. Include profile images in `Assets.xcassets`

### Modifying Posts
1. Open `Bailanysta/Models/Post.swift`
2. Update the `samplePosts` array with new content
3. Posts support text content and can be extended for images

## 🐛 Troubleshooting

### Common Issues

**Build Errors**
- Clean build folder: `Product → Clean Build Folder`
- Restart Xcode
- Check iOS deployment target matches your device

**App Crashes**
- Check console logs in Xcode
- Ensure all required image assets are present
- Verify iOS version compatibility

**Posts Not Syncing**
- The app uses sample data - posts are shared between feed and profile
- New posts created in feed should appear in profile immediately

**Simulator Issues**
- Reset simulator: `Device → Erase All Content and Settings`
- Try different simulator device
- Restart Xcode

## 📝 Sample Data

The app comes with sample data featuring:
- **5 Sample Users**: Friends with different professions and interests
- **Sample Posts**: Realistic social media content in Russian
- **Profile Images**: Custom avatar images for each user
- **Comments**: Interactive comments on posts

## 🔮 Future Enhancements

Potential features for future development:
- **Image Posts**: Support for photo uploads
- **Push Notifications**: Real-time notifications
- **User Authentication**: Login/signup system
- **Backend Integration**: Real server data
- **Dark Mode**: Enhanced dark theme support
- **Search**: Find users and posts
- **Stories**: Temporary content sharing

## 👨‍💻 Development

### Architecture Decisions
- **MVP Pattern**: Clean separation of concerns
- **Shared Data Manager**: Single source of truth for posts
- **Reactive Programming**: Combine for real-time updates
- **Modular Components**: Reusable UI elements

### Key Files
- `PostsDataManager.swift`: Central data management
- `FeedPresenter.swift`: Feed business logic
- `ProfilePresenter.swift`: Profile business logic
- `AnimeTheme.swift`: App theming system

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📞 Support

If you encounter any issues or have questions:
1. Check the troubleshooting section above
2. Open an issue on GitHub
3. Contact me

---

**Built with ❤️ using SwiftUI and modern iOS development practices**

*Enjoy exploring the beautiful world of Bailanysta! 🌸✨*