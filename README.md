# SmartRepAI: AI-Powered Sales Training (Flutter App)

# Project Description
This project is the official cross-platform mobile application for SmartRepAI, built with Flutter. It provides a native mobile experience for the AI-powered training platform, designed to be an indispensable tool for pharmaceutical sales representatives. The app connects to the existing Python/Flask backend, delivering all the core features of the SmartRepAI ecosystem directly to iOS and Android devices from a single codebase.

# Features
- Native Mobile Experience: A responsive and smooth UI built with Flutter for both iOS and Android.
- Secure User Authentication: Full sign-up, login, and session management powered by Supabase, ensuring user data is secure.
- AI-Powered Knowledge Base (RAG): Users can upload PDF documents (e.g., clinical studies) to create a personalized knowledge base and ask questions to get answers sourced directly from their materials.
- Automated Role-Play Coaching: Engage in role-play conversations with the AI and receive instant, AI-driven feedback that is saved to the user's profile for review.
- Voice-to-Text Input: Utilizes the device's native speech recognition for hands-free, natural interaction within chat interfaces.

# How to Run the App
- Prerequisites
> You must have the Flutter SDK installed.
> You need an IDE like VS Code with the Flutter extension or Android Studio.
> The SmartRepAI Python Backend must be running locally for the app to connect to it.

1. Clone the Repository:
```bash
git clone [Your Flutter App Repository URL Here]
cd smartrep-ai-flutter-app
```bash

3. Install Dependencies
- From the root of the project, run the following command to fetch all the necessary Dart packages:
```bash
flutter pub get
```bash

3. Configure Environment Variables
- In the lib/ directory of the project, create a new file named .env.
- Add your public Supabase keys to this file. This allows the app to connect to the authentication service.
```bash
SUPABASE_URL=YOUR_SUPABASE_PROJECT_URL
SUPABASE_ANON_KEY=YOUR_SUPABASE_ANON_KEY
```bash

- Ensure you have a flutter_dotenv package in your pubspec.yaml and have loaded it in your main.dart file.

4. Run the App
- Make sure your Python backend server is running.
- Open the project in your IDE and select a target device (e.g., an iOS Simulator, Android Emulator, or a connected physical device).
- Run the app from your IDE or use the command line:
```bash
flutter run
```bash

# Technologies Used
- `Mobile Framework`: Flutter 3.x
- `Language`: Dart 3.x
- `State Management`: Provider / BLoC (Specify which you are using)
- `Backend Communication`: http package for API calls

# Authentication & Database: Supabase
- AI Integration: Connects to the Python/Flask backend which utilizes the Google Gemini API.
