import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class FilterChips extends StatelessWidget {
  const FilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildFilterChip(
                context,
                'All',
                TaskFilter.all,
                taskProvider.currentFilter,
                taskProvider.setFilter,
              ),
              const SizedBox(width: 8),
              _buildFilterChip(
                context,
                'Active',
                TaskFilter.active,
                taskProvider.currentFilter,
                taskProvider.setFilter,
              ),
              const SizedBox(width: 8),
              _buildFilterChip(
                context,
                'Completed',
                TaskFilter.completed,
                taskProvider.currentFilter,
                taskProvider.setFilter,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    String label,
    TaskFilter filter,
    TaskFilter currentFilter,
    Function(TaskFilter) onSelected,
  ) {
    final isSelected = filter == currentFilter;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(filter),
      showCheckmark: false,
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      labelStyle: TextStyle(
        color: isSelected
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Theme.of(context).colorScheme.onSurfaceVariant,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }
}
