import 'package:flutter_test/flutter_test.dart';
// import 'package:pocket_tasks/models/task.dart';
import 'package:pocket_tasks/models/tasks.dart';

void main() {
  group('Task Model Tests', () {
    test('should create a task with required fields', () {
      final task = Task(title: 'Test Task');

      expect(task.title, 'Test Task');
      expect(task.note, '');
      expect(task.isCompleted, false);
      expect(task.id, isNotEmpty);
      expect(task.createdAt, isA<DateTime>());
      expect(task.updatedAt, isA<DateTime>());
    });

    test('should create a task with all fields', () {
      final dueDate = DateTime.now().add(const Duration(days: 1));
      final task = Task(
        title: 'Complete Task',
        note: 'This is a test note',
        dueDate: dueDate,
        isCompleted: true,
      );

      expect(task.title, 'Complete Task');
      expect(task.note, 'This is a test note');
      expect(task.dueDate, dueDate);
      expect(task.isCompleted, true);
    });

    test('should copy task with updated fields', () {
      final originalTask = Task(title: 'Original Task');
      final updatedTask = originalTask.copyWith(
        title: 'Updated Task',
        isCompleted: true,
      );

      expect(updatedTask.id, originalTask.id);
      expect(updatedTask.title, 'Updated Task');
      expect(updatedTask.isCompleted, true);
      expect(updatedTask.note, originalTask.note);
      expect(updatedTask.createdAt, originalTask.createdAt);
      expect(updatedTask.updatedAt, isNot(originalTask.updatedAt));
    });

    test('should serialize and deserialize task correctly', () {
      final dueDate = DateTime.now().add(const Duration(days: 1));
      final originalTask = Task(
        title: 'Serialization Test',
        note: 'Test note',
        dueDate: dueDate,
        isCompleted: true,
      );

      final json = originalTask.toJson();
      final deserializedTask = Task.fromJson(json);

      expect(deserializedTask.id, originalTask.id);
      expect(deserializedTask.title, originalTask.title);
      expect(deserializedTask.note, originalTask.note);
      expect(deserializedTask.dueDate, originalTask.dueDate);
      expect(deserializedTask.isCompleted, originalTask.isCompleted);
      expect(deserializedTask.createdAt, originalTask.createdAt);
      expect(deserializedTask.updatedAt, originalTask.updatedAt);
    });
  });
}
