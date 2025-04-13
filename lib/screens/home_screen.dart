import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/stats_card.dart';
import 'task_list_screen.dart';
import 'stats_screen.dart';
import 'settings_screen.dart';
import 'task_screen.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 4, size.height - 20, size.width / 2, size.height - 10);
    path.quadraticBezierTo(3 / 4 * size.width, size.height, size.width, size.height - 15);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

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
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade900, Color(0xFF191970)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade800.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.home_filled, color: Colors.white, size: 28),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bienvenue dans',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                        const Text(
                          'Smart Routine',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '"Organisez votre journée, maximisez votre productivité"',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: 20,
              color: Color(0xFF191970).withOpacity(0.1),
            ),
          ),
          const SizedBox(height: 8),
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
