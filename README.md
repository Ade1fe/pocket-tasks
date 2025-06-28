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

## ✨ Key Features

Pocket Tasks offers a streamlined experience with the following capabilities:

* **Task Management:** Easily add, edit, and delete tasks.
* **Completion Status:** Mark tasks as complete or incomplete.
* **Filtering & Sorting:** Filter tasks by status (All, Active, Completed) and sort them by due date or creation date.
* **Theme Support:** Switch between beautiful Light and Dark themes.
* **Task Insights:** View basic task statistics and progress tracking.
* **Due Dates:** Assign due dates with clear overdue indicators.

## 💡 State Management

This application utilizes **Provider** for state management. Provider was chosen for its simplicity, efficiency in rebuilding only necessary widgets, and its strong integration with the Flutter framework, ensuring a reactive and high-performing UI.

## 🏗️ Architecture Overview

The project follows a clean, layered architecture to ensure maintainability, scalability, and testability:

* **UI Layer (Widgets)**: Responsible for presenting information and handling user interactions.
* **Provider Layer**: Manages the application's state and encapsulates core business logic, acting as the bridge between the UI and data services.
* **Service Layer**: Handles external interactions and abstracts data operations.
* **Data Persistence**: Task data is handled locally using **SharedPreferences**. This was chosen for its simplicity and reliability, making it ideal for storing the application's data directly on the device.

This clear separation of concerns ensures a robust and organized application structure.

## 🧪 Testing

The application includes comprehensive tests to ensure reliability and functionality:

* **Unit Tests:** Covering core logic in models, providers, and services.
* **Widget Tests:** Validating UI components and their interactions.

To run the tests:
```bash
flutter test
```
## 🚀 Future Enhancements

Potential future developments for Pocket Tasks include:

* Task categories and tags
* Reminders and notifications
* Cloud synchronization for multi-device access
* Advanced filtering and search options

## 🤝 Contributing

Contributions are highly welcome! Please feel free to fork the repository, make your changes, and submit pull requests. Ensure your code adheres to the project's style and all tests pass.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Developer

Built with ❤️ by Oluwadamisi Damilola
