import 'dart:convert';
import 'package:pocket_tasks/models/tasks.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _tasksKey = 'tasks';

  Future<List<Task>> loadTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tasksJson = prefs.getString(_tasksKey);

      if (tasksJson == null) return [];

      final List<dynamic> tasksList = json.decode(tasksJson);
      return tasksList.map((taskJson) => Task.fromJson(taskJson)).toList();
    } catch (e) {
      throw Exception('Failed to load tasks: $e');
    }
  }

  Future<void> saveTasks(List<Task> tasks) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tasksJson = json.encode(
        tasks.map((task) => task.toJson()).toList(),
      );
      await prefs.setString(_tasksKey, tasksJson);
    } catch (e) {
      throw Exception('Failed to save tasks: $e');
    }
  }

  Future<void> clearAllTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tasksKey);
    } catch (e) {
      throw Exception('Failed to clear tasks: $e');
    }
  }
}
