# PetMate

A new pet shop app with an integrated admin panel using SQLite for authentication.

## Overview

This app is designed for pet shop management. It allows admins to log in using SQLite-based authentication, manage purchases, and create new admin users. On app install, the default admin credentials (username: `Admin`, password: `1234`) are added. Admins can create new users from the app and manage notifications related to purchases.

## Features

- Admin login using SQLite (with default credentials: `Admin`, `1234`).
- Admins can create new user accounts from the app's interface.
- Persistent admin session after login.
- A logout button to end the session.
- A cancel button in the Admin page to navigate back to the homepage.
- Default admin credentials reset if the app is reinstalled.

## Getting Started

### Prerequisites

- Ensure you have Flutter installed: [Flutter Installation](https://flutter.dev/docs/get-started/install)
- SQLite database (`sqflite` package) for storing admin user credentials.

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
    flutter build apk
    ```

### Usage

Upon running the app, you will be greeted with the login screen. If you have not set up any admins, the default credentials are:
- **Username:** Admin
- **Password:** 1234

Once logged in as an admin, you can:
- View notifications related to purchases.
- Create new admin users.
- Log out or navigate back to the homepage using the bottom navigation bar.

### Database

- **SQLite:** The app uses the `sqflite` package to store admin user data locally.
- On app installation, the default admin (`Admin` / `1234`) is added to the database.
- Admins can add additional admin users from the app.

### Demo

You can quickly test the app with the default admin credentials:
- **Username:** Admin
- **Password:** 1234

To add more admins, use the "Create New Admin" button on the Admin page.

## Contact

Feel free to contact me if you have any problems, or if you'd like to contribute to the project!

Your Sincerely,  
Ahmad Morningstar
