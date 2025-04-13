import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/stats_card.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<TaskProvider>(context).tasks;
    final completedTasks = tasks.where((task) => task.isCompleted).length;
    final totalTasks = tasks.length;
    final completionPercentage = totalTasks > 0 
        ? (completedTasks / totalTasks * 100).round() 
        : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistiques'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StatsCard(
              title: 'Progression',
              value: '$completionPercentage%',
              description: 'Tâches complétées: $completedTasks/$totalTasks',
            ),
            const SizedBox(height: 20),
            // Graphique simplifié avec des widgets Flutter natifs
            Container(
              height: 200,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: completedTasks,
                    child: Container(
                      color: Colors.green,
                      alignment: Alignment.center,
                      child: Text('$completedTasks', style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                  Expanded(
                    flex: totalTasks - completedTasks,
                    child: Container(
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: Text('${totalTasks - completedTasks}', style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Complétées', style: TextStyle(color: Colors.green)),
                  Text('Non complétées', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
