import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/stats_card.dart';
import 'task_list_screen.dart';
import 'stats_screen.dart';
import 'settings_screen.dart';
import 'task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<TaskProvider>(context).tasks;
    final completedTasks = tasks.where((task) => task.isCompleted).length;
    final totalTasks = tasks.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Routine'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StatsScreen()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          StatsCard(
            title: 'Progression',
            value: '${totalTasks > 0 ? (completedTasks/totalTasks*100).toStringAsFixed(0) : 0}%',
            description: '$completedTasks/$totalTasks tâches complétées',
          ),
          const Expanded(
            child: TaskListScreen(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TaskScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
