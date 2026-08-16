import 'package:flutter/material.dart';

class AddEditTaskScreen extends StatefulWidget {
  final String? oldTask;

  const AddEditTaskScreen({
    super.key,
    this.oldTask,
  });

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final TextEditingController taskController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // If editing, show old task in TextField
    if (widget.oldTask != null) {
      taskController.text = widget.oldTask!;
    }
  }

  void saveTask() {
    String task = taskController.text.trim();

    if (task.isNotEmpty) {
      Navigator.pop(context, task);
    }
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = widget.oldTask != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Task' : 'Add Task',
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: isEditing
                    ? 'Edit your task'
                    : 'Enter task',
                border: const OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveTask,
                child: Text(
                  isEditing ? 'Update Task' : 'Save Task',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}