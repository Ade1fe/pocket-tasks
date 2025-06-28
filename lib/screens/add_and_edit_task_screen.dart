import 'package:flutter/material.dart';
import 'package:pocket_tasks/models/tasks.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
// import '../models/task.dart';
import '../providers/task_provider.dart';

class AddAndEditTaskScreen extends StatefulWidget {
  final Task? task;

  const AddAndEditTaskScreen({super.key, this.task});

  @override
  State<AddAndEditTaskScreen> createState() => _AddAndEditTaskScreenState();
}

class _AddAndEditTaskScreenState extends State<AddAndEditTaskScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  DateTime? _selectedDueDate;
  bool _isCompleted = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  bool get isEditing => widget.task != null;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    if (isEditing) {
      _titleController.text = widget.task!.title;
      _noteController.text = widget.task!.note;
      _selectedDueDate = widget.task!.dueDate;
      _isCompleted = widget.task!.isCompleted;
    }

    _animationController.forward();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Task' : 'Add Task'),
        actions: [
          if (isEditing)
            IconButton(icon: const Icon(Icons.delete), onPressed: _deleteTask),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildTitleField(),
              const SizedBox(height: 16),
              _buildNoteField(),
              const SizedBox(height: 16),
              _buildDueDateField(),
              if (isEditing) ...[
                const SizedBox(height: 16),
                _buildCompletedSwitch(),
              ],
              const SizedBox(height: 32),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: _titleController,
      decoration: const InputDecoration(
        labelText: 'Task Title',
        hintText: 'Enter task title',
        prefixIcon: Icon(Icons.title),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter a task title';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildNoteField() {
    return TextFormField(
      controller: _noteController,
      decoration: const InputDecoration(
        labelText: 'Note (Optional)',
        hintText: 'Add a note for this task',
        prefixIcon: Icon(Icons.note),
      ),
      maxLines: 3,
      textInputAction: TextInputAction.newline,
    );
  }

  Widget _buildDueDateField() {
    return InkWell(
      onTap: _selectDueDate,
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Due Date (Optional)',
          prefixIcon: Icon(Icons.calendar_today),
          suffixIcon: Icon(Icons.arrow_drop_down),
        ),
        child: Text(
          _selectedDueDate != null
              ? DateFormat('MMM dd, yyyy').format(_selectedDueDate!)
              : 'Select due date',
          style: TextStyle(
            color: _selectedDueDate != null
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildCompletedSwitch() {
    return Card(
      child: SwitchListTile(
        title: const Text('Mark as Completed'),
        subtitle: Text(_isCompleted ? 'Task is completed' : 'Task is pending'),
        value: _isCompleted,
        onChanged: (value) {
          setState(() {
            _isCompleted = value;
          });
        },
        secondary: Icon(
          _isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: _isCompleted
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.outline,
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return FilledButton.icon(
      onPressed: _saveTask,
      icon: const Icon(Icons.save),
      label: Text(isEditing ? 'Update Task' : 'Save Task'),
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  Future<void> _selectDueDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        _selectedDueDate = picked;
      });
    }
  }

  void _saveTask() {
    if (!_formKey.currentState!.validate()) return;

    final taskProvider = context.read<TaskProvider>();

    if (isEditing) {
      final updatedTask = widget.task!.copyWith(
        title: _titleController.text.trim(),
        note: _noteController.text.trim(),
        dueDate: _selectedDueDate,
        isCompleted: _isCompleted,
      );
      taskProvider.updateTask(updatedTask);
    } else {
      final newTask = Task(
        title: _titleController.text.trim(),
        note: _noteController.text.trim(),
        dueDate: _selectedDueDate,
      );
      taskProvider.addTask(newTask);
    }

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isEditing ? 'Task updated!' : 'Task added!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _deleteTask() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              context.read<TaskProvider>().deleteTask(widget.task!.id);
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Close screen

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Task deleted!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
