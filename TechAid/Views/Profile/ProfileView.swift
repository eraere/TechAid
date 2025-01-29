import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var showingSettings = false
    @State private var selectedTimeframe = "Week"
    let timeframes = ["Week", "Month", "Year", "All"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    // Profile Header Card
                    PremiumCard {
                        VStack(spacing: 20) {
                            // Profile Image
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 80))
                                .foregroundColor(.white)
                                .overlay(
                                    Circle()
                                        .stroke(.white.opacity(0.2), lineWidth: 4)
                                        .padding(-8)
                                )
                            
                            // User Info
                            VStack(spacing: 8) {
                                Text(authManager.currentUser?.name ?? "John Doe")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.white)
                                
                                Text("AI Enthusiast")
                                    .font(.title3)
                                    .foregroundColor(.white.opacity(0.9))
                                
                                // Level Badge
                                Text("Level 12")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(.white.opacity(0.2))
                                    .cornerRadius(12)
                                    .foregroundColor(.white)
                            }
                            
                            // Stats Overview
                            HStack(spacing: 30) {
                                StatView(value: "12", title: "Courses", icon: "book.fill")
                                StatView(value: "156", title: "Hours", icon: "clock.fill")
                                StatView(value: "23", title: "Certificates", icon: "medal.fill")
                            }
                        }
                    }
                    
                    // Learning Activity
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Learning Activity")
                                .font(.title2)
                                .bold()
                            Spacer()
                            
                            // Time frame picker
                            Picker("Timeframe", selection: $selectedTimeframe) {
                                ForEach(timeframes, id: \.self) { timeframe in
                                    Text(timeframe).tag(timeframe)
                                }
                            }
                            .pickerStyle(.segmented)
                            .frame(width: 200)
                        }
                        
                        // Activity Graph
                        ActivityGraphView()
                            .frame(height: 200)
                            .padding(.vertical)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.05), radius: 10)
                    
                    // Recent Achievements
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Recent Achievements")
                                .font(.title2)
                                .bold()
                            Spacer()
                            NavigationLink("View All") {
                                AchievementsView()
                            }
                            .foregroundColor(.blue)
                        }
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            ForEach(Models.LearningAchievement.samples) { achievement in
                                EnhancedAchievementView(achievement: achievement)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.05), radius: 10)
                    
                    // Current Streak
                    PremiumCard(gradient: [Color(hex: "#FF6B6B"), Color(hex: "#FF8E53")]) {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("🔥 Current Streak")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("12 Days")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            
                            // Streak Calendar
                            HStack(spacing: 4) {
                                ForEach(0..<7) { day in
                                    Circle()
                                        .fill(day < 5 ? Color.white : Color.white.opacity(0.3))
                                        .frame(width: 12, height: 12)
                                }
                            }
                        }
                    }
                    
                    // Settings & Sign Out
                    VStack(spacing: 12) {
                        Button(action: { showingSettings = true }) {
                            HStack {
                                Image(systemName: "gearshape.fill")
                                Text("Settings")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.05), radius: 5)
                        }
                        .foregroundColor(.primary)
                        
                        Button(action: { authManager.signOut() }) {
                            HStack {
                                Image(systemName: "arrow.right.square")
                                Text("Sign Out")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .foregroundColor(.red)
                            .cornerRadius(15)
                        }
                    }
                }
                .padding()
            }
            .background(Color(hex: "#F5F7FA"))
            .navigationTitle("Profile")
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
        }
    }
}

// MARK: - Supporting Views and Models
private struct StatView: View {
    let value: String
    let title: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            // Icon with lighter background
            ZStack {
                Circle()
                    .fill(.white.opacity(0.3))
                    .frame(width: 44, height: 44)
                
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
            }
            
            Text(value)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
        }
        .frame(maxWidth: .infinity)
    }
} 