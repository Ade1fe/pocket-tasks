import 'package:flutter/material.dart';
import 'package:pocket_tasks/models/tasks.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/task_provider.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;

  const TaskListItem({super.key, required this.task, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOverdue =
        task.dueDate != null &&
        task.dueDate!.isBefore(DateTime.now()) &&
        !task.isCompleted;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _buildCheckbox(context),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(theme),
                    if (task.note.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      _buildNote(theme),
                    ],
                    if (task.dueDate != null) ...[
                      const SizedBox(height: 8),
                      _buildDueDate(theme, isOverdue),
                    ],
                  ],
                ),
              ),
              _buildTrailingIcon(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckbox(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<TaskProvider>().toggleTaskCompletion(task.id);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: task.isCompleted
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
            width: 2,
          ),
          color: task.isCompleted
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
        ),
        child: task.isCompleted
            ? Icon(
                Icons.check,
                size: 16,
                color: Theme.of(context).colorScheme.onPrimary,
              )
            : null,
      ),
    );
  }

  Widget _buildTitle(ThemeData theme) {
    return Text(
      task.title,
      style: theme.textTheme.titleMedium?.copyWith(
        decoration: task.isCompleted ? TextDecoration.lineThrough : null,
        color: task.isCompleted
            ? theme.colorScheme.outline
            : theme.colorScheme.onSurface,
      ),
    );
  }

  Widget _buildNote(ThemeData theme) {
    return Text(
      task.note,
      style: theme.textTheme.bodySmall?.copyWith(
        color: task.isCompleted
            ? theme.colorScheme.outline
            : theme.colorScheme.onSurfaceVariant,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDueDate(ThemeData theme, bool isOverdue) {
    final dateText = DateFormat('MMM dd, yyyy').format(task.dueDate!);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isOverdue
            ? theme.colorScheme.errorContainer
            : task.isCompleted
            ? theme.colorScheme.surfaceContainerHighest
            : theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isOverdue ? Icons.warning : Icons.calendar_today,
            size: 12,
            color: isOverdue
                ? theme.colorScheme.onErrorContainer
                : task.isCompleted
                ? theme.colorScheme.onSurfaceVariant
                : theme.colorScheme.onPrimaryContainer,
          ),
          const SizedBox(width: 4),
          Text(
            dateText,
            style: theme.textTheme.labelSmall?.copyWith(
              color: isOverdue
                  ? theme.colorScheme.onErrorContainer
                  : task.isCompleted
                  ? theme.colorScheme.onSurfaceVariant
                  : theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrailingIcon(ThemeData theme) {
    return Icon(Icons.chevron_right, color: theme.colorScheme.outline);
  }
}
