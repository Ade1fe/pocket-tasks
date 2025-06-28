# Pocket Tasks

A simple, efficient, and beautifully designed Flutter task management application to help you organize your daily to-dos with ease.

https://github.com/user-attachments/assets/be03c4bb-b359-4b75-81a3-aac86d2ffa45

## 🚀 Getting Started

To get Pocket Tasks up and running on your local machine:

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/Ade1fe/pocket-tasks.git](https://github.com/Ade1fe/pocket-tasks.git)
    cd pocket-tasks
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the app:**
    ```bash
    flutter run
    ```
    (For building a release APK, use `flutter build apk --release`. The output will be in `build/app/outputs/flutter-apk/`)

## ✨ State Management

This application utilizes **Provider** for state management. Provider was chosen for its simplicity, efficiency in rebuilding only necessary widgets, and its strong integration with the Flutter framework.

## 🏗️ Architecture Summary

The project follows a clean, layered architecture to ensure maintainability and testability:

-   **UI Layer (Widgets)**: Handles user interaction and displays data.
-   **Provider Layer**: Manages application state and business logic using the Provider package.
-   **Service Layer**: Encapsulates external interactions, such as data persistence.
-   **Data Persistence**: Task data is handled locally using **SharedPreferences**. This was chosen for its simplicity and reliability, making it ideal for storing the application's data.

This separation ensures a clear flow of data and concerns throughout the application.

## 🤝 Contributing

Contributions are welcome! Please feel free to fork the repository and submit pull requests.

## 📄 License

This project is licensed under the MIT License.

## 👨‍💻 Developer

Built with ❤️ by Oluwadamisi Damilola
