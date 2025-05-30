import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/task.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksData = prefs.getString('tasks');
    if (tasksData != null) {
      final List decoded = jsonDecode(tasksData);
      setState(() => tasks = decoded.map((e) => Task.fromMap(e)).toList());
    }
  }

  void saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('tasks', jsonEncode(tasks.map((t) => t.toMap()).toList()));
  }

  void addTask(String title) {
    setState(() {
      tasks.add(Task(title: title));
      saveTasks();
      controller.clear();
    });
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
      saveTasks();
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
      saveTasks();
    });
  }

  void showAddDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Add Task"),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: "Task title"),
        ),
        actions: [
          TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  addTask(controller.text);
                }
                Navigator.pop(context);
              },
              child: Text("Add"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Tasks"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: showAddDialog,
          ),
        ],
      ),
      body: tasks.isEmpty
          ? Center(child: Text("No tasks yet."))
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (_, i) => TaskTile(
          title: tasks[i].title,
          isDone: tasks[i].isDone,
          onTap: () => toggleTask(i),
          onDelete: () => deleteTask(i),
        ),
      ),
    );
  }
}
