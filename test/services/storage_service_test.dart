import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_tasks/models/tasks.dart';
import 'package:pocket_tasks/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('StorageService', () {
    late StorageService storage;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      storage = StorageService();
    });

    test('saves and loads tasks', () async {
      final tasks = [
        Task(title: 'Task 1', note: 'Note 1'),
        Task(title: 'Task 2', isCompleted: true),
      ];

      await storage.saveTasks(tasks);
      final loaded = await storage.loadTasks();

      expect(loaded.length, 2);
      expect(loaded[0].title, 'Task 1');
      expect(loaded[0].note, 'Note 1');
      expect(loaded[1].isCompleted, true);
    });

    test('returns empty when no tasks exist', () async {
      final loaded = await storage.loadTasks();
      expect(loaded, isEmpty);
    });

    test('clears saved tasks', () async {
      await storage.saveTasks([Task(title: 'To delete')]);
      expect((await storage.loadTasks()).length, 1);

      await storage.clearAllTasks();
      expect(await storage.loadTasks(), isEmpty);
    });
  });
}
