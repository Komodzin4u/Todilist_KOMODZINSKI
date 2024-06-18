import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskDetails extends StatefulWidget {
  final Task task;

  TaskDetails({required this.task});

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la tâche'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Contenu: ${widget.task.content}'),
            SizedBox(height: 8),
            Text('Complété?: ${widget.task.completed ? "Oui" : "Non"}'),
          ],
        ),
      ),
    );
  }
}
