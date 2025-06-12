# Taska 📝

**Taska** is a smart task management Flutter app that uses **Firebase Authentication** to handle user registration, login, and email verification.

> 🔧 This project is still in early development.  
> 📁 `google-services.json` is included in this repository for development and testing purposes.

---

# 🔍 Project Overview

Taska is being built as a clean and scalable task management app. Currently, it includes:

- ✅ **Login Page**
- ✅ **Register Page**
- ✅ **Email Verification Page**
- 🕐 **Home Page** (Coming soon)

The goal is to provide users with a simple yet secure experience while managing their daily tasks using Firebase as the backend.

---

# 🚀 Getting Started

## ✅ Requirements

Make sure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Android Studio or VS Code
- A connected Android device **or** an emulator
- Your machine is properly set up with:
  - Android SDK
  - Dart SDK
  - USB debugging enabled (if running on a physical device)

---

## ▶️ Run the App
## After installing Android Studio:
Go to plugins and install the Flutter plugin.

Click on more actions and go to the SDK Manager.
![1](https://github.com/user-attachments/assets/9b2e3757-2ed5-48f9-8b9e-7e65163236c3)

Make sure you have Android 15 (API level 35) marked on.
![2](https://github.com/user-attachments/assets/1832a808-09ab-435a-b549-c4e21c0a1a75)

Then go to the SDK tools tab and select all the tools in the picture, then mark Show package details.
![3](https://github.com/user-attachments/assets/40f0e253-ab1c-4e24-8f17-dfcf9ab71770)

Make sure you select NDK version 27.2.12479018, then hit apply. 
![4](https://github.com/user-attachments/assets/d8136a84-df2b-4cad-a879-b859e20df90e)

You can run the app using either:

#### 🔹 Option 1: Android Emulator
1. Open your Android Emulator from Android Studio or VS Code.
2. Run the project with:
   ```bash
   flutter pub get
   flutter run

#### 🔹 Option 2: Physical Device via USB Debugging
1. Enable USB Debugging on your Android phone.
2. You can connect your phone using a USB cable.
3. Make sure it appears with:
   ```bash
    flutter devices

4. Then run:
   ```bash
    flutter pub get
    flutter run

## 🔐 Important Notes
* The app runs with Java 17.
* This project contains the google-services.json file for development use.
 Do not reuse this configuration in production apps or other projects.
* The app uses Firebase Email & Password Authentication only for now.

## 📄 License
This project is licensed under the MIT License.

## ✨ Author
* Developed by Marwan Mahmoud
* GitHub: [marwan0-0n](https://github.com/marwan0-0n)
* LinkedIN: [Marwan Mahmoud](https://www.linkedin.com/in/marwann-mahmoud/)


