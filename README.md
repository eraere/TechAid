# TechAid

TechAid is an iOS application built with SwiftUI that provides an interactive learning experience. With integrated Firebase for user authentication and Firestore for course management, TechAid allows users to sign in, access engaging course content, and track their progress.

## Features

- **User Authentication:**  
  Secure sign in and registration using Firebase Authentication.

- **Course Management:**  
  Fetch and display courses from Firestore, with dynamic content and progress tracking.

- **Interactive Learning Interface:**  
  Enjoy a modern, SwiftUI-based interface with smooth transitions and reusable components.

- **Configuration & Persistence:**  
  Leverages SwiftData and custom managers for handling content and user data.

## Project Structure

## Requirements

- **Xcode:** 14 or later  
- **iOS:** 16.0 or later  
- **Swift:** 5.x  
- **Firebase:** Integrated via Swift Package Manager  
- **GoogleService-Info.plist:** A valid configuration file (downloaded from the [Firebase Console](https://console.firebase.google.com/)) is required.

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/eraere/TechAid.git
   cd TechAid
   ```

2. **Open the project in Xcode:**

   ```bash
   open TechAid.xcodeproj
   ```

3. **Add Firebase Configuration:**

   - Download `GoogleService-Info.plist` from the [Firebase Console](https://console.firebase.google.com/).
   - Drag and drop the file into your Xcode project (e.g., at the project root or in a dedicated folder).
   - Ensure it is added to your main target (verify in the File Inspector).

4. **Build and Run:**

   Select your simulator or device in Xcode and run the project.

## Usage

- **Authentication:**  
  Users sign in or register using Firebase. Once authenticated, users can view and interact with course content.

- **Course Interaction:**  
  Browse courses, view detailed lesson content, and track progress within the application.

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository.
2. Create a new branch for your feature or bug fix (e.g., `git checkout -b feature/your-feature`).
3. Commit your changes (`git commit -m "Description of changes"`).
4. Push to your branch (`git push origin feature/your-feature`).
5. Open a pull request describing your changes.

## License

This project is licensed under the [MIT License](LICENSE).

## Acknowledgements

- [Firebase](https://firebase.google.com/) for user authentication and data storage.
- SwiftUI and SwiftData for building dynamic and interactive user interfaces.
- The open-source community and all contributors.
