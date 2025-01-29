import SwiftUI

struct AchievementsView: View {
    let categories = ["All", "Course", "Social", "Special"]
    @State private var selectedCategory = "All"
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // Categories
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(categories, id: \.self) { category in
                            AchievementCategoryPill(
                                title: category,
                                isSelected: category == selectedCategory,
                                action: { selectedCategory = category }
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Achievements Grid
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    ForEach(Models.LearningAchievement.samples) { achievement in
                        EnhancedAchievementView(achievement: achievement)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Achievements")
        .background(Color(hex: "#F5F7FA"))
    }
}

struct AchievementCategoryPill: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.1))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
    }
}

#Preview {
    NavigationView {
        AchievementsView()
    }
} 