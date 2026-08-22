import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_edit_task_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<String> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  // Load tasks from local storage
  Future<void> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      tasks = prefs.getStringList('tasks') ?? [];
    });
  }

  // Save tasks to local storage
  Future<void> saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('tasks', tasks);
  }

  // Add task
  Future<void> addTask() async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddEditTaskScreen(),
      ),
    );

    if (newTask != null && newTask.toString().trim().isNotEmpty) {
      setState(() {
        tasks.add(newTask);
      });

      await saveTasks();
    }
  }

  // Edit task
  Future<void> editTask(int index) async {
    final editedTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditTaskScreen(
          oldTask: tasks[index],
        ),
      ),
    );

    if (editedTask != null && editedTask.toString().trim().isNotEmpty) {
      setState(() {
        tasks[index] = editedTask;
      });

      await saveTasks();
    }
  }

  // Delete task
  Future<void> deleteTask(int index) async {
    setState(() {
      tasks.removeAt(index);
    });

    await saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todo List'),
        centerTitle: true,
      ),

      body: tasks.isEmpty
          ? const Center(
              child: Text(
                'No tasks yet to be assgined',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.task_alt),

                    title: Text(tasks[index]),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Edit button
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            editTask(index);
                          },
                        ),

                        // Delete button
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            deleteTask(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
// Stored tasks as clean String list without heavy model wrapper

// SharedPreferences loadTasks and saveTasks synchronization
