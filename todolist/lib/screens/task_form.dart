import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class TaskForm extends StatefulWidget {
  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  String _content = '';
  bool _completed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Content'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some content';
                  }
                  return null;
                },
                onSaved: (value) {
                  _content = value ?? '';
                },
              ),
              CheckboxListTile(
                title: Text('Completed'),
                value: _completed,
                onChanged: (bool? value) {
                  setState(() {
                    _completed = value ?? false;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Task newTask = Task(
                      userId:
                          'test_user', // Remplacez par une valeur appropriée
                      content: _content,
                      completed: _completed,
                    );
                    TaskService().createTask(newTask);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tâche crée')),
                    );
                    Navigator.pop(context,
                        true); // Retourner true pour indiquer que la tâche a été créée
                  }
                },
                child: Text('Valider'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
