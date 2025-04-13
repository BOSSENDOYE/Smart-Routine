import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import 'task_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  TaskFilter _filter = TaskFilter.all;

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<TaskProvider>(context).tasks;
    final filteredTasks = _applyFilter(tasks);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des tâches'),
        actions: [
          PopupMenuButton<TaskFilter>(
            onSelected: (filter) => setState(() => _filter = filter),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: TaskFilter.all,
                child: Text('Toutes'),
              ),
              const PopupMenuItem(
                value: TaskFilter.completed,
                child: Text('Terminées'),
              ),
              const PopupMenuItem(
                value: TaskFilter.pending,
                child: Text('Non terminées'),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredTasks.length,
        itemBuilder: (ctx, index) {
          final task = filteredTasks[index];
          return ListTile(
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (value) => _toggleTaskCompletion(task),
            ),
            title: Text(task.title),
            subtitle: Text(task.description),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _confirmDelete(task),
            ),
            onTap: () => _editTask(task),
          );
        },
      ),
    );
  }

  List<Task> _applyFilter(List<Task> tasks) {
    switch (_filter) {
      case TaskFilter.completed:
        return tasks.where((task) => task.isCompleted).toList();
      case TaskFilter.pending:
        return tasks.where((task) => !task.isCompleted).toList();
      case TaskFilter.all:
      default:
        return tasks;
    }
  }

  void _toggleTaskCompletion(Task task) {
    Provider.of<TaskProvider>(context, listen: false)
        .toggleTaskCompletion(task.id);
  }

  void _confirmDelete(Task task) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmer la suppression'),
        content: Text('Supprimer "${task.title}" ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false)
                  .removeTask(task.id);
              Navigator.pop(ctx);
            },
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }

  void _editTask(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskScreen(editingTask: task),
      ),
    );
  }
}

enum TaskFilter { all, completed, pending }
