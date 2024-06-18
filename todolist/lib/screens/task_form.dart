import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';

enum FormMode { Add, Edit }

class TaskForm extends StatefulWidget {
  final FormMode formMode;
  final Task? task;

  TaskForm({required this.formMode, this.task});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  String _content = '';
  bool _completed = false;
  final Uuid uuid = Uuid();

  @override
  void initState() {
    super.initState();
    if (widget.formMode == FormMode.Edit && widget.task != null) {
      _content = widget.task!.content;
      _completed = widget.task!.completed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            initialValue: _content,
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
          if (widget.formMode == FormMode.Edit)
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
                Task task = Task(
                  id: widget.task?.id ?? uuid.v4(),
                  userId: widget.task?.userId ??
                      'test_user', // Remplacez par une valeur appropriée
                  content: _content,
                  completed: _completed,
                );
                Navigator.pop(
                    context, task); // Retourner la tâche créée ou modifiée
              }
            },
            child: Text(
                widget.formMode == FormMode.Add ? 'Add Task' : 'Update Task'),
          ),
        ],
      ),
    );
  }
}
