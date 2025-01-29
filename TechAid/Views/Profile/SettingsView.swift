import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false
    @AppStorage("soundEnabled") private var soundEnabled = true
    
    var body: some View {
        NavigationView {
            List {
                Section("Account") {
                    NavigationLink("Personal Information") {
                        Text("Personal Information")
                    }
                    NavigationLink("Privacy") {
                        Text("Privacy Settings")
                    }
                }
                
                Section("Preferences") {
                    Toggle("Notifications", isOn: $notificationsEnabled)
                    Toggle("Dark Mode", isOn: $darkModeEnabled)
                    Toggle("Sound Effects", isOn: $soundEnabled)
                }
                
                Section("App") {
                    NavigationLink("About") {
                        Text("About")
                    }
                    NavigationLink("Help") {
                        Text("Help")
                    }
                    NavigationLink("Terms of Service") {
                        Text("Terms of Service")
                    }
                    NavigationLink("Privacy Policy") {
                        Text("Privacy Policy")
                    }
                }
                
                Section("Cache") {
                    Button("Clear Cache") {
                        // Implement cache clearing
                    }
                }
                
                Section {
                    Text("Version 1.0.0")
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
} 