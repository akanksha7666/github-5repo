# ✅ Complete Guide to Set Up a Flutter Web Project

### Since your system does not have any software installed, follow these steps to transfer your Flutter Web project and get it running


## 🔹 Step 1: Install Required Software
#### Your new laptop needs Flutter, Dart, and other dependencies.

### 1️⃣ Install Flutter
#### Download Flutter from the official site:https://docs.flutter.dev/release/archive

#### 1.Extract the Flutter SDK to a folder (e.g., C:\flutter on Windows or ~/flutter on macOS/Linux).
####    2.Add Flutter to Environment Variables:
      > Windows: Add C:\flutter\bin to the PATH.
      > Mac/Linux: Add this to ~/.bashrc or ~/.zshrc:
        export PATH="$PATH:`pwd`/flutter/bin"
####    3.Verify the installation:
        flutter --version

### 2️⃣ Install VS Code or Android Studio
####    You need an IDE to write and run Flutter code.
#####    VS Code: Download(https://code.visualstudio.com/)
#####    Android Studio: Download(https://developer.android.com/studio)
#####    👉 For VS Code, install the Flutter & Dart extensions from the Extensions Marketplace.

## 🔹 Step 2: Set Up the Flutter Project
####    Once your project is transferred, follow these steps.

### 1️⃣ Open the Project in VS Code / Android Studio
    VS Code: Open the folder.
    Android Studio: Click "Open" and select the project.
### 2️⃣ Install Flutter Dependencies
    Inside your project folder, run:flutter pub get
    This downloads all required packages.
### 3️⃣ Check Web Support
    Enable web support:flutter config --enable-web
    Check available devices:flutter devices

## 🔹 Step 3: Run the Project Locally
####    Test your Flutter Web app before building:
    flutter run -d chrome
####    If everything works fine, you’re ready to build.

## 🔹 Step 4: Build the Flutter Web Project
####    Once your project is running, build it:
    flutter build web
###    This generates final web files in:
    /your_flutter_project/build/web/
###  ✅ These files are ready for deployment.
