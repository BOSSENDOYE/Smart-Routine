import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Function(bool?) onCheckboxChanged;

  const TaskTile(this.task, {required this.onCheckboxChanged, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: onCheckboxChanged,
      ),
      onTap: () {
        // Navigation vers l'écran de détail
      },
    );
  }
}
