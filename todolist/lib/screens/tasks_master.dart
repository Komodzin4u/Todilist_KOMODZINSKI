import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tasks_provider.dart';
import '../models/task.dart';
import '../widgets/task_preview.dart';
import 'task_form.dart';

class TasksMaster extends StatefulWidget {
  @override
  _TasksMasterState createState() => _TasksMasterState();
}

class _TasksMasterState extends State<TasksMaster> {
  @override
  void initState() {
    super.initState();
    Provider.of<TasksProvider>(context, listen: false).fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Consumer<TasksProvider>(
        builder: (context, tasksProvider, child) {
          if (tasksProvider.tasks.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: tasksProvider.tasks.length,
              itemBuilder: (context, index) {
                return TaskPreview(task: tasksProvider.tasks[index]);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Task? newTask = await showDialog<Task>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Add New Task'),
                content: TaskForm(
                  formMode: FormMode.Add,
                ),
              );
            },
          );

          if (newTask != null) {
            Provider.of<TasksProvider>(context, listen: false).addTask(newTask);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
