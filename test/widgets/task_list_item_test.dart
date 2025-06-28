import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_tasks/models/tasks.dart';
import 'package:provider/provider.dart';
import 'package:pocket_tasks/widgets/task_list_item.dart';
import 'package:pocket_tasks/providers/task_provider.dart';

void main() {
  group('TaskListItem', () {
    Widget wrap(Widget child) {
      return MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => TaskProvider(),
          child: Scaffold(body: child),
        ),
      );
    }

    testWidgets('displays title and note', (tester) async {
      final task = Task(title: 'Test Task', note: 'Test Note');

      await tester.pumpWidget(wrap(TaskListItem(task: task)));

      expect(find.text('Test Task'), findsOneWidget);
      expect(find.text('Test Note'), findsOneWidget);
    });

    testWidgets('shows check icon if completed', (tester) async {
      final task = Task(title: 'Done', isCompleted: true);

      await tester.pumpWidget(wrap(TaskListItem(task: task)));

      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('displays due date if present', (tester) async {
      final task = Task(title: 'Task', dueDate: DateTime(2024, 12, 25));

      await tester.pumpWidget(wrap(TaskListItem(task: task)));

      expect(find.text('Dec 25, 2024'), findsOneWidget);
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    });

    testWidgets('triggers onTap callback', (tester) async {
      var tapped = false;
      final task = Task(title: 'Tap me');

      await tester.pumpWidget(
        wrap(TaskListItem(task: task, onTap: () => tapped = true)),
      );

      await tester.tap(find.byType(TaskListItem));
      expect(tapped, true);
    });
  });
}
