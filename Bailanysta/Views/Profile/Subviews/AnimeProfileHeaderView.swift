//
//  AnimeProfileHeaderView.swift
//  Bailanysta
//
//  Created by Tamirlan Aubakirov on 05/09/25.
//

import SwiftUI

struct AnimeProfileHeaderView: View {
    let user: User
    @ObservedObject var themeManager: AnimeThemeManager
    let onEditProfile: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            // Profile image with anime style
            ZStack {
                Circle()
                    .fill(themeManager.currentTheme.primaryGradient)
                    .frame(width: 120, height: 120)
                    .shadow(color: themeManager.currentTheme.accentColor.opacity(0.3), radius: 15, x: 0, y: 8)

                Circle()
                    .fill(Color(.systemBackground))
                    .frame(width: 110, height: 110)

                // Use actual profile image if available
                if let imageName = user.profileImageName {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 110, height: 110)
                        .clipShape(Circle())
                } else {
                    Text(user.displayName.prefix(1))
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .foregroundColor(themeManager.currentTheme.accentColor)
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 1, y: 1)
                }
            }

            // User info
            VStack(spacing: 8) {
                Text(user.displayName)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                Text("@\(user.username)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                if let bio = user.bio {
                    Text(bio)
                        .font(.body)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.top, 4)
                }

                HStack(spacing: 4) {
                    Text("Joined")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(user.joinDate, style: .date)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(themeManager.currentTheme.accentColor)
                }
            }

            // Edit profile button
            Button(action: onEditProfile) {
                HStack(spacing: 8) {
                    Image(systemName: "pencil")
                    Text("Edit Profile ✨")
                        .fontWeight(.semibold)
                }
                .font(.headline)
                .foregroundColor(themeManager.currentTheme.accentColor)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color(.systemBackground))
                        .shadow(color: themeManager.currentTheme.accentColor.opacity(0.2), radius: 5, x: 0, y: 3)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(themeManager.currentTheme.accentColor, lineWidth: 2)
                )
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(.systemBackground))
                .shadow(color: themeManager.currentTheme.accentColor.opacity(0.1), radius: 15, x: 0, y: 8)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(themeManager.currentTheme.accentColor.opacity(0.3), lineWidth: 2)
        )
        .padding(.horizontal)
    }
}
