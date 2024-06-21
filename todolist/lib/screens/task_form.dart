import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/tasks_provider.dart';
import '../services/auth_service.dart';
import 'package:uuid/uuid.dart';

class TaskForm extends StatefulWidget {
  final Task? task;

  TaskForm({this.task});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  Priority _priority = Priority.normal;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _name = widget.task!.name;
      _priority = widget.task!.priority;
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var uuid = Uuid();
      final userId = (await AuthService().getUserData())?['id'];
      Task newTask = widget.task != null
          ? widget.task!
              .copyWith(name: _name, priority: _priority, userId: userId)
          : Task(
              id: uuid.v4(),
              name: _name,
              completed: false,
              priority: _priority,
              userId: userId);
      if (widget.task != null) {
        await Provider.of<TasksProvider>(context, listen: false)
            .updateTask(newTask);
      } else {
        await Provider.of<TasksProvider>(context, listen: false)
            .addTask(newTask);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(widget.task != null ? 'Edit Task' : 'New Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<Priority>(
                value: _priority,
                decoration: InputDecoration(labelText: 'Priority'),
                onChanged: (Priority? newValue) {
                  setState(() {
                    _priority = newValue!;
                  });
                },
                items: Priority.values.map((Priority classType) {
                  return DropdownMenuItem<Priority>(
                    value: classType,
                    child: Text(classType.toString().split('.').last),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
