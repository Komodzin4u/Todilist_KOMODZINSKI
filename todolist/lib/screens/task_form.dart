import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/tasks_provider.dart';

enum FormMode { Add, Edit }

class TaskForm extends StatefulWidget {
  final FormMode formMode;
  final Task? task;

  const TaskForm({Key? key, required this.formMode, this.task})
      : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  late String _content;
  late bool _completed;

  @override
  void initState() {
    super.initState();
    if (widget.formMode == FormMode.Edit && widget.task != null) {
      _content = widget.task!.name;
      _completed = widget.task!.completed;
    } else {
      _content = '';
      _completed = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _content,
                decoration: InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.task),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  _content = value!;
                },
              ),
              SizedBox(height: 16),
              if (widget.formMode == FormMode.Edit)
                CheckboxListTile(
                  title: Text('Completed'),
                  value: _completed,
                  onChanged: (bool? value) {
                    setState(() {
                      _completed = value!;
                    });
                  },
                ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (widget.formMode == FormMode.Add) {
                      Provider.of<TasksProvider>(context, listen: false)
                          .createNewTask(
                              Task(name: _content, priority: Priority.normal));
                    } else {
                      widget.task!.name = _content;
                      widget.task!.completed = _completed;
                      Provider.of<TasksProvider>(context, listen: false)
                          .updateTask(widget.task!);
                    }
                    Navigator.of(context).pop();
                    Provider.of<TasksProvider>(context, listen: false)
                        .notifyListeners();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: Text(
                    widget.formMode == FormMode.Add ? 'Add Task' : 'Edit Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
