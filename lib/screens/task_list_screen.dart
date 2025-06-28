import 'package:flutter/material.dart';
import 'package:pocket_tasks/screens/add_and_edit_task_screen.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/task_list_item.dart';
import '../widgets/task_stats_card.dart';
import '../widgets/filter_chips.dart';
// import 'add_edit_task_screen.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pocket Tasks'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              final themeProvider = context.read<ThemeProvider>();
              final taskProvider = context.read<TaskProvider>();

              switch (value) {
                case 'theme':
                  themeProvider.toggleTheme();
                  break;
                case 'sort_due':
                  taskProvider.setSort(TaskSort.dueDate);
                  break;
                case 'sort_created':
                  taskProvider.setSort(TaskSort.createdDate);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'theme',
                child: Row(
                  children: [
                    Icon(Icons.brightness_6),
                    SizedBox(width: 8),
                    Text('Toggle Theme'),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'sort_due',
                child: Row(
                  children: [
                    Icon(Icons.event),
                    SizedBox(width: 8),
                    Text('Sort by Due Date'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'sort_created',
                child: Row(
                  children: [
                    Icon(Icons.access_time),
                    SizedBox(width: 8),
                    Text('Sort by Created Date'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          if (taskProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              const TaskStatsCard(),
              const FilterChips(),
              Expanded(
                child: taskProvider.tasks.isEmpty
                    ? _buildEmptyState(context)
                    : _buildTaskList(taskProvider.tasks),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddTask(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'No tasks yet',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to add your first task',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList(List tasks) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskListItem(
          task: tasks[index],
          onTap: () => _navigateToEditTask(context, tasks[index]),
        );
      },
    );
  }

  void _navigateToAddTask(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const AddAndEditTaskScreen()),
    );
  }

  void _navigateToEditTask(BuildContext context, task) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddAndEditTaskScreen(task: task)),
    );
  }
}
