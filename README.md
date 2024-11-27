# TechAid


#Project Structure

TechAid/
├── frontend/       # React Native app code
│   ├── src/
│   │   ├── components/  # Reusable UI components
│   │   ├── screens/     # App screens (Home, Chatbot, Tutorials)
│   │   └── assets/      # Images, icons, and other static resources
│   └── App.js           # Main app entry point
├── backend/        # Backend server
│   ├── routes/         # API endpoints
│   ├── models/         # Data models
│   └── server.js       # Backend server configuration
└── README.md       # Project documentation

TechAid

TechAid is a mobile application designed to provide seamless technical support for elderly users. With features such as a chatbot, speech-to-text functionality, and cloud-hosted tutorials, TechAid aims to bridge the digital divide and empower users to navigate modern technology confidently.

Features

Chatbot Assistance: AI-powered chatbot for instant tech help.
Speech-to-Text: Enables hands-free interaction.
Tutorials: Step-by-step video guides for common tech challenges.
Cloud Storage: Secure and accessible file hosting for resources.
Tech Stack

Frontend
React Native
Framework for cross-platform mobile app development (iOS and Android).
Backend
Node.js
Server-side environment for handling API requests.
Cloud Services
Firebase Storage (or other cloud storage like Azure or GCS)
For hosting tutorial files and other app resources.
Getting Started

Prerequisites
Node.js: Download and install Node.js.
React Native CLI: Install the React Native CLI:
npm install -g react-native-cli
Backend Tools: Ensure Express.js is installed for backend development:
npm install express body-parser
Firebase Configuration: Set up a Firebase project and retrieve the configuration file.
Installation
Clone the repository:
git clone https://github.com/username/techaid.git
cd techaid
Install dependencies for the frontend:
npm install
Start the React Native app:
npx react-native start
Install backend dependencies:
cd backend
npm install
Start the backend server:
node server.js

Fork the repository.
Create a feature branch:
git checkout -b feature-name
Commit your changes:
git commit -m "Add feature name"
Push your branch:
git push origin feature-name
Open a pull request.

#License

This project is licensed under the MIT License.

#Contact

For any questions or suggestions, feel free to contact the project team:

Era Aliu (Team Lead): eraaliu@techsupport.com
