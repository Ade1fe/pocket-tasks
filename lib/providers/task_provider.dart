import 'package:flutter/foundation.dart';
import 'package:pocket_tasks/models/tasks.dart';
// import '../models/task.dart';
import '../services/storage_service.dart';

enum TaskFilter { all, active, completed }

enum TaskSort { dueDate, createdDate }

class TaskProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  List<Task> _tasks = [];
  TaskFilter _currentFilter = TaskFilter.all;
  TaskSort _currentSort = TaskSort.createdDate;
  bool _isLoading = false;

  List<Task> get tasks => _getFilteredAndSortedTasks();
  List<Task> get allTasks => _tasks;
  TaskFilter get currentFilter => _currentFilter;
  TaskSort get currentSort => _currentSort;
  bool get isLoading => _isLoading;

  int get totalTasks => _tasks.length;
  int get completedTasks => _tasks.where((task) => task.isCompleted).length;
  int get activeTasks => _tasks.where((task) => !task.isCompleted).length;

  TaskProvider() {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    _isLoading = true;
    notifyListeners();

    try {
      _tasks = await _storageService.loadTasks();
    } catch (e) {
      debugPrint('Error loading tasks: $e');
      _tasks = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTask(Task task) async {
    _tasks.add(task);
    await _saveTasks();
    notifyListeners();
  }

  Future<void> updateTask(Task updatedTask) async {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      await _saveTasks();
      notifyListeners();
    }
  }

  Future<void> deleteTask(String taskId) async {
    _tasks.removeWhere((task) => task.id == taskId);
    await _saveTasks();
    notifyListeners();
  }

  Future<void> toggleTaskCompletion(String taskId) async {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(
        isCompleted: !_tasks[index].isCompleted,
      );
      await _saveTasks();
      notifyListeners();
    }
  }

  void setFilter(TaskFilter filter) {
    _currentFilter = filter;
    notifyListeners();
  }

  void setSort(TaskSort sort) {
    _currentSort = sort;
    notifyListeners();
  }

  Future<void> _saveTasks() async {
    try {
      await _storageService.saveTasks(_tasks);
    } catch (e) {
      debugPrint('Error saving tasks: $e');
    }
  }

  List<Task> _getFilteredAndSortedTasks() {
    List<Task> filteredTasks = _tasks;

    // Apply filter
    switch (_currentFilter) {
      case TaskFilter.active:
        filteredTasks = _tasks.where((task) => !task.isCompleted).toList();
        break;
      case TaskFilter.completed:
        filteredTasks = _tasks.where((task) => task.isCompleted).toList();
        break;
      case TaskFilter.all:
        filteredTasks = _tasks;
        break;
    }

    // Apply sort
    switch (_currentSort) {
      case TaskSort.dueDate:
        filteredTasks.sort((a, b) {
          if (a.dueDate == null && b.dueDate == null) return 0;
          if (a.dueDate == null) return 1;
          if (b.dueDate == null) return -1;
          return a.dueDate!.compareTo(b.dueDate!);
        });
        break;
      case TaskSort.createdDate:
        filteredTasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
    }

    return filteredTasks;
  }

  Task? getTaskById(String id) {
    try {
      return _tasks.firstWhere((task) => task.id == id);
    } catch (e) {
      return null;
    }
  }
}
