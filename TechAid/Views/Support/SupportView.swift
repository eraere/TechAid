import SwiftUI

struct SupportView: View {
    @State private var searchText = ""
    @State private var showingAIChat = false
    @State private var selectedCategory: HelpCategory?
    
    let helpCategories = [
        HelpCategory(
            title: "Technical",
            icon: "gearshape.fill",
            color: "#4A90E2",
            topics: ["Device Setup", "App Navigation", "Features Guide", "Troubleshooting"]
        ),
        HelpCategory(
            title: "Account",
            icon: "person.fill",
            color: "#2ECC71",
            topics: ["Profile Settings", "Privacy", "Data Management", "Preferences"]
        ),
        HelpCategory(
            title: "Learning",
            icon: "book.fill",
            color: "#9B51E0",
            topics: ["Course Access", "Progress Tracking", "Certificates", "Study Tips"]
        ),
        HelpCategory(
            title: "Billing",
            icon: "creditcard.fill",
            color: "#FF6B6B",
            topics: ["Subscription", "Payment Methods", "Invoices", "Refunds"]
        ),
        HelpCategory(
            title: "Accessibility",
            icon: "accessibility",
            color: "#FF9500",
            topics: ["Screen Reader", "Text Size", "Color Settings", "Voice Control"]
        ),
        HelpCategory(
            title: "Other",
            icon: "questionmark.circle.fill",
            color: "#4CD964",
            topics: ["FAQ", "Contact Support", "Feedback", "Bug Report"]
        )
    ]
    
    let quickGuides = [
        GuideItem(
            title: "Getting Started Guide",
            description: "Learn the basics of using TechAid+",
            icon: "book.fill",
            content: [
                GuideSection(
                    title: "Welcome to TechAid+",
                    text: "Your journey to mastering technology starts here",
                    steps: ["Create your profile", "Set your preferences", "Choose your first course"]
                ),
                GuideSection(
                    title: "Navigation Basics",
                    text: "Learn how to move around the app",
                    steps: ["Using the bottom menu", "Accessing your courses", "Finding help"]
                )
            ]
        ),
        GuideItem(
            title: "Device Settings",
            description: "Customize your learning experience",
            icon: "gearshape.2.fill",
            content: [
                GuideSection(
                    title: "Personalizing Your Experience",
                    text: "Make TechAid+ work for you",
                    steps: ["Adjust text size", "Set color preferences", "Configure notifications"]
                )
            ]
        ),
        GuideItem(
            title: "Accessibility Features",
            description: "Make TechAid+ work better for you",
            icon: "accessibility",
            content: [
                GuideSection(
                    title: "Accessibility Options",
                    text: "Making TechAid+ accessible for everyone",
                    steps: ["Voice control setup", "Screen reader options", "Display adjustments"]
                )
            ]
        )
    ]
    
    var filteredGuides: [GuideItem] {
        if searchText.isEmpty {
            return quickGuides
        }
        return quickGuides.filter { guide in
            guide.title.localizedCaseInsensitiveContains(searchText) ||
            guide.description.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search help topics...", text: $searchText)
                            .font(.title3)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                    
                    // AI Assistant Card with enhanced UI
                    PremiumCard(
                        gradient: [Color(hex: "#4A90E2"), Color(hex: "#6B48FF")]
                    ) {
                        VStack(spacing: 16) {
                            HStack {
                                Image(systemName: "brain.head.profile")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                Text("AI Support Assistant")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            
                            Text("Get instant help with your questions")
                                .foregroundColor(.white.opacity(0.9))
                            
                            Button(action: { showingAIChat = true }) {
                                HStack {
                                    Image(systemName: "message.fill")
                                    Text("Start AI Chat")
                                        .fontWeight(.semibold)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.white)
                                .foregroundColor(Color(hex: "#4A90E2"))
                                .cornerRadius(12)
                            }
                        }
                        .padding()
                    }
                    
                    // Help Categories Grid
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Help Categories")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            ForEach(helpCategories) { category in
                                HelpCategoryCard(category: category)
                                    .onTapGesture {
                                        selectedCategory = category
                                    }
                            }
                        }
                    }
                    
                    // Quick Help Guides
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Quick Help Guides")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        ForEach(filteredGuides) { guide in
                            GuideCard(guide: guide)
                        }
                    }
                }
                .padding()
            }
            .background(Color(hex: "#F5F7FA"))
            .navigationTitle("Support")
            .sheet(isPresented: $showingAIChat) {
                EnhancedAIChatView()
            }
            .sheet(item: $selectedCategory) { category in
                CategoryDetailView(category: category)
            }
        }
    }
}

// MARK: - Supporting Views and Models
struct HelpCategory: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let color: String
    let topics: [String]
}

struct GuideItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let icon: String
    let content: [GuideSection]
}

struct GuideSection: Identifiable {
    let id = UUID()
    let title: String
    let text: String
    let steps: [String]
}

struct HelpCategoryCard: View {
    let category: HelpCategory
    
    var body: some View {
        Button(action: {}) {
            VStack(spacing: 12) {
                Image(systemName: category.icon)
                    .font(.system(size: 30))
                    .foregroundColor(Color(hex: category.color))
                
                Text(category.title)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
    }
}

struct GuideCard: View {
    let guide: GuideItem
    
    var body: some View {
        NavigationLink(destination: GuideDetailView(guide: guide)) {
            HStack(spacing: 16) {
                Image(systemName: guide.icon)
                    .font(.system(size: 24))
                    .foregroundColor(.blue)
                    .frame(width: 40)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(guide.title)
                        .font(.headline)
                    Text(guide.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
    }
}

struct EnhancedAIChatView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var messageText = ""
    @State private var messages: [ChatMessage] = []
    @State private var isTyping = false
    @State private var showSuggestions = true
    
    let suggestedQuestions = [
        "How do I start a new course?",
        "Where can I find my progress?",
        "How do I change my settings?",
        "Can I download content offline?"
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Chat messages
                ScrollView {
                    LazyVStack(spacing: 16) {
                        if showSuggestions && messages.isEmpty {
                            // Welcome message
                            VStack(alignment: .leading, spacing: 16) {
                                ChatBubble(message: ChatMessage(
                                    text: "Hello! I'm your AI assistant. How can I help you today?",
                                    isUser: false
                                ))
                                
                                // Suggested questions
                                Text("Suggested Questions")
                                    .font(.headline)
                                    .padding(.horizontal)
                                
                                ForEach(suggestedQuestions, id: \.self) { question in
                                    Button(action: { sendMessage(question) }) {
                                        Text(question)
                                            .font(.subheadline)
                                            .foregroundColor(.primary)
                                            .padding()
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .background(Color.gray.opacity(0.1))
                                            .cornerRadius(10)
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.top)
                        }
                        
                        ForEach(messages) { message in
                            ChatBubble(message: message)
                                .padding(.horizontal)
                        }
                        
                        if isTyping {
                            HStack {
                                ChatBubble(message: ChatMessage(
                                    text: "Typing...",
                                    isUser: false
                                ))
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
                
                Divider()
                
                // Message input
                VStack(spacing: 12) {
                    HStack(spacing: 12) {
                        // Message field
                        HStack {
                            TextField("Type your message...", text: $messageText)
                                .textFieldStyle(.plain)
                            
                            if !messageText.isEmpty {
                                Button(action: { messageText = "" }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(25)
                        
                        // Send button
                        Button(action: { sendMessage(messageText) }) {
                            Image(systemName: "arrow.up.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.blue)
                        }
                        .disabled(messageText.isEmpty)
                    }
                    
                    // Quick actions
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            QuickActionButton(title: "Help", icon: "questionmark.circle")
                            QuickActionButton(title: "Settings", icon: "gear")
                            QuickActionButton(title: "Feedback", icon: "star")
                            QuickActionButton(title: "Contact", icon: "envelope")
                        }
                        .padding(.horizontal)
                    }
                }
                .padding()
                .background(Color.white)
            }
            .background(Color(hex: "#F5F7FA"))
            .navigationTitle("AI Assistant")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
    
    private func sendMessage(_ text: String) {
        guard !text.isEmpty else { return }
        showSuggestions = false
        let userMessage = ChatMessage(text: text, isUser: true)
        messages.append(userMessage)
        messageText = ""
        
        // Simulate AI typing
        isTyping = true
        
        // Simulate AI response
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isTyping = false
            let aiResponse = ChatMessage(
                text: generateResponse(for: text),
                isUser: false
            )
            messages.append(aiResponse)
        }
    }
    
    private func generateResponse(for question: String) -> String {
        // Simulate different responses based on the question
        if question.lowercased().contains("course") {
            return "To start a new course, go to the Learning tab and browse our available courses. You can filter by category or difficulty level. Once you find a course you're interested in, tap on it to see more details and click 'Start Learning'."
        } else if question.lowercased().contains("progress") {
            return "You can track your progress in the Profile tab. There you'll find detailed statistics about your completed courses, learning hours, and achievements."
        } else if question.lowercased().contains("settings") {
            return "To access settings, tap on your profile icon and look for the gear icon in the top right corner. There you can adjust your preferences, notifications, and accessibility options."
        } else {
            return "I understand you're asking about \(question). Let me help you with that. Could you please provide more specific details about what you'd like to know?"
        }
    }
}

struct QuickActionButton: View {
    let title: String
    let icon: String
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: icon)
                Text(title)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.blue.opacity(0.1))
            .foregroundColor(.blue)
            .cornerRadius(20)
        }
    }
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

struct ChatBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUser { Spacer() }
            
            Text(message.text)
                .padding()
                .background(message.isUser ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(message.isUser ? .white : .primary)
                .cornerRadius(15)
                .frame(maxWidth: 280, alignment: message.isUser ? .trailing : .leading)
            
            if !message.isUser { Spacer() }
        }
    }
}

struct GuideDetailView: View {
    let guide: GuideItem
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Guide content would go here
                Text("Guide content coming soon...")
            }
            .padding()
        }
        .navigationTitle(guide.title)
    }
}

struct CategoryDetailView: View {
    let category: HelpCategory
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Category content would go here
                Text("Category content coming soon...")
            }
            .padding()
        }
        .navigationTitle(category.title)
    }
}

#Preview {
    SupportView()
} 

