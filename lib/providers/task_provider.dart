import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task newTask) {
    _tasks.add(newTask);
    notifyListeners();
  }

  void toggleTaskCompletion(String taskId) {
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex >= 0) {
      _tasks[taskIndex].isCompleted = !_tasks[taskIndex].isCompleted;
      notifyListeners();
    }
  }

  void removeTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  void updateTask(Task updatedTask) {
    final taskIndex = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (taskIndex >= 0) {
      _tasks[taskIndex] = updatedTask;
      notifyListeners();
    }
  }

  void resetAll() {
    _tasks.clear();
    notifyListeners();
  }
}
