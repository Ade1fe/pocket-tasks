import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_tasks/models/tasks.dart';
import 'package:pocket_tasks/providers/task_provider.dart';

void main() {
  group('TaskProvider', () {
    late TaskProvider provider;

    setUp(() {
      provider = TaskProvider();
    });

    test('starts with empty list', () {
      expect(provider.allTasks, isEmpty);
      expect(provider.totalTasks, 0);
    });

    test('adds a task', () async {
      final task = Task(title: 'New Task');
      await provider.addTask(task);

      expect(provider.totalTasks, 1);
      expect(provider.activeTasks, 1);
      expect(provider.allTasks.first.title, 'New Task');
    });

    test('updates a task', () async {
      final task = Task(title: 'Original');
      await provider.addTask(task);

      final updated = task.copyWith(title: 'Updated', isCompleted: true);
      await provider.updateTask(updated);

      expect(provider.completedTasks, 1);
      expect(provider.allTasks.first.title, 'Updated');
    });

    test('deletes a task', () async {
      final task = Task(title: 'Delete Me');
      await provider.addTask(task);

      await provider.deleteTask(task.id);
      expect(provider.totalTasks, 0);
    });

    test('toggles completion', () async {
      final task = Task(title: 'Toggle');
      await provider.addTask(task);

      await provider.toggleTaskCompletion(task.id);
      expect(provider.completedTasks, 1);
      expect(provider.activeTasks, 0);
    });

    test('filters tasks', () async {
      final active = Task(title: 'Active');
      final done = Task(title: 'Done', isCompleted: true);

      await provider.addTask(active);
      await provider.addTask(done);

      provider.setFilter(TaskFilter.all);
      expect(provider.tasks.length, 2);

      provider.setFilter(TaskFilter.active);
      expect(provider.tasks.length, 1);
      expect(provider.tasks.first.title, 'Active');

      provider.setFilter(TaskFilter.completed);
      expect(provider.tasks.length, 1);
      expect(provider.tasks.first.title, 'Done');
    });
  });
}
