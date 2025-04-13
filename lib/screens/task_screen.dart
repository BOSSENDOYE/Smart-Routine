import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskScreen extends StatefulWidget {
  final Task? editingTask;

  const TaskScreen({Key? key, this.editingTask}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    if (widget.editingTask != null) {
      _titleController.text = widget.editingTask!.title;
      _descriptionController.text = widget.editingTask!.description;
      _selectedDate = widget.editingTask!.date;
      _selectedTime = widget.editingTask!.notificationTime;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      final task = Task(
        id: widget.editingTask?.id ?? DateTime.now().toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        date: _selectedDate!,
        notificationTime: _selectedTime,
        isCompleted: widget.editingTask?.isCompleted ?? false,
      );

      if (widget.editingTask != null) {
        Provider.of<TaskProvider>(context, listen: false).updateTask(task);
      } else {
        Provider.of<TaskProvider>(context, listen: false).addTask(task);
      }
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editingTask != null ? 'Modifier tâche' : 'Ajouter une tâche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Titre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(_selectedDate == null
                      ? 'Aucune date sélectionnée'
                      : 'Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Choisir une date'),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(_selectedTime == null
                      ? 'Aucune heure sélectionnée'
                      : 'Heure: ${_selectedTime!.format(context)}'),
                  TextButton(
                    onPressed: () => _selectTime(context),
                    child: const Text('Choisir une heure'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTask,
                child: Text(widget.editingTask != null ? 'Mettre à jour' : 'Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
