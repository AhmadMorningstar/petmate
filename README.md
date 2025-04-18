# PetMate

A new pet shop app with an integrated admin panel using PostgreSQL for authentication.

## Overview

This app is designed for pet shop management. It allows admins to log in using PostgreSQL-based authentication, manage purchases, and create new admin users. On app install, the default admin credentials (username: `Admin`, password: `Ahmad`) are added. Admins can create new users from the app and manage notifications related to purchases.

## Features

- Admin login using PostgreSQL (with default credentials: `Admin`, `Ahmad`).
- Admins can create new user accounts from the app's interface.
- Persistent admin session after login.
- A logout button to end the session.
- A cancel button in the Admin page to navigate back to the homepage.
- Default admin credentials reset if the app is reinstalled.

## Getting Started

### Prerequisites

- Ensure you have Flutter installed: [Flutter Installation](https://flutter.dev/docs/get-started/install)
- PostgreSQL database (`sqflite` package) for storing admin user credentials.

- ### The Version i used to make this
Android Studio Ladybug Feature Drop | 2024.2.2 Patch 1
Build #AI-242.23726.103.2422.13016713, built on February 5, 2025
Runtime version: 21.0.5+-12932927-b750.29 amd64
VM: OpenJDK 64-Bit Server VM by JetBrains s.r.o.
Toolkit: sun.awt.windows.WToolkit
Windows 11.0
GC: G1 Young Generation, G1 Concurrent GC, G1 Old Generation
Memory: 2048M
Cores: 12
Registry:
  ide.experimental.ui=true
  i18n.locale=
Non-Bundled Plugins:
  Dart (242.24931)
  io.flutter (83.0.3)

```bash
flutter --version
```
Flutter 3.29.0 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 35c388afb5 (9 weeks ago) • 2025-02-10 12:48:41 -0800
Engine • revision f73bfc4522
Tools • Dart 3.7.0 • DevTools 2.42.2

### Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/AhmadMorningstar/petmate.git
    ```
2. Navigate to the project directory:
    ```bash
    cd petmate
    ```
3. Install the required dependencies:
    ```bash
    flutter pub get
    ```

4. Run the app on your preferred device/emulator:
    ```bash
    flutter run
    ```
    
5. Build the app with .apk extension for your preferred device/emulator:
    ```bash
    flutter build apk --debug
    ```

### Usage

Upon running the app, you will be greeted with the login screen. If you have not set up any admins, the default credentials are:
- **Username:** Ahmad
- **Password:** Ahmad

Once logged in as an admin, you can:
- View notifications related to purchases.
- Create new admin users.
- Log out or navigate back to the homepage using the bottom navigation bar.

### Database

- **PostgreSQL:** The app uses the `sqflite` package to store admin user data locally.
- On app installation, the default admin (`Ahmad` / `Ahmad`) is added to the database.
- Admins can add additional admin users from the app.

### Demo

You can quickly test the app with the default admin credentials:
- **Username:** Ahmad
- **Password:** Ahmad

To add more admins, use the "Create New Admin" button on the Admin page.

## Contact

Feel free to contact me if you have any problems, or if you'd like to contribute to the project!

Your Sincerely,  
Ahmad Morningstar
