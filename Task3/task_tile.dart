import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final bool isDone;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  TaskTile({
    required this.title,
    required this.isDone,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            decoration: isDone ? TextDecoration.lineThrough : null),
      ),
      leading: Checkbox(value: isDone, onChanged: (_) => onTap()),
      trailing: IconButton(icon: Icon(Icons.delete), onPressed: onDelete),
    );
  }
}
