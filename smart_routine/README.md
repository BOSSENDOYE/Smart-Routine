# Smart Routine

## Overview
Smart Routine is a task management application built with Flutter. It allows users to add tasks, mark them as completed, and view daily statistics related to their tasks.

## Features
- Add new tasks with a title, description, and date.
- Mark tasks as completed.
- View a list of all tasks.
- Display daily statistics, including the number of completed tasks.

## Project Structure
```
smart_routine
├── lib
│   ├── main.dart                # Entry point of the application
│   ├── models
│   │   └── task.dart            # Task model definition
│   ├── screens
│   │   ├── home_screen.dart     # Home screen displaying tasks
│   │   ├── add_task_screen.dart  # Screen for adding new tasks
│   │   └── statistics_screen.dart # Screen for viewing statistics
│   ├── widgets
│   │   ├── task_list.dart        # Widget for displaying a list of tasks
│   │   └── task_item.dart        # Widget for displaying a single task
│   └── utils
│       └── constants.dart        # Constants used throughout the app
├── test
│   └── widget_test.dart          # Widget tests for the application
├── pubspec.yaml                  # Flutter project configuration
└── README.md                     # Project documentation
```

## Installation
1. Clone the repository:
   ```
   git clone <repository-url>
   ```
2. Navigate to the project directory:
   ```
   cd smart_routine
   ```
3. Install the dependencies:
   ```
   flutter pub get
   ```

## Usage
1. Run the application:
   ```
   flutter run
   ```
2. Use the Home Screen to view tasks and navigate to add new tasks or view statistics.

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any enhancements or bug fixes.