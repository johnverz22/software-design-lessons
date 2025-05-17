# Flutter App with Firebase Authentication

A Flutter application with Firebase Authentication for Google Sign-in.

## Setup Instructions

### 1. Firebase Setup

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Register your app with Firebase:
   - For Android:
     - Add an Android app in Firebase console with your app's package name
     - Download the `google-services.json` file and place it in the `android/app` directory
   - For iOS:
     - Add an iOS app in Firebase console with your app's bundle ID
     - Download the `GoogleService-Info.plist` file and place it in the `ios/Runner` directory
     - Add `GoogleService-Info.plist` to your Xcode project

### 2. Enable Google Sign-in

1. In Firebase Console, go to Authentication > Sign-in method
2. Enable Google as a sign-in provider
3. For Android:
   - Set up SHA-1 or SHA-256 fingerprints in Firebase console (Project settings > Your apps)
4. For iOS:
   - Update your app's URL schemes in `Info.plist`

### 3. Run the App

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run
```

## Features

- Firebase Authentication
- Google Sign-in
- Provider for state management
- User profile display
- Sign out functionality

## Project Structure

- `lib/models/` - Data models
- `lib/providers/` - State management with Provider
- `lib/services/` - Firebase authentication service
- `lib/pages/` - App screens
- `lib/widgets/` - Reusable components

## Dependencies

- firebase_core
- firebase_auth
- google_sign_in
- provider
