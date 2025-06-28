import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_tasks/models/tasks.dart';

void main() {
  group('Task Model', () {
    test('creates task with defaults', () {
      final task = Task(title: 'Test Task');

      expect(task.title, 'Test Task');
      expect(task.note, '');
      expect(task.isCompleted, false);
      expect(task.id, isNotEmpty);
      expect(task.createdAt, isA<DateTime>());
      expect(task.updatedAt, isA<DateTime>());
    });

    test('creates task with full data', () {
      final task = Task(
        title: 'Write test',
        note: 'Unit testing task model',
        dueDate: DateTime(2025),
        isCompleted: true,
      );

      expect(task.title, 'Write test');
      expect(task.note, 'Unit testing task model');
      expect(task.isCompleted, true);
    });

    test('copyWith updates fields', () {
      final task = Task(title: 'Old Title');
      final updated = task.copyWith(title: 'New Title', isCompleted: true);

      expect(updated.title, 'New Title');
      expect(updated.isCompleted, true);
      expect(updated.id, task.id);
    });

    test('serializes and deserializes correctly', () {
      final task = Task(title: 'Save Me', note: 'Test save');
      final json = task.toJson();
      final fromJson = Task.fromJson(json);

      expect(fromJson.title, task.title);
      expect(fromJson.note, task.note);
      expect(fromJson.id, task.id);
    });
  });
}
