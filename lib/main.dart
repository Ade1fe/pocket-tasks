import 'package:flutter/material.dart';
import 'package:pocket_tasks/providers/task_provider.dart';
import 'package:pocket_tasks/providers/theme_provider.dart';
import 'package:pocket_tasks/screens/task_list_screen.dart';
import 'package:pocket_tasks/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const PocketTasksApp());
}

class PocketTasksApp extends StatelessWidget {
  const PocketTasksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Pocket Tasks',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const TaskListScreen(),
          );
        },
      ),
    );
  }
}
